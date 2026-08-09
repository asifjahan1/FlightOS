library;

import 'package:equatable/equatable.dart';

/// Represents the real-time state of an aircraft from OpenSky Network.
class AircraftState extends Equatable {
  /// The 24-bit ICAO transponder ID (unique).
  final String icao24;

  /// Callsign (e.g., "DAL123").
  final String callsign;

  /// Origin country of the aircraft.
  final String originCountry;

  /// Timestamp of the last position update.
  final int timePosition;

  /// Last known contact time.
  final int lastContact;

  /// Longitude.
  final double longitude;

  /// Latitude.
  final double latitude;

  /// Barometric altitude in meters.
  final double? baroAltitude;

  /// True track (heading) in degrees (0 = North).
  final double trueTrack;

  /// Velocity (speed) in m/s.
  final double velocity;

  /// Vertical rate in m/s (positive = climbing).
  final double? verticalRate;

  /// Whether the aircraft is on the ground.
  final bool onGround;

  /// Geometric altitude in meters.
  final double? geoAltitude;

  const AircraftState({
    required this.icao24,
    required this.callsign,
    required this.originCountry,
    required this.timePosition,
    required this.lastContact,
    required this.longitude,
    required this.latitude,
    this.baroAltitude,
    required this.trueTrack,
    required this.velocity,
    this.verticalRate,
    required this.onGround,
    this.geoAltitude,
  });

  /// Factory to parse from the OpenSky state vector array.
  /// https://openskynetwork.github.io/opensky-api/rest.html
  factory AircraftState.fromOpenSky(List<dynamic> data) {
    return AircraftState(
      icao24: data[0]?.toString() ?? '',
      callsign: data[1]?.toString().trim() ?? 'UNKNOWN',
      originCountry: data[2]?.toString() ?? '',
      timePosition: data[3] as int? ?? 0,
      lastContact: data[4] as int? ?? 0,
      longitude: (data[5] as num?)?.toDouble() ?? 0.0,
      latitude: (data[6] as num?)?.toDouble() ?? 0.0,
      baroAltitude: (data[7] as num?)?.toDouble(),
      onGround: data[8] as bool? ?? false,
      velocity: (data[9] as num?)?.toDouble() ?? 0.0,
      trueTrack: (data[10] as num?)?.toDouble() ?? 0.0,
      verticalRate: (data[11] as num?)?.toDouble(),
      // 12 is sensors, 13 is geo_altitude
      geoAltitude: data.length > 13 ? (data[13] as num?)?.toDouble() : null,
    );
  }

  @override
  List<Object?> get props => [
    icao24,
    callsign,
    timePosition,
    longitude,
    latitude,
    baroAltitude,
    trueTrack,
    velocity,
    onGround,
  ];
}
