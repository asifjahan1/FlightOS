/// Low-level Bluetooth Low Energy service wrapping [flutter_blue_plus].
///
/// This service handles all platform-specific BLE operations and provides
/// clean Dart streams to the repository layer. It manages:
/// - Adapter state monitoring (on/off)
/// - Scanning with duplicate filtering
/// - Connection lifecycle with auto-reconnect
/// - Service/characteristic discovery
/// - Notification subscriptions for real-time data
library;

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:injectable/injectable.dart';

import 'package:skynav/features/bluetooth/domain/entities/ble_connection_state.dart'
    as domain;
import 'package:skynav/features/bluetooth/domain/entities/bluetooth_device_entity.dart';

/// Wraps [flutter_blue_plus] into a testable service with clean abstractions.
@lazySingleton
class BleService {
  BleService();

  BluetoothDevice? _connectedDevice;
  BluetoothCharacteristic? _dataCharacteristic;
  BluetoothCharacteristic? _writeCharacteristic;

  StreamSubscription<BluetoothConnectionState>? _connectionSub;
  StreamSubscription<List<int>>? _notifySub;

  final StreamController<domain.BleConnectionState> _connectionStateController =
      StreamController<domain.BleConnectionState>.broadcast();

  final StreamController<List<int>> _rawDataController =
      StreamController<List<int>>.broadcast();

  /// Stream of connection state changes.
  Stream<domain.BleConnectionState> get connectionStateStream =>
      _connectionStateController.stream;

  /// Stream of raw bytes received from the connected device's notify
  /// characteristic.
  Stream<List<int>> get rawDataStream => _rawDataController.stream;

  /// Whether BLE is supported on the current platform.
  bool get isBleSupported {
    if (kIsWeb) return true; // Web Bluetooth API (limited)
    if (Platform.isAndroid ||
        Platform.isIOS ||
        Platform.isMacOS ||
        Platform.isLinux) {
      return true;
    }
    return false; // Windows — not yet supported
  }

  /// Whether the Bluetooth adapter is currently on.
  Future<bool> get isAdapterOn async {
    if (!isBleSupported) return false;
    try {
      final state = FlutterBluePlus.adapterStateNow;
      return state == BluetoothAdapterState.on;
    } catch (_) {
      return false;
    }
  }

  /// Starts scanning for BLE devices.
  ///
  /// Returns a stream of all discovered devices (accumulated, not
  /// incremental). The scan stops automatically after [timeout].
  Stream<List<BluetoothDeviceEntity>> scanForDevices({
    Duration timeout = const Duration(seconds: 10),
  }) {
    if (!isBleSupported) return Stream.value([]);

    final controller = StreamController<List<BluetoothDeviceEntity>>();
    final discovered = <String, BluetoothDeviceEntity>{};

    _connectionStateController.add(domain.BleConnectionState.scanning);

    StreamSubscription<List<ScanResult>>? scanSub;

    controller.onListen = () {
      try {
        FlutterBluePlus.startScan(
          timeout: timeout,
          androidUsesFineLocation: true,
        );

        scanSub = FlutterBluePlus.scanResults.listen(
          (results) {
            for (final r in results) {
              final entity = BluetoothDeviceEntity(
                id: r.device.remoteId.str,
                name: r.device.platformName,
                rssi: r.rssi,
                isConnected: false,
                serviceUuids: r.advertisementData.serviceUuids
                    .map((e) => e.str)
                    .toList(),
                lastSeen: DateTime.now(),
              );
              discovered[entity.id] = entity;
            }
            controller.add(discovered.values.toList());
          },
          onError: (Object e) {
            debugPrint('BLE scan error: $e');
          },
        );

        // Auto-stop after timeout
        Future<void>.delayed(timeout).then((_) {
          if (!controller.isClosed) {
            _connectionStateController
                .add(domain.BleConnectionState.disconnected);
          }
        });
      } catch (e) {
        debugPrint('BLE scan start error: $e');
        _connectionStateController.add(domain.BleConnectionState.error);
      }
    };

    controller.onCancel = () {
      scanSub?.cancel();
      try {
        FlutterBluePlus.stopScan();
      } catch (_) {}
      controller.close();
    };

    return controller.stream;
  }

  /// Stops any ongoing scan.
  Future<void> stopScan() async {
    try {
      await FlutterBluePlus.stopScan();
    } catch (_) {}
  }

