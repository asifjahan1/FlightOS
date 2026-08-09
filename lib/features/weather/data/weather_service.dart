import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:skynav/features/weather/domain/entities/weather_data.dart';

@lazySingleton
class WeatherService {
  final Map<String, WeatherReport> _cache = {};
  String? _cachedRadarUrl;

  Future<String?> getLatestRadarUrl() async {
    if (_cachedRadarUrl != null) return _cachedRadarUrl;
    try {
      final response = await http.get(
        Uri.parse('https://api.rainviewer.com/public/weather-maps.json'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // ignore: avoid_dynamic_calls
        final List<dynamic> past = data['radar']['past'];
        if (past.isNotEmpty) {
          final last = past.last;
          // ignore: avoid_dynamic_calls
          final time = last['time'];
          // ignore: join_return_with_assignment
          _cachedRadarUrl =
              'https://tilecache.rainviewer.com/v2/radar/$time/256/{z}/{x}/{y}/2/1_1.png';
          return _cachedRadarUrl;
        }
      }
    } catch (_) {}
    return 'https://tilecache.rainviewer.com/v2/radar/1691234567/256/{z}/{x}/{y}/2/1_1.png'; // Fallback
  }

  Future<List<WeatherReport>> getWeatherForAirports(
    List<String> airportIds,
  ) async {
    final results = <WeatherReport>[];
    final idsToFetch = <String>[];

    for (final id in airportIds) {
      if (_cache.containsKey(id) &&
          DateTime.now().difference(_cache[id]!.timestamp).inMinutes < 15) {
        results.add(_cache[id]!);
      } else {
        idsToFetch.add(id);
      }
    }

    if (idsToFetch.isEmpty) return results;

    // Batch requests in chunks of 50 to avoid URI length limits
    const chunkSize = 50;
    for (var i = 0; i < idsToFetch.length; i += chunkSize) {
      final chunk = idsToFetch.sublist(
        i,
        min(i + chunkSize, idsToFetch.length),
      );
      final idsParam = chunk.join(',');

      try {
        final metarRes = await http
            .get(
              Uri.parse(
                'https://aviationweather.gov/api/data/metar?ids=$idsParam&format=json',
              ),
            )
            .timeout(const Duration(seconds: 10));

        final tafRes = await http
            .get(
              Uri.parse(
                'https://aviationweather.gov/api/data/taf?ids=$idsParam&format=json',
              ),
            )
            .timeout(const Duration(seconds: 10));

        final tafMap = <String, String>{};
        if (tafRes.statusCode == 200) {
          final tafList = jsonDecode(tafRes.body) as List;
          for (final taf in tafList) {
            final tafData = taf as Map<String, dynamic>;
            final icao = tafData['icaoId'] as String?;
            if (icao != null) {
              tafMap[icao] = tafData['rawTAF'] as String? ?? 'No TAF available';
            }
          }
        }

        if (metarRes.statusCode == 200) {
          final metarList = jsonDecode(metarRes.body) as List;
          for (final metar in metarList) {
            final data = metar as Map<String, dynamic>;
            final icao = data['icaoId'] as String?;
            if (icao == null) continue;

            final rawMetar = data['rawOb'] as String? ?? 'No METAR available';
            final fltCatStr = data['fltCat'] as String?;

            var category = FlightCategory.vfr;
            if (fltCatStr == 'MVFR') category = FlightCategory.mvfr;
            if (fltCatStr == 'IFR') category = FlightCategory.ifr;
            if (fltCatStr == 'LIFR') category = FlightCategory.lifr;

            final rawTaf = tafMap[icao] ?? 'No TAF available';
            final tempC = (data['temp'] as num?)?.toDouble();
            final windDirRaw = data['wdir'];
            final windDir = windDirRaw is num
                ? windDirRaw.toInt()
                : (int.tryParse(windDirRaw.toString()));
            final windSpeed = (data['wspd'] as num?)?.toInt();
            final cloudCover = data['cover'] as String?;

            final report = WeatherReport(
              airportId: icao,
              rawMetar: rawMetar,
              rawTaf: rawTaf,
              category: category,
              timestamp: DateTime.now(),
              tempC: tempC,
              windDir: windDir,
              windSpeed: windSpeed,
              cloudCover: cloudCover,
            );

            _cache[icao] = report;
            results.add(report);
            chunk.remove(icao); // Mark as fetched
          }
        }
      } catch (_) {}

      // Add fallbacks for any IDs in the chunk that failed or didn't return data
      for (final failedId in chunk) {
        final fallback = WeatherReport(
          airportId: failedId,
          rawMetar: 'No weather data available.',
          rawTaf: 'No TAF data available.',
          category: FlightCategory.unknown,
          timestamp: DateTime.now(),
        );
        _cache[failedId] = fallback;
        results.add(fallback);
      }
    }

    return results;
  }
}
