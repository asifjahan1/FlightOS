import 'package:equatable/equatable.dart';

/// Represents the real-time telemetry state of the aircraft.
class TelemetryData extends Equatable {
  const TelemetryData({
    required this.latitude,
    required this.longitude,
    required this.altitudeMslFeet,
    required this.groundSpeedKnots,
    required this.trueTrack,
    this.accuracyMeters,
    this.destinationLatitude,
    this.destinationLongitude,
  });

  /// Current latitude in degrees.
  final double latitude;

  /// Current longitude in degrees.
  final double longitude;

  /// Altitude Mean Sea Level in feet.
  final double altitudeMslFeet;

  /// Ground speed in knots.
  final double groundSpeedKnots;

  /// True track (heading) in degrees (0-360).
  final double trueTrack;

  /// GPS estimated accuracy in meters.
  final double? accuracyMeters;

  /// Destination latitude in degrees.
  final double? destinationLatitude;

  /// Destination longitude in degrees.
  final double? destinationLongitude;

  TelemetryData copyWith({
    double? latitude,
    double? longitude,
    double? altitudeMslFeet,
    double? groundSpeedKnots,
    double? trueTrack,
    double? accuracyMeters,
    double? destinationLatitude,
    double? destinationLongitude,
    bool clearDestination = false,
  }) {
    return TelemetryData(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      altitudeMslFeet: altitudeMslFeet ?? this.altitudeMslFeet,
      groundSpeedKnots: groundSpeedKnots ?? this.groundSpeedKnots,
      trueTrack: trueTrack ?? this.trueTrack,
      accuracyMeters: accuracyMeters ?? this.accuracyMeters,
      destinationLatitude: clearDestination
          ? null
          : (destinationLatitude ?? this.destinationLatitude),
      destinationLongitude: clearDestination
          ? null
          : (destinationLongitude ?? this.destinationLongitude),
    );
  }

  @override
  List<Object?> get props => [
    latitude,
    longitude,
    altitudeMslFeet,
    groundSpeedKnots,
    trueTrack,
    accuracyMeters,
    destinationLatitude,
    destinationLongitude,
  ];
}
