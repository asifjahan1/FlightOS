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

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        altitudeMslFeet,
        groundSpeedKnots,
        trueTrack,
        accuracyMeters,
      ];
}
