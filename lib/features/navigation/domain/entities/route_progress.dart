import 'package:equatable/equatable.dart';
import 'package:skynav/features/flight_plan/domain/entities/waypoint.dart';

/// Represents the current progress along an active flight plan route.
class RouteProgress extends Equatable {
  const RouteProgress({
    required this.currentLegIndex,
    required this.distanceToNextWaypointNm,
    required this.etaToNextWaypointMinutes,
    required this.crossTrackErrorNm,
    this.nextWaypoint,
  });

  /// The index of the current leg in the flight plan.
  /// A leg is defined from waypoints[i] to waypoints[i+1].
  final int currentLegIndex;

  /// Distance remaining to the next waypoint in Nautical Miles.
  final double distanceToNextWaypointNm;

  /// Estimated time enroute to the next waypoint in minutes.
  final double etaToNextWaypointMinutes;

  /// The lateral deviation from the desired track in Nautical Miles.
  /// Positive means right of track, negative means left of track.
  final double crossTrackErrorNm;

  /// The upcoming waypoint.
  final Waypoint? nextWaypoint;

  @override
  List<Object?> get props => [
        currentLegIndex,
        distanceToNextWaypointNm,
        etaToNextWaypointMinutes,
        crossTrackErrorNm,
        nextWaypoint,
      ];
}
