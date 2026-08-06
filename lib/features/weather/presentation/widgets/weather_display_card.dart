import 'package:flutter/material.dart';
import 'package:skynav/features/weather/data/datasources/aviation_weather_api.dart';

class WeatherDisplayCard extends StatefulWidget {
  const WeatherDisplayCard({super.key, required this.icao});
  final String icao;

  @override
  State<WeatherDisplayCard> createState() => _WeatherDisplayCardState();
}

class _WeatherDisplayCardState extends State<WeatherDisplayCard> {
  final AviationWeatherApi _api = AviationWeatherApi();
  String? _metar;
  String? _taf;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    final metar = await _api.fetchMetar(widget.icao);
    final taf = await _api.fetchTaf(widget.icao);

    if (mounted) {
      setState(() {
        _metar = metar;
        _taf = taf;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_metar == null && _taf == null) {
      return const Text('No weather data available for this airport.');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_metar != null) ...[
          Text(
            'METAR',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _metar!,
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
          const SizedBox(height: 12),
        ],
        if (_taf != null) ...[
          Text(
            'TAF',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.orangeAccent,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _taf!,
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
        ],
      ],
    );
  }
}
