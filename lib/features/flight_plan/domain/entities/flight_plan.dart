import 'package:equatable/equatable.dart';
import 'package:skynav/core/utils/nav_math.dart';
import 'package:skynav/features/flight_plan/domain/entities/waypoint.dart';

/// Represents an active flight plan route.
class FlightPlan extends Equatable {
  const FlightPlan({
    required this.waypoints,
    this.cruiseSpeedKnots = 110.0,
    this.destination,
  });

  /// Ordered list of waypoints making up the route.
  final List<Waypoint> waypoints;

  /// Assumed cruise speed in knots (used for ETE calculation).
  final double cruiseSpeedKnots;

  /// The marked destination (Direct-To).
  final Waypoint? destination;

  /// Computes the total distance of the route in Nautical Miles.
  double get totalDistanceNm {
    if (waypoints.length < 2) return 0;

    var distance = 0.0;
    for (var i = 0; i < waypoints.length - 1; i++) {
      distance += NavMath.distanceNm(
        waypoints[i].latitude,
        waypoints[i].longitude,
        waypoints[i + 1].latitude,
        waypoints[i + 1].longitude,
      );
    }
    return distance;
  }

  /// Computes the Estimated Time Enroute (ETE) for the entire route in minutes.
  double get estimatedTimeEnrouteMinutes {
    if (cruiseSpeedKnots <= 0) return 0;
    return NavMath.calculateEteMinutes(totalDistanceNm, cruiseSpeedKnots);
  }

  FlightPlan copyWith({
    List<Waypoint>? waypoints,
    double? cruiseSpeedKnots,
    Waypoint? destination,
    bool clearDestination = false,
  }) {
    return FlightPlan(
      waypoints: waypoints ?? this.waypoints,
      cruiseSpeedKnots: cruiseSpeedKnots ?? this.cruiseSpeedKnots,
      destination: clearDestination ? null : (destination ?? this.destination),
    );
  }

  @override
  List<Object?> get props => [waypoints, cruiseSpeedKnots, destination];
}
