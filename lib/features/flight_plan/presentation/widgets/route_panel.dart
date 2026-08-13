import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:skynav/core/theme/app_theme.dart';
import 'package:skynav/core/utils/nav_math.dart';
import 'package:skynav/features/flight_plan/presentation/bloc/flight_plan_bloc.dart';
import 'package:skynav/features/navigation/domain/entities/route_progress.dart';
import 'package:skynav/features/navigation/domain/services/navigation_service.dart';
import 'package:skynav/features/telemetry/presentation/bloc/telemetry_bloc.dart';

class RoutePanel extends StatefulWidget {
  const RoutePanel({super.key});

  @override
  State<RoutePanel> createState() => _RoutePanelState();
}

class _RoutePanelState extends State<RoutePanel> {
  final NavigationService _navService = GetIt.I<NavigationService>();
  int _currentLegIndex = 0;

  Widget build(BuildContext context) {
    return BlocBuilder<FlightPlanBloc, FlightPlanState>(
      builder: (context, state) {
        if (state is! FlightPlanActive || state.flightPlan.waypoints.isEmpty) {
          return const SizedBox.shrink(); // Hide if no plan
        }

        final plan = state.flightPlan;

        return BlocBuilder<TelemetryBloc, TelemetryState>(
          builder: (context, telemetryState) {
            double currentSpeed = plan.cruiseSpeedKnots;
            RouteProgress? progress;
            if (telemetryState is TelemetryActive) {
              if (telemetryState.data.groundSpeedKnots > 0) {
                currentSpeed = telemetryState.data.groundSpeedKnots;
              }

              progress = _navService.calculateProgress(
                flightPlan: plan,
                telemetry: telemetryState.data,
                previousLegIndex: _currentLegIndex,
              );

              if (progress != null) {
                // We don't setState here to avoid rebuild loops,
                // we just store the leg for the next build cycle/calculation
                _currentLegIndex = progress.currentLegIndex;
              }
            }

            final totalDistance = plan.totalDistanceNm;
            final eteMins = NavMath.calculateEteMinutes(
              totalDistance,
              currentSpeed,
            );
            final eteStr = NavMath.formatEteDh(eteMins);

            return Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.backgroundSecondary.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.border),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.route, color: AppTheme.accentPrimary),
                          SizedBox(width: 8),
                          Text(
                            'Active Route',
                            style: TextStyle(
                              color: AppTheme.textPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: AppTheme.textSecondary,
                        ),
                        onPressed: () => context.read<FlightPlanBloc>().add(
                          const FlightPlanCleared(),
                        ),
                        tooltip: 'Clear Route',
                      ),
                    ],
                  ),
                  const Divider(color: AppTheme.border),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: plan.waypoints.asMap().entries.map((entry) {
                      final isLast = entry.key == plan.waypoints.length - 1;
                      final isActive =
                          progress != null &&
                          entry.key == progress.currentLegIndex + 1;
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Chip(
                            label: Text(
                              entry.value.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isActive
                                    ? AppTheme.backgroundPrimary
                                    : AppTheme.textPrimary,
                              ),
                            ),
                            backgroundColor: isActive
                                ? AppTheme.accentPrimary
                                : AppTheme.backgroundSecondary,
                            side: const BorderSide(color: AppTheme.border),
                            deleteIcon: const Icon(Icons.close, size: 16),
                            onDeleted: () => context.read<FlightPlanBloc>().add(
                              WaypointRemoved(entry.key),
                            ),
                          ),
                          if (!isLast)
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                                color: AppTheme.textTertiary,
                              ),
                            ),
                        ],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      spacing: 16,
                      children: [
                        _Stat(
                          label: 'DIST',
                          value: '${totalDistance.toStringAsFixed(1)} NM',
                        ),
                        _Stat(label: 'ETE', value: eteStr),
                        if (progress != null) ...[
                          _Stat(
                            label: 'XTK',
                            value:
                                '${progress.crossTrackErrorNm.abs().toStringAsFixed(2)} ${progress.crossTrackErrorNm >= 0 ? 'R' : 'L'}',
                          ),
                          _Stat(
                            label: 'NEXT',
                            value:
                                '${progress.distanceToNextWaypointNm.toStringAsFixed(1)} NM',
                          ),
                        ] else
                          _Stat(
                            label: 'GS',
                            value: '${currentSpeed.round()} kt',
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textTertiary,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            color: AppTheme.accentPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
