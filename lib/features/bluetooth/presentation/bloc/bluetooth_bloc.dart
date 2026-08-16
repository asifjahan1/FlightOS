import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:skynav/features/bluetooth/domain/entities/ble_connection_state.dart';
import 'package:skynav/features/bluetooth/domain/entities/bluetooth_device_entity.dart';
import 'package:skynav/features/bluetooth/domain/entities/cockpit_telemetry.dart';
import 'package:skynav/features/bluetooth/domain/repositories/bluetooth_repository.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Events
// ─────────────────────────────────────────────────────────────────────────────

sealed class BluetoothEvent extends Equatable {
  const BluetoothEvent();

  @override
  List<Object?> get props => [];
}

/// Initialize Bluetooth adapter and check platform support.
class BluetoothStarted extends BluetoothEvent {
  const BluetoothStarted();
}

/// User requested to start scanning for devices.
class BluetoothScanRequested extends BluetoothEvent {
  const BluetoothScanRequested();
}

/// User requested to stop scanning.
class BluetoothScanStopped extends BluetoothEvent {
  const BluetoothScanStopped();
}

/// User selected a device to connect to.
class BluetoothDeviceConnectRequested extends BluetoothEvent {
  const BluetoothDeviceConnectRequested(this.deviceId);
  final String deviceId;

  @override
  List<Object?> get props => [deviceId];
}

/// User requested to disconnect from the current device.
class BluetoothDisconnectRequested extends BluetoothEvent {
  const BluetoothDisconnectRequested();
}

/// Internal: cockpit telemetry data received from BLE.
class _CockpitDataReceived extends BluetoothEvent {
  const _CockpitDataReceived(this.data);
  final CockpitTelemetry data;

  @override
  List<Object?> get props => [data];
}

/// Internal: connection state changed.
class _ConnectionStateChanged extends BluetoothEvent {
  const _ConnectionStateChanged(this.connectionState);
  final BleConnectionState connectionState;

  @override
  List<Object?> get props => [connectionState];
}

/// Internal: scan results updated.
class _ScanResultsUpdated extends BluetoothEvent {
  const _ScanResultsUpdated(this.devices);
  final List<BluetoothDeviceEntity> devices;

  @override
  List<Object?> get props => [devices];
}

// ─────────────────────────────────────────────────────────────────────────────
// States
// ─────────────────────────────────────────────────────────────────────────────

sealed class BluetoothState extends Equatable {
  const BluetoothState();

  @override
  List<Object?> get props => [];
}

/// Initial state — not yet initialized.
class BluetoothInitial extends BluetoothState {
  const BluetoothInitial();
}

/// BLE is not supported on this platform.
class BluetoothUnsupported extends BluetoothState {
  const BluetoothUnsupported();
}

/// Bluetooth adapter is turned off.
class BluetoothAdapterOff extends BluetoothState {
  const BluetoothAdapterOff();
}

/// Ready to scan/connect — no active operation.
class BluetoothReady extends BluetoothState {
  const BluetoothReady();
}

/// Scanning for nearby BLE devices.
class BluetoothScanning extends BluetoothState {
  const BluetoothScanning({this.devices = const []});
  final List<BluetoothDeviceEntity> devices;

  @override
  List<Object?> get props => [devices];
}

/// Connecting to a specific device.
class BluetoothConnecting extends BluetoothState {
  const BluetoothConnecting({required this.device});
  final BluetoothDeviceEntity device;

  @override
  List<Object?> get props => [device];
}

/// Connected and receiving real-time cockpit data.
class BluetoothConnected extends BluetoothState {
  const BluetoothConnected({
    required this.device,
    this.cockpitData,
  });

  final BluetoothDeviceEntity device;
  final CockpitTelemetry? cockpitData;

  BluetoothConnected copyWith({
    BluetoothDeviceEntity? device,
    CockpitTelemetry? cockpitData,
  }) {
    return BluetoothConnected(
      device: device ?? this.device,
      cockpitData: cockpitData ?? this.cockpitData,
    );
  }

  @override
  List<Object?> get props => [device, cockpitData];
}

/// An error occurred.
class BluetoothError extends BluetoothState {
  const BluetoothError({required this.message, this.previousDevices});
  final String message;
  final List<BluetoothDeviceEntity>? previousDevices;

  @override
  List<Object?> get props => [message];
}

// ─────────────────────────────────────────────────────────────────────────────
// BLoC
// ─────────────────────────────────────────────────────────────────────────────

@injectable
class BluetoothBloc extends Bloc<BluetoothEvent, BluetoothState> {
  BluetoothBloc(this._repository) : super(const BluetoothInitial()) {
    on<BluetoothStarted>(_onStarted);
    on<BluetoothScanRequested>(_onScanRequested);
    on<BluetoothScanStopped>(_onScanStopped);
    on<BluetoothDeviceConnectRequested>(_onDeviceConnectRequested);
    on<BluetoothDisconnectRequested>(_onDisconnectRequested);
    on<_CockpitDataReceived>(_onCockpitDataReceived);
    on<_ConnectionStateChanged>(_onConnectionStateChanged);
    on<_ScanResultsUpdated>(_onScanResultsUpdated);
  }

