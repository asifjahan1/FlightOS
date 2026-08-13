import 'package:skynav/features/flight_plan/domain/entities/flight_plan.dart';
import 'package:skynav/features/navigation/domain/entities/route_progress.dart';
import 'package:skynav/features/telemetry/domain/entities/telemetry_data.dart';

/// Service responsible for calculating navigation metrics and route progress.
abstract class NavigationService {
  /// Calculates the current progress along the [flightPlan] based on the
  /// aircraft's current [telemetry].
  ///
  /// Returns null if the flight plan has fewer than 2 waypoints or 
  /// the progress cannot be determined.
  RouteProgress? calculateProgress({
    required FlightPlan flightPlan,
    required TelemetryData telemetry,
    int previousLegIndex = 0,
  });
}