  /// Connects to a BLE device and discovers services.
  ///
  /// After connecting, it looks for a suitable data characteristic
  /// (one with notify/indicate) and subscribes to it. Data arrives
  /// on [rawDataStream].
  Future<void> connectToDevice(String deviceId) async {
    _connectionStateController.add(domain.BleConnectionState.connecting);

    try {
      // Stop scanning first
      await stopScan();

      final device = BluetoothDevice.fromId(deviceId);
      _connectedDevice = device;

      // Listen for connection state changes
      _connectionSub?.cancel();
      _connectionSub = device.connectionState.listen((state) {
        switch (state) {
          case BluetoothConnectionState.connected:
            _connectionStateController
                .add(domain.BleConnectionState.connected);
          case BluetoothConnectionState.disconnected:
            _connectionStateController
                .add(domain.BleConnectionState.disconnected);
            _handleDisconnection();
        }
      });

      // Connect with auto-connect disabled for faster initial connection
      await device.connect(
        license: License.nonprofit,
        autoConnect: false,
        timeout: const Duration(seconds: 15),
      );

      // Discover services and find data characteristics
      await _discoverAndSubscribe(device);

      _connectionStateController.add(domain.BleConnectionState.connected);
    } catch (e) {
      debugPrint('BLE connection error: $e');
      _connectionStateController.add(domain.BleConnectionState.error);
      rethrow;
    }
  }

  /// Discovers services on the connected device and subscribes to the
  /// first characteristic that supports notify or indicate.
  Future<void> _discoverAndSubscribe(BluetoothDevice device) async {
    final services = await device.discoverServices();

    for (final service in services) {
      for (final char in service.characteristics) {
        // Find a characteristic that supports notifications (data read)
        if (_dataCharacteristic == null &&
            (char.properties.notify || char.properties.indicate)) {
          _dataCharacteristic = char;

          // Enable notifications
          await char.setNotifyValue(true);

          // Listen to incoming data
          _notifySub?.cancel();
          _notifySub = char.lastValueStream.listen(
            (value) {
              if (value.isNotEmpty) {
                _rawDataController.add(value);
              }
            },
            onError: (Object e) {
              debugPrint('BLE notify error: $e');
            },
          );
        }

        // Find a characteristic that supports write (for commands)
        if (_writeCharacteristic == null &&
            (char.properties.write || char.properties.writeWithoutResponse)) {
          _writeCharacteristic = char;
        }
      }
    }

    if (_dataCharacteristic == null) {
      debugPrint(
        'WARNING: No notify/indicate characteristic found on device. '
        'Data streaming will not work.',
      );
    }
  }

  /// Handles unexpected disconnection — cleans up subscriptions.
  void _handleDisconnection() {
    _notifySub?.cancel();
    _notifySub = null;
    _dataCharacteristic = null;
    _writeCharacteristic = null;
  }

  /// Disconnects from the currently connected device.
  Future<void> disconnectDevice() async {
    _connectionStateController.add(domain.BleConnectionState.disconnecting);

    try {
      _notifySub?.cancel();
      _notifySub = null;
      _dataCharacteristic = null;
      _writeCharacteristic = null;

      if (_connectedDevice != null) {
        await _connectedDevice!.disconnect();
      }
    } catch (_) {}

    _connectedDevice = null;
    _connectionStateController.add(domain.BleConnectionState.disconnected);
  }

  /// Writes raw bytes to the connected device's write characteristic.
  Future<void> writeCommand(List<int> bytes) async {
    if (_writeCharacteristic == null) {
      throw StateError('No write characteristic available.');
    }

    await _writeCharacteristic!.write(
      bytes,
      withoutResponse: _writeCharacteristic!.properties.writeWithoutResponse,
    );
  }

  /// The currently connected device (as a domain entity), or null.
  BluetoothDeviceEntity? get connectedDeviceEntity {
    if (_connectedDevice == null) return null;
    return BluetoothDeviceEntity(
      id: _connectedDevice!.remoteId.str,
      name: _connectedDevice!.platformName,
      rssi: 0, // RSSI not available when not scanning
      isConnected: true,
      lastSeen: DateTime.now(),
    );
  }

  /// Releases all resources.
  Future<void> dispose() async {
    await disconnectDevice();
    _connectionSub?.cancel();
    await _connectionStateController.close();
    await _rawDataController.close();
  }
}
