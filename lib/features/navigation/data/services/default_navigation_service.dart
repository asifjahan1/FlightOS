import 'dart:math' as math;
import 'package:injectable/injectable.dart';
import 'package:skynav/core/utils/nav_math.dart';
import 'package:skynav/features/flight_plan/domain/entities/flight_plan.dart';
import 'package:skynav/features/navigation/domain/entities/route_progress.dart';
import 'package:skynav/features/navigation/domain/services/navigation_service.dart';
import 'package:skynav/features/telemetry/domain/entities/telemetry_data.dart';

@LazySingleton(as: NavigationService)
class DefaultNavigationService implements NavigationService {
  @override
  RouteProgress? calculateProgress({
    required FlightPlan flightPlan,
    required TelemetryData telemetry,
    int previousLegIndex = 0,
  }) {
    if (flightPlan.waypoints.length < 2) return null;

    final waypoints = flightPlan.waypoints;
    var currentLeg = previousLegIndex.clamp(0, waypoints.length - 2);
    
    final lat = telemetry.latitude;
    final lon = telemetry.longitude;
    
    // Check if we have passed the current destination waypoint (very simplified: within 1 NM)
    // A robust EFB would check if we crossed the bisector.
    var hasAdvanced = false;
    do {
      hasAdvanced = false;
      if (currentLeg < waypoints.length - 2) {
         final distToNext = NavMath.distanceNm(
            lat, lon, 
            waypoints[currentLeg + 1].latitude, 
            waypoints[currentLeg + 1].longitude,
         );
         if (distToNext < 1.0) { // Auto-advance if within 1 NM
            currentLeg++;
            hasAdvanced = true;
         }
      }
    } while (hasAdvanced);

    final nextWp = waypoints[currentLeg + 1];
    
    final distToNext = NavMath.distanceNm(
      lat, lon,
      nextWp.latitude, nextWp.longitude,
    );

    // XTK calculation (Cross-Track Error)
    // Formula: asin(sin(dist_AD) * sin(bearing_AD - bearing_AB)) * R
    // We'll use a simpler approximation for short distances:
    final wpA = waypoints[currentLeg];
    final wpB = nextWp;
    final bearingAB = NavMath.bearing(wpA.latitude, wpA.longitude, wpB.latitude, wpB.longitude);
    final bearingAD = NavMath.bearing(wpA.latitude, wpA.longitude, lat, lon);
    final distAD = NavMath.distanceNm(wpA.latitude, wpA.longitude, lat, lon);
    
    final bearingDiff = (bearingAD - bearingAB) * (math.pi / 180.0);
    // distance * sin(theta)
    final xtkNm = distAD * math.sin(bearingDiff);

    final speed = telemetry.groundSpeedKnots > 0 ? telemetry.groundSpeedKnots : flightPlan.cruiseSpeedKnots;
    final etaMins = NavMath.calculateEteMinutes(distToNext, speed);

    return RouteProgress(
      currentLegIndex: currentLeg,
      distanceToNextWaypointNm: distToNext,
      etaToNextWaypointMinutes: etaMins,
      crossTrackErrorNm: xtkNm,
      nextWaypoint: nextWp,
    );
  }
}
