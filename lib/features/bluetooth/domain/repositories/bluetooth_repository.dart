import 'package:skynav/features/bluetooth/domain/entities/ble_connection_state.dart';
import 'package:skynav/features/bluetooth/domain/entities/bluetooth_device_entity.dart';
import 'package:skynav/features/bluetooth/domain/entities/cockpit_telemetry.dart';

/// Abstract repository for Bluetooth Low Energy (BLE) operations.
///
/// The domain and presentation layers depend on this interface, not on the
/// concrete [flutter_blue_plus] implementation. This allows:
/// - Unit testing with mock repositories
/// - Platform-specific implementations (real BLE vs. stub)
/// - Future migration to a different BLE plugin if needed
abstract class BluetoothRepository {
  /// Starts scanning for nearby BLE devices and emits discovered devices.
  ///
  /// The stream emits the full list of discovered devices (not incremental),
  /// updated each time a new device is found or an existing device's RSSI
  /// changes.
  Stream<List<BluetoothDeviceEntity>> scanForDevices({
    Duration timeout = const Duration(seconds: 10),
  });

  /// Stops any ongoing BLE scan.
  Future<void> stopScan();

  /// Connects to a BLE device by its [deviceId].
  ///
  /// After connecting, the repository automatically discovers services and
  /// subscribes to cockpit telemetry characteristics.
  Future<void> connectToDevice(String deviceId);

  /// Disconnects from the currently connected device.
  Future<void> disconnectDevice();

  /// Stream of real-time cockpit telemetry data from the connected device.
  ///
  /// Emits parsed [CockpitTelemetry] objects whenever new data arrives
  /// from the BLE characteristic notifications.
  Stream<CockpitTelemetry> get cockpitDataStream;

  /// Stream of BLE connection lifecycle state changes.
  Stream<BleConnectionState> get connectionStateStream;

  /// The currently connected device, or `null` if not connected.
  BluetoothDeviceEntity? get connectedDevice;

  /// Whether BLE is supported on the current platform.
  bool get isBleSupported;

  /// Whether the Bluetooth adapter is currently turned on.
  Future<bool> get isAdapterOn;

  /// Sends raw bytes to the connected device (for bidirectional comms).
  Future<void> writeCommand(List<int> bytes);

  /// Releases all resources (subscriptions, connections).
  Future<void> dispose();
}
