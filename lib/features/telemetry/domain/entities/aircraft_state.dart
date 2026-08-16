/// Aircraft telemetry state domain entity.
///
/// Represents the current state of an aircraft at a given instant.
/// Updated by the telemetry pipeline (GPS, AHRS, ADS-B).
library;

import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

/// Source of telemetry data.
enum TelemetrySource {
  /// USB GPS receiver (NMEA).
  gps,

  /// AHRS (Attitude/Heading Reference System).
  ahrs,

  /// Wi-Fi EFB device (GDL90 protocol).
  gdl90,

  /// Bluetooth Low Energy (BLE) cockpit device.
  bluetooth,

  /// Simulated data (for development).
  simulated,

  /// No source connected.
  none,
}

/// Real-time aircraft state.
class AircraftState extends Equatable {
  const AircraftState({
    required this.position,
    required this.timestamp,
    required this.source,
    this.altitudeMslFt = 0,
    this.altitudeAglFt,
    this.groundSpeedKts = 0,
    this.trueAirspeedKts,
    this.trackTrue = 0,
    this.headingTrue,
    this.headingMagnetic,
    this.verticalSpeedFpm = 0,
    this.pitchDeg,
    this.rollDeg,
    this.hdop,
    this.satelliteCount,
  });

  /// Current geographic position.
  final LatLng position;

  /// Altitude above mean sea level in feet.
  final double altitudeMslFt;

  /// Altitude above ground level in feet (computed from terrain data).
  final double? altitudeAglFt;

  /// Ground speed in knots.
  final double groundSpeedKts;

  /// True airspeed in knots (from pitot-static or calculated).
  final double? trueAirspeedKts;

  /// Ground track (true) in degrees [0, 360).
  final double trackTrue;

  /// Heading (true) in degrees [0, 360).
  final double? headingTrue;

  /// Heading (magnetic) in degrees [0, 360).
  final double? headingMagnetic;

  /// Vertical speed in feet per minute (+up, -down).
  final double verticalSpeedFpm;

  /// Pitch angle in degrees (+nose up).
  final double? pitchDeg;

  /// Roll angle in degrees (+right wing down).
  final double? rollDeg;

  /// Timestamp of this telemetry sample.
  final DateTime timestamp;

  /// Source of this telemetry data.
  final TelemetrySource source;

  /// Horizontal dilution of precision (GPS accuracy indicator).
  final double? hdop;

  /// Number of satellites in view.
  final int? satelliteCount;

  /// Whether GPS data is considered reliable.
  bool get isGpsReliable =>
      source != TelemetrySource.none && (hdop == null || hdop! < 5.0);

  /// Age of this telemetry data.
  Duration get age => DateTime.now().difference(timestamp);

  /// Whether this data is considered stale (>5 seconds old).
  bool get isStale => age.inSeconds > 5;

  /// Returns a new instance with updated fields.
  AircraftState copyWith({
    LatLng? position,
    double? altitudeMslFt,
    double? altitudeAglFt,
    double? groundSpeedKts,
    double? trueAirspeedKts,
    double? trackTrue,
    double? headingTrue,
    double? headingMagnetic,
    double? verticalSpeedFpm,
    double? pitchDeg,
    double? rollDeg,
    DateTime? timestamp,
    TelemetrySource? source,
    double? hdop,
    int? satelliteCount,
  }) {
    return AircraftState(
      position: position ?? this.position,
      altitudeMslFt: altitudeMslFt ?? this.altitudeMslFt,
      altitudeAglFt: altitudeAglFt ?? this.altitudeAglFt,
      groundSpeedKts: groundSpeedKts ?? this.groundSpeedKts,
      trueAirspeedKts: trueAirspeedKts ?? this.trueAirspeedKts,
      trackTrue: trackTrue ?? this.trackTrue,
      headingTrue: headingTrue ?? this.headingTrue,
      headingMagnetic: headingMagnetic ?? this.headingMagnetic,
      verticalSpeedFpm: verticalSpeedFpm ?? this.verticalSpeedFpm,
      pitchDeg: pitchDeg ?? this.pitchDeg,
      rollDeg: rollDeg ?? this.rollDeg,
      timestamp: timestamp ?? this.timestamp,
      source: source ?? this.source,
      hdop: hdop ?? this.hdop,
      satelliteCount: satelliteCount ?? this.satelliteCount,
    );
  }

  @override
  List<Object?> get props => [position, altitudeMslFt, timestamp, source];
}
