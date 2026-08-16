import 'package:equatable/equatable.dart';

/// Real-time flight telemetry received from a cockpit BLE device.
///
/// Contains the full range of avionics data that cockpit instruments can
/// broadcast over Bluetooth. Any field may be null if the connected device
/// does not provide that particular measurement.
class CockpitTelemetry extends Equatable {
  const CockpitTelemetry({
    required this.timestamp,
    required this.sourceDeviceId,
    this.indicatedAirspeedKnots,
    this.trueAirspeedKnots,
    this.groundSpeedKnots,
    this.altitudeMslFeet,
    this.altitudeAglFeet,
    this.verticalSpeedFpm,
    this.headingMagneticDeg,
    this.headingTrueDeg,
    this.trackTrueDeg,
    this.pitchDeg,
    this.rollDeg,
    this.yawDeg,
    this.windSpeedKnots,
    this.windDirectionDeg,
    this.outsideAirTempC,
    this.fuelFlowGph,
    this.fuelRemainingGallons,
    this.engineRpm,
    this.manifoldPressureInHg,
    this.oilTempC,
    this.oilPressurePsi,
    this.egtDegC,
    this.chtDegC,
    this.latitude,
    this.longitude,
    this.gForce,
    this.barometerInHg,
  });

  // ── Airspeed ──

  /// Indicated Airspeed in knots (from pitot tube).
  final double? indicatedAirspeedKnots;

  /// True Airspeed in knots (corrected for altitude & temperature).
  final double? trueAirspeedKnots;

  /// Ground Speed in knots (from GPS).
  final double? groundSpeedKnots;

  // ── Altitude ──

  /// Altitude above Mean Sea Level in feet.
  final double? altitudeMslFeet;

  /// Altitude above Ground Level in feet.
  final double? altitudeAglFeet;

  /// Vertical speed in feet per minute (+up, −down).
  final double? verticalSpeedFpm;

  // ── Heading / Attitude ──

  /// Magnetic heading in degrees [0, 360).
  final double? headingMagneticDeg;

  /// True heading in degrees [0, 360).
  final double? headingTrueDeg;

  /// GPS ground track (true) in degrees [0, 360).
  final double? trackTrueDeg;

  /// Pitch angle in degrees (+nose up).
  final double? pitchDeg;

  /// Roll angle in degrees (+right wing down).
  final double? rollDeg;

  /// Yaw angle in degrees.
  final double? yawDeg;

  // ── Wind ──

  /// Wind speed in knots.
  final double? windSpeedKnots;

  /// Wind direction (from) in degrees [0, 360).
  final double? windDirectionDeg;

  // ── Environment ──

  /// Outside Air Temperature in °C.
  final double? outsideAirTempC;

  /// Barometric pressure in inches of mercury.
  final double? barometerInHg;

  // ── Engine ──

  /// Fuel flow in gallons per hour.
  final double? fuelFlowGph;

  /// Remaining fuel in gallons.
  final double? fuelRemainingGallons;

  /// Engine RPM.
  final double? engineRpm;

  /// Manifold pressure in inches of mercury.
  final double? manifoldPressureInHg;

  /// Oil temperature in °C.
  final double? oilTempC;

  /// Oil pressure in PSI.
  final double? oilPressurePsi;

  /// Exhaust Gas Temperature in °C.
  final double? egtDegC;

  /// Cylinder Head Temperature in °C.
  final double? chtDegC;

  // ── Position (may supplement/override GPS) ──

  /// Latitude from cockpit GPS.
  final double? latitude;

  /// Longitude from cockpit GPS.
  final double? longitude;

  // ── Forces ──

  /// G-force (1.0 = level flight).
  final double? gForce;

  // ── Metadata ──

  /// Timestamp of this telemetry sample.
  final DateTime timestamp;

  /// Device ID that sent this data.
  final String sourceDeviceId;

