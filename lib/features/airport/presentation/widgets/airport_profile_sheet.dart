import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skynav/core/theme/app_theme.dart';
import 'package:skynav/features/airport/domain/entities/airport.dart';
import 'package:skynav/features/flight_plan/domain/entities/waypoint.dart';
import 'package:skynav/features/flight_plan/presentation/bloc/flight_plan_bloc.dart';
// import 'package:skynav/features/weather/domain/entities/weather_data.dart';
import 'package:skynav/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:skynav/features/weather/presentation/bloc/weather_state.dart';

class AirportProfileSheet extends StatelessWidget {
  const AirportProfileSheet({super.key, required this.airport});

  final Airport airport;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppTheme.backgroundPrimary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: AppTheme.backgroundSecondary,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.accentPrimary.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.local_airport,
                        color: AppTheme.accentPrimary,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            airport.icao,
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textPrimary,
                                ),
                          ),
                          Text(
                            airport.name,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(color: AppTheme.textSecondary),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: AppTheme.textSecondary,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),

              // Actions (Add to Route, Direct To)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.backgroundSecondary,
                          foregroundColor: AppTheme.textPrimary,
                        ),
                        icon: const Icon(Icons.add_location_alt),
                        label: const Text('Add to Route'),
                        onPressed: () {
                          final wp = Waypoint(
                            latitude: airport.latitude,
                            longitude: airport.longitude,
                            name: airport.icao,
                            elevation: airport.elevation,
                          );
                          context.read<FlightPlanBloc>().add(WaypointAdded(wp));
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Added ${airport.icao} to route'),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan.shade900,
                          foregroundColor: Colors.cyanAccent,
                        ),
                        icon: const Icon(Icons.flight_takeoff),
                        label: const Text('Direct-To'),
                        onPressed: () {
                          final wp = Waypoint(
                            latitude: airport.latitude,
                            longitude: airport.longitude,
                            name: airport.icao,
                            elevation: airport.elevation,
                          );
                          context.read<FlightPlanBloc>().add(
                            DestinationSet(wp),
                          );
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Direct-To ${airport.icao}'),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(color: AppTheme.border),

              // Details
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Information',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppTheme.accentPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _InfoRow(
                      label: 'Elevation',
                      value: '${airport.elevation.round()} ft MSL',
                    ),
                    if (airport.iata != null)
                      _InfoRow(label: 'IATA', value: airport.iata!),
                    if (airport.municipality != null)
                      _InfoRow(label: 'City', value: airport.municipality!),
                    _InfoRow(
                      label: 'Coordinates',
                      value:
                          '${airport.latitude.toStringAsFixed(4)}, ${airport.longitude.toStringAsFixed(4)}',
                    ),
                  ],
                ),
              ),

              const Divider(color: AppTheme.border),

              // Weather
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Weather (METAR/TAF)',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppTheme.accentPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    BlocBuilder<WeatherBloc, WeatherState>(
                      builder: (context, state) {
                        if (state is WeatherLoaded) {
                          final report = state.reports[airport.icao];
                          if (report != null) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _InfoRow(
                                  label: 'Flight Category',
                                  value: report.category.name.toUpperCase(),
                                ),
                                if (report.tempC != null)
                                  _InfoRow(
                                    label: 'Temperature',
                                    value: '${report.tempC!.round()}°C',
                                  ),
                                if (report.windSpeed != null)
                                  _InfoRow(
                                    label: 'Wind',
                                    value: '${report.windSpeed}kt',
                                  ),
                                const SizedBox(height: 8),
                                Text(
                                  report.rawMetar,
                                  style: const TextStyle(
                                    fontFamily: 'monospace',
                                    color: AppTheme.textSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const Text(
                              'No weather data available.',
                              style: TextStyle(color: AppTheme.textSecondary),
                            );
                          }
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ],
                ),
              ),

              const Divider(color: AppTheme.border),

              // Frequencies & Runways Placeholder
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Runways & Frequencies',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppTheme.accentPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Detailed runway and frequency data requires a premium aviation data subscription.',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                color: AppTheme.textTertiary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: AppTheme.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
