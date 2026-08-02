import 'package:equatable/equatable.dart';

/// Represents a geographic waypoint in a flight plan.
class Waypoint extends Equatable {
  const Waypoint({
    required this.latitude,
    required this.longitude,
    required this.name,
    this.elevation,
  });

  /// Latitude of the waypoint.
  final double latitude;

  /// Longitude of the waypoint.
  final double longitude;

  /// Human-readable name (e.g., "KJFK" or "Custom").
  final String name;

  /// Optional elevation in feet.
  final double? elevation;

  @override
  List<Object?> get props => [latitude, longitude, name, elevation];
}