  final BluetoothRepository _repository;

  StreamSubscription<CockpitTelemetry>? _cockpitDataSub;
  StreamSubscription<BleConnectionState>? _connectionStateSub;
  StreamSubscription<List<BluetoothDeviceEntity>>? _scanSub;

  // ── Event Handlers ──

  Future<void> _onStarted(
    BluetoothStarted event,
    Emitter<BluetoothState> emit,
  ) async {
    // Check platform support
    if (!_repository.isBleSupported) {
      emit(const BluetoothUnsupported());
      return;
    }

    // Check adapter state
    final adapterOn = await _repository.isAdapterOn;
    if (!adapterOn) {
      emit(const BluetoothAdapterOff());
      // Don't return — keep listening for state changes
    } else {
      emit(const BluetoothReady());
    }

    // Listen for connection state changes
    _connectionStateSub?.cancel();
    _connectionStateSub = _repository.connectionStateStream.listen(
      (state) => add(_ConnectionStateChanged(state)),
    );
  }

  Future<void> _onScanRequested(
    BluetoothScanRequested event,
    Emitter<BluetoothState> emit,
  ) async {
    emit(const BluetoothScanning());

    _scanSub?.cancel();
    _scanSub = _repository
        .scanForDevices(timeout: const Duration(seconds: 15))
        .listen(
      (devices) => add(_ScanResultsUpdated(devices)),
      onError: (Object e) {
        add(_ConnectionStateChanged(BleConnectionState.error));
      },
      onDone: () {
        // Scan finished — if still scanning, transition to ready
        if (state is BluetoothScanning) {
          add(const BluetoothScanStopped());
        }
      },
    );
  }

  void _onScanStopped(
    BluetoothScanStopped event,
    Emitter<BluetoothState> emit,
  ) {
    _scanSub?.cancel();
    _scanSub = null;
    _repository.stopScan();

    // Keep showing discovered devices in ready state
    if (state is BluetoothScanning) {
      final devices = (state as BluetoothScanning).devices;
      if (devices.isNotEmpty) {
        emit(BluetoothScanning(devices: devices));
      }
    }
    emit(const BluetoothReady());
  }

  void _onScanResultsUpdated(
    _ScanResultsUpdated event,
    Emitter<BluetoothState> emit,
  ) {
    emit(BluetoothScanning(devices: event.devices));
  }

  Future<void> _onDeviceConnectRequested(
    BluetoothDeviceConnectRequested event,
    Emitter<BluetoothState> emit,
  ) async {
    // Find the device entity from recent scan results
    BluetoothDeviceEntity? device;
    if (state is BluetoothScanning) {
      final devices = (state as BluetoothScanning).devices;
      try {
        device = devices.firstWhere((d) => d.id == event.deviceId);
      } catch (_) {
        // Not found in scan results — create a minimal entity
      }
    }

    device ??= BluetoothDeviceEntity(
      id: event.deviceId,
      name: '',
      rssi: 0,
      isConnected: false,
      lastSeen: DateTime.now(),
    );

    emit(BluetoothConnecting(device: device));

    try {
      await _repository.connectToDevice(event.deviceId);

      // Start listening for cockpit data
      _cockpitDataSub?.cancel();
      _cockpitDataSub = _repository.cockpitDataStream.listen(
        (data) => add(_CockpitDataReceived(data)),
      );

      final connectedDevice = _repository.connectedDevice ?? device;
      emit(BluetoothConnected(
        device: connectedDevice.copyWith(isConnected: true),
      ));
    } catch (e) {
      emit(BluetoothError(message: 'Connection failed: $e'));
    }
  }

  Future<void> _onDisconnectRequested(
    BluetoothDisconnectRequested event,
    Emitter<BluetoothState> emit,
  ) async {
    _cockpitDataSub?.cancel();
    _cockpitDataSub = null;

    await _repository.disconnectDevice();
    emit(const BluetoothReady());
  }

  void _onCockpitDataReceived(
    _CockpitDataReceived event,
    Emitter<BluetoothState> emit,
  ) {
    if (state is BluetoothConnected) {
      emit((state as BluetoothConnected).copyWith(
        cockpitData: event.data,
      ));
    }
  }

  void _onConnectionStateChanged(
    _ConnectionStateChanged event,
    Emitter<BluetoothState> emit,
  ) {
    switch (event.connectionState) {
      case BleConnectionState.disconnected:
        if (state is BluetoothConnected || state is BluetoothConnecting) {
          _cockpitDataSub?.cancel();
          _cockpitDataSub = null;
          emit(const BluetoothReady());
        }
      case BleConnectionState.error:
        if (state is! BluetoothUnsupported) {
          emit(const BluetoothError(message: 'Bluetooth connection lost'));
        }
      default:
        break; // Other states handled by explicit events
    }
  }

  @override
  Future<void> close() {
    _cockpitDataSub?.cancel();
    _connectionStateSub?.cancel();
    _scanSub?.cancel();
    return super.close();
  }
}
