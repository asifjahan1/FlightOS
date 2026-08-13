import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:skynav/core/theme/app_theme.dart';
import 'package:skynav/core/utils/nav_math.dart';
import 'package:skynav/features/airport/domain/entities/airport.dart';
import 'package:skynav/features/airport/domain/repositories/airport_repository.dart';
import 'package:skynav/features/flight_plan/domain/entities/waypoint.dart';
import 'package:skynav/features/flight_plan/presentation/bloc/flight_plan_bloc.dart';
import 'package:skynav/features/telemetry/presentation/bloc/telemetry_bloc.dart';

class NearestAirportsPanel extends StatefulWidget {
  const NearestAirportsPanel({super.key});

  @override
  State<NearestAirportsPanel> createState() => _NearestAirportsPanelState();
}

class _NearestAirportsPanelState extends State<NearestAirportsPanel> {
  final AirportRepository _repository = GetIt.I<AirportRepository>();
  List<Airport> _nearestAirports = [];
  bool _isLoading = false;
  double? _lastLat;
  double? _lastLon;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TelemetryBloc, TelemetryState>(
      listener: (context, state) {
        if (state is TelemetryActive) {
          final lat = state.data.latitude;
          final lon = state.data.longitude;
          
          if (lat == 0 && lon == 0) return; // Ignore null island
          
          if (_lastLat == null || _lastLon == null) {
             _fetchNearest(lat, lon);
          } else {
             // Only fetch if moved more than 5 NM to save battery/DB
             final dist = NavMath.distanceNm(lat, lon, _lastLat!, _lastLon!);
             if (dist > 5.0) {
               _fetchNearest(lat, lon);
             }
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.error.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.error, width: 2),
          boxShadow: const [
            BoxShadow(color: Colors.black45, blurRadius: 10, offset: Offset(0, 4)),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Row(
              children: [
                Icon(Icons.warning, color: AppTheme.error),
                SizedBox(width: 8),
                Text(
                  'NEAREST AIRPORTS',
                  style: TextStyle(
                    color: AppTheme.error,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const Divider(color: AppTheme.error),
            if (_isLoading)
              const Center(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator(color: AppTheme.error)))
            else if (_nearestAirports.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text('No airports found nearby.', style: TextStyle(color: AppTheme.textPrimary)),
              )
            else
              ..._nearestAirports.map((airport) {
                final dist = NavMath.distanceNm(_lastLat ?? 0, _lastLon ?? 0, airport.latitude, airport.longitude);
                final bearing = NavMath.bearing(_lastLat ?? 0, _lastLon ?? 0, airport.latitude, airport.longitude);
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    '${airport.icao} - ${airport.name}',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '${dist.toStringAsFixed(1)} NM • ${bearing.round().toString().padLeft(3, '0')}° • ${airport.elevation.round()} ft',
                    style: const TextStyle(color: AppTheme.textSecondary),
                  ),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.error,
                      foregroundColor: AppTheme.textPrimary,
                    ),
                    child: const Text('NRST'),
                    onPressed: () {
                      final wp = Waypoint(
                        latitude: airport.latitude,
                        longitude: airport.longitude,
                        name: airport.icao,
                        elevation: airport.elevation,
                      );
                      context.read<FlightPlanBloc>().add(DestinationSet(wp));
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(content: Text('Direct-To ${airport.icao} (NRST)')),
                      );
                    },
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchNearest(double lat, double lon) async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      final airports = await _repository.getNearestAirports(lat, lon, 3);
      if (mounted) {
        setState(() {
          _nearestAirports = airports;
          _lastLat = lat;
          _lastLon = lon;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
