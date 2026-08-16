import 'dart:async';

import 'package:injectable/injectable.dart';

import 'package:skynav/features/bluetooth/data/parsers/ble_data_parser.dart';
import 'package:skynav/features/bluetooth/data/services/ble_service.dart';
import 'package:skynav/features/bluetooth/domain/entities/ble_connection_state.dart';
import 'package:skynav/features/bluetooth/domain/entities/bluetooth_device_entity.dart';
import 'package:skynav/features/bluetooth/domain/entities/cockpit_telemetry.dart';
import 'package:skynav/features/bluetooth/domain/repositories/bluetooth_repository.dart';

/// Concrete [BluetoothRepository] implementation.
///
/// Combines [BleService] (low-level BLE operations) with [AutoDetectParser]
/// (protocol detection & parsing) to deliver parsed [CockpitTelemetry]
/// objects to the presentation layer.
@LazySingleton(as: BluetoothRepository)
class BluetoothRepositoryImpl implements BluetoothRepository {
  BluetoothRepositoryImpl(this._bleService);

  final BleService _bleService;
  final AutoDetectParser _parser = AutoDetectParser();

  StreamSubscription<List<int>>? _rawDataSub;
  final StreamController<CockpitTelemetry> _cockpitDataController =
      StreamController<CockpitTelemetry>.broadcast();

  /// The last successfully parsed telemetry — used to merge partial updates.
  CockpitTelemetry? _lastTelemetry;

  @override
  bool get isBleSupported => _bleService.isBleSupported;

  @override
  Future<bool> get isAdapterOn => _bleService.isAdapterOn;

  @override
  BluetoothDeviceEntity? get connectedDevice =>
      _bleService.connectedDeviceEntity;

  @override
  Stream<BleConnectionState> get connectionStateStream =>
      _bleService.connectionStateStream;

  @override
  Stream<CockpitTelemetry> get cockpitDataStream =>
      _cockpitDataController.stream;

  @override
  Stream<List<BluetoothDeviceEntity>> scanForDevices({
    Duration timeout = const Duration(seconds: 10),
  }) {
    return _bleService.scanForDevices(timeout: timeout);
  }

  @override
  Future<void> stopScan() => _bleService.stopScan();

  @override
  Future<void> connectToDevice(String deviceId) async {
    await _bleService.connectToDevice(deviceId);

    // Start listening to raw BLE data and parsing it
    _rawDataSub?.cancel();
    _rawDataSub = _bleService.rawDataStream.listen(_onRawData);
  }

  @override
  Future<void> disconnectDevice() async {
    _rawDataSub?.cancel();
    _rawDataSub = null;
    _lastTelemetry = null;
    await _bleService.disconnectDevice();
  }

  @override
  Future<void> writeCommand(List<int> bytes) =>
      _bleService.writeCommand(bytes);

  @override
  Future<void> dispose() async {
    _rawDataSub?.cancel();
    await _cockpitDataController.close();
    await _bleService.dispose();
  }

  /// Handles raw bytes from BLE — parses and emits [CockpitTelemetry].
  void _onRawData(List<int> rawBytes) {
    final deviceId = connectedDevice?.id ?? 'unknown';
    final parsed = _parser.parse(rawBytes, deviceId);

    if (parsed == null) return;

    // Merge with the last telemetry to build a complete picture.
    // Some protocols send partial data (e.g., GDL90 ownship report only
    // contains position but not wind), so we merge fields.
    _lastTelemetry = _mergeTelemetry(_lastTelemetry, parsed);
    _cockpitDataController.add(_lastTelemetry!);
  }

  /// Merges a new partial telemetry sample with the previous complete state.
  ///
  /// New non-null fields overwrite old values; old fields are preserved
  /// if the new sample doesn't include them.
  CockpitTelemetry _mergeTelemetry(
    CockpitTelemetry? previous,
    CockpitTelemetry incoming,
  ) {
    if (previous == null) return incoming;

    return CockpitTelemetry(
      indicatedAirspeedKnots:
          incoming.indicatedAirspeedKnots ?? previous.indicatedAirspeedKnots,
      trueAirspeedKnots:
          incoming.trueAirspeedKnots ?? previous.trueAirspeedKnots,
      groundSpeedKnots:
          incoming.groundSpeedKnots ?? previous.groundSpeedKnots,
      altitudeMslFeet: incoming.altitudeMslFeet ?? previous.altitudeMslFeet,
      altitudeAglFeet: incoming.altitudeAglFeet ?? previous.altitudeAglFeet,
      verticalSpeedFpm:
          incoming.verticalSpeedFpm ?? previous.verticalSpeedFpm,
      headingMagneticDeg:
          incoming.headingMagneticDeg ?? previous.headingMagneticDeg,
      headingTrueDeg: incoming.headingTrueDeg ?? previous.headingTrueDeg,
      trackTrueDeg: incoming.trackTrueDeg ?? previous.trackTrueDeg,
      pitchDeg: incoming.pitchDeg ?? previous.pitchDeg,
      rollDeg: incoming.rollDeg ?? previous.rollDeg,
      yawDeg: incoming.yawDeg ?? previous.yawDeg,
      windSpeedKnots: incoming.windSpeedKnots ?? previous.windSpeedKnots,
      windDirectionDeg:
          incoming.windDirectionDeg ?? previous.windDirectionDeg,
      outsideAirTempC: incoming.outsideAirTempC ?? previous.outsideAirTempC,
      fuelFlowGph: incoming.fuelFlowGph ?? previous.fuelFlowGph,
      fuelRemainingGallons:
          incoming.fuelRemainingGallons ?? previous.fuelRemainingGallons,
      engineRpm: incoming.engineRpm ?? previous.engineRpm,
      manifoldPressureInHg:
          incoming.manifoldPressureInHg ?? previous.manifoldPressureInHg,
      oilTempC: incoming.oilTempC ?? previous.oilTempC,
      oilPressurePsi: incoming.oilPressurePsi ?? previous.oilPressurePsi,
      egtDegC: incoming.egtDegC ?? previous.egtDegC,
      chtDegC: incoming.chtDegC ?? previous.chtDegC,
      latitude: incoming.latitude ?? previous.latitude,
      longitude: incoming.longitude ?? previous.longitude,
      gForce: incoming.gForce ?? previous.gForce,
      barometerInHg: incoming.barometerInHg ?? previous.barometerInHg,
      timestamp: incoming.timestamp,
      sourceDeviceId: incoming.sourceDeviceId,
    );
  }
}
