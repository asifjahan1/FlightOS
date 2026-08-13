import 'package:flutter/material.dart';
import 'package:skynav/core/database/database.dart';
import 'package:skynav/features/airport/data/datasources/overpass_api_client.dart';
import 'package:skynav/features/airport/domain/entities/airport.dart';
import 'package:skynav/features/weather/presentation/widgets/weather_display_card.dart';
import 'package:skynav/injection.dart';

class AirportDetailsPanel extends StatefulWidget {
  const AirportDetailsPanel({super.key, required this.airport});
  final Airport airport;

  @override
  State<AirportDetailsPanel> createState() => _AirportDetailsPanelState();
}

class _AirportDetailsPanelState extends State<AirportDetailsPanel> {
  final OverpassApiClient _overpassApi = OverpassApiClient();
  final AppDatabase _db = sl<AppDatabase>();

  List<RunwayData>? _runways;
  List<String>? _facilities;

  @override
  void initState() {
    super.initState();
    _fetchDetails();
  }

  Future<void> _fetchDetails() async {
    // Fetch runways from local SQLite
    final airportEntry = await (_db.select(
      _db.airports,
    )..where((a) => a.icao.equals(widget.airport.icao))).getSingleOrNull();
    final runways = airportEntry != null
        ? await (_db.select(
            _db.runways,
          )..where((r) => r.airportIcao.equals(airportEntry.icao))).get()
        : <RunwayData>[];

    // Fetch facilities live from OSM
    final facilities = await _overpassApi.fetchAirportFacilities(
      widget.airport.latitude,
      widget.airport.longitude,
    );

    if (mounted) {
      setState(() {
        _runways = runways;
        _facilities = facilities;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${widget.airport.icao} - ${widget.airport.name}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            Text(
              "${widget.airport.municipality ?? 'Unknown City'}, ${widget.airport.countryCode}",
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // Runways
            Text('Runways', style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            if (_runways == null)
              const CircularProgressIndicator()
            else if (_runways!.isEmpty)
              const Text('No runway data.')
            else
              ..._runways!.map(
                (r) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.add_road),
                  title: Text('Rwy ${r.ident}'),
                  subtitle: Text(
                    "${r.length.round()} ft • ${r.surface ?? 'Unknown surface'}",
                  ),
                ),
              ),

            const SizedBox(height: 24),
            // Facilities
            Text('Facilities', style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            if (_facilities == null)
              const CircularProgressIndicator()
            else if (_facilities!.isEmpty)
              const Text('No facilities found nearby.')
            else
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: _facilities!
                    .map(
                      (f) => Chip(
                        label: Text(f, style: const TextStyle(fontSize: 12)),
                        backgroundColor: Colors.blueGrey.withValues(alpha: 0.2),
                      ),
                    )
                    .toList(),
              ),

            const SizedBox(height: 24),
            // Weather
            Text(
              'Weather Intelligence',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(),
            WeatherDisplayCard(icao: widget.airport.icao),
          ],
        ),
      ),
    );
  }
}
