/// Navigation domain entities: Waypoint, RouteLeg, FlightRoute.
library;

import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

/// Classification of waypoint types in the navigation system.
enum WaypointType {
  /// Full airport with metadata.
  airport,

  /// Navaid (VOR, NDB, DME, etc.).
  navaid,

  /// Named intersection/fix.
  fix,

  /// Pilot-created custom waypoint.
  userDefined,

  /// Raw GPS coordinate.
  gpsCoordinate,
}

/// A waypoint in the navigation system.
class Waypoint extends Equatable {
  const Waypoint({
    required this.id,
    required this.name,
    required this.type,
    required this.position,
    this.elevation,
    this.magneticVariation,
    this.metadata,
  });

  /// Unique identifier.
  final String id;

  /// Display name (e.g., 'KJFK', 'JFK VOR', 'BRAVO INTERSECTION').
  final String name;

  /// Waypoint classification.
  final WaypointType type;

  /// Geographic position.
  final LatLng position;

  /// Elevation in feet MSL (if known).
  final double? elevation;

  /// Local magnetic variation in degrees.
  final double? magneticVariation;

  /// Additional metadata (frequencies, runway info, etc.).
  final Map<String, dynamic>? metadata;

  @override
  List<Object?> get props => [id, name, type, position];
}

/// A single leg of a flight route (from one waypoint to the next).
class RouteLeg extends Equatable {
  const RouteLeg({
    required this.from,
    required this.to,
    required this.distanceNm,
    required this.trueCourse,
    required this.magneticCourse,
    required this.ete,
    this.fuelGallons = 0,
    this.altitude,
  });

  /// Departure waypoint.
  final Waypoint from;

  /// Arrival waypoint.
  final Waypoint to;

  /// Leg distance in nautical miles.
  final double distanceNm;

  /// True course in degrees.
  final double trueCourse;

  /// Magnetic course in degrees.
  final double magneticCourse;

  /// Estimated time enroute for this leg.
  final Duration ete;

  /// Estimated fuel burn in gallons for this leg.
  final double fuelGallons;

  /// Planned altitude for this leg in feet MSL.
  final double? altitude;

  @override
  List<Object?> get props => [from, to, distanceNm, trueCourse];
}

/// A complete flight route consisting of ordered legs.
class FlightRoute extends Equatable {
  const FlightRoute({
    required this.id,
    required this.name,
    required this.legs,
    this.description,
    this.aircraftProfileId,
    this.createdAt,
    this.updatedAt,
  });

  /// Unique identifier.
  final String id;

  /// Route name (e.g., 'KJFK to KLAX').
  final String name;

  /// Optional description.
  final String? description;

  /// Ordered list of route legs.
  final List<RouteLeg> legs;

  /// Associated aircraft profile for fuel/performance.
  final String? aircraftProfileId;

  /// Creation timestamp.
  final DateTime? createdAt;

  /// Last modification timestamp.
  final DateTime? updatedAt;

  /// Total route distance in nautical miles.
  double get totalDistanceNm =>
      legs.fold(0, (sum, leg) => sum + leg.distanceNm);

  /// Total estimated time enroute.
  Duration get totalEte =>
      legs.fold(Duration.zero, (sum, leg) => sum + leg.ete);

  /// Total estimated fuel burn in gallons.
  double get totalFuelGallons =>
      legs.fold(0, (sum, leg) => sum + leg.fuelGallons);

  /// All waypoints in route order (including first and last).
  List<Waypoint> get waypoints {
    if (legs.isEmpty) return [];
    return [
      legs.first.from,
      ...legs.map((leg) => leg.to),
    ];
  }

  /// Departure waypoint.
  Waypoint? get departure => legs.isNotEmpty ? legs.first.from : null;

  /// Arrival waypoint.
  Waypoint? get arrival => legs.isNotEmpty ? legs.last.to : null;

  @override
  List<Object?> get props => [id, name, legs];
}