  /// Whether this telemetry contains any usable flight data.
  bool get hasFlightData =>
      groundSpeedKnots != null ||
      altitudeMslFeet != null ||
      headingMagneticDeg != null ||
      headingTrueDeg != null;

  /// Whether this telemetry contains wind data.
  bool get hasWindData =>
      windSpeedKnots != null && windDirectionDeg != null;

  /// Whether this telemetry contains engine data.
  bool get hasEngineData =>
      engineRpm != null || fuelFlowGph != null;

  CockpitTelemetry copyWith({
    double? indicatedAirspeedKnots,
    double? trueAirspeedKnots,
    double? groundSpeedKnots,
    double? altitudeMslFeet,
    double? altitudeAglFeet,
    double? verticalSpeedFpm,
    double? headingMagneticDeg,
    double? headingTrueDeg,
    double? trackTrueDeg,
    double? pitchDeg,
    double? rollDeg,
    double? yawDeg,
    double? windSpeedKnots,
    double? windDirectionDeg,
    double? outsideAirTempC,
    double? fuelFlowGph,
    double? fuelRemainingGallons,
    double? engineRpm,
    double? manifoldPressureInHg,
    double? oilTempC,
    double? oilPressurePsi,
    double? egtDegC,
    double? chtDegC,
    double? latitude,
    double? longitude,
    double? gForce,
    double? barometerInHg,
    DateTime? timestamp,
    String? sourceDeviceId,
  }) {
    return CockpitTelemetry(
      indicatedAirspeedKnots:
          indicatedAirspeedKnots ?? this.indicatedAirspeedKnots,
      trueAirspeedKnots: trueAirspeedKnots ?? this.trueAirspeedKnots,
      groundSpeedKnots: groundSpeedKnots ?? this.groundSpeedKnots,
      altitudeMslFeet: altitudeMslFeet ?? this.altitudeMslFeet,
      altitudeAglFeet: altitudeAglFeet ?? this.altitudeAglFeet,
      verticalSpeedFpm: verticalSpeedFpm ?? this.verticalSpeedFpm,
      headingMagneticDeg: headingMagneticDeg ?? this.headingMagneticDeg,
      headingTrueDeg: headingTrueDeg ?? this.headingTrueDeg,
      trackTrueDeg: trackTrueDeg ?? this.trackTrueDeg,
      pitchDeg: pitchDeg ?? this.pitchDeg,
      rollDeg: rollDeg ?? this.rollDeg,
      yawDeg: yawDeg ?? this.yawDeg,
      windSpeedKnots: windSpeedKnots ?? this.windSpeedKnots,
      windDirectionDeg: windDirectionDeg ?? this.windDirectionDeg,
      outsideAirTempC: outsideAirTempC ?? this.outsideAirTempC,
      fuelFlowGph: fuelFlowGph ?? this.fuelFlowGph,
      fuelRemainingGallons:
          fuelRemainingGallons ?? this.fuelRemainingGallons,
      engineRpm: engineRpm ?? this.engineRpm,
      manifoldPressureInHg:
          manifoldPressureInHg ?? this.manifoldPressureInHg,
      oilTempC: oilTempC ?? this.oilTempC,
      oilPressurePsi: oilPressurePsi ?? this.oilPressurePsi,
      egtDegC: egtDegC ?? this.egtDegC,
      chtDegC: chtDegC ?? this.chtDegC,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      gForce: gForce ?? this.gForce,
      barometerInHg: barometerInHg ?? this.barometerInHg,
      timestamp: timestamp ?? this.timestamp,
      sourceDeviceId: sourceDeviceId ?? this.sourceDeviceId,
    );
  }

  @override
  List<Object?> get props => [
        indicatedAirspeedKnots,
        trueAirspeedKnots,
        groundSpeedKnots,
        altitudeMslFeet,
        verticalSpeedFpm,
        headingMagneticDeg,
        windSpeedKnots,
        windDirectionDeg,
        engineRpm,
        timestamp,
        sourceDeviceId,
      ];
}
