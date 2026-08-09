import 'package:equatable/equatable.dart';

/// Represents an ADS-B traffic target (an aircraft nearby).
class TrafficTarget extends Equatable {
  const TrafficTarget({
    required this.icaoHex,
    required this.latitude,
    required this.longitude,
    required this.altitudeFeet,
    required this.groundSpeedKnots,
    required this.trackDegrees,
    this.callsign,
  });

  /// The unique ICAO 24-bit address (hex string).
  final String icaoHex;

  /// Latitude in degrees.
  final double latitude;

  /// Longitude in degrees.
  final double longitude;

  /// Altitude in feet MSL.
  final double altitudeFeet;

  /// Ground speed in knots.
  final double groundSpeedKnots;

  /// True track (heading) in degrees (0-360).
  final double trackDegrees;

  /// Flight callsign (e.g., 'UAE202'). Optional.
  final String? callsign;

  TrafficTarget copyWith({
    String? icaoHex,
    double? latitude,
    double? longitude,
    double? altitudeFeet,
    double? groundSpeedKnots,
    double? trackDegrees,
    String? callsign,
  }) {
    return TrafficTarget(
      icaoHex: icaoHex ?? this.icaoHex,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      altitudeFeet: altitudeFeet ?? this.altitudeFeet,
      groundSpeedKnots: groundSpeedKnots ?? this.groundSpeedKnots,
      trackDegrees: trackDegrees ?? this.trackDegrees,
      callsign: callsign ?? this.callsign,
    );
  }

  @override
  List<Object?> get props => [
    icaoHex,
    latitude,
    longitude,
    altitudeFeet,
    groundSpeedKnots,
    trackDegrees,
    callsign,
  ];
}
