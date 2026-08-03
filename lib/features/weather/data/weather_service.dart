import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:skynav/features/weather/domain/entities/weather_data.dart';

@lazySingleton
class WeatherService {
  final _random = Random();
  final Map<String, WeatherReport> _cache = {};
  String? _cachedRadarUrl;

  Future<String?> getLatestRadarUrl() async {
    if (_cachedRadarUrl != null) return _cachedRadarUrl;
    try {
      final response = await http.get(Uri.parse('https://api.rainviewer.com/public/weather-maps.json'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> past = data['radar']['past'];
        if (past.isNotEmpty) {
          final last = past.last;
          final time = last['time'];
          _cachedRadarUrl = 'https://tilecache.rainviewer.com/v2/radar/$time/256/{z}/{x}/{y}/2/1_1.png';
          return _cachedRadarUrl;
        }
      }
    } catch (_) {}
    return 'https://tilecache.rainviewer.com/v2/radar/1691234567/256/{z}/{x}/{y}/2/1_1.png'; // Fallback
  }

  Future<WeatherReport> getWeatherForAirport(String airportId) async {
    // If we already generated for this airport, keep it stable for the session
    if (_cache.containsKey(airportId)) {
      return _cache[airportId]!;
    }
    
    await Future.delayed(const Duration(milliseconds: 50)); 
    
    // Generate a random flight category
    final int categoryVal = _random.nextInt(100);
    FlightCategory category;
    String vis;
    String clouds;
    
    if (categoryVal < 60) {
      category = FlightCategory.vfr;
      vis = '10SM';
      clouds = 'CLR';
    } else if (categoryVal < 85) {
      category = FlightCategory.mvfr;
      vis = '4SM';
      clouds = 'BKN025';
    } else if (categoryVal < 95) {
      category = FlightCategory.ifr;
      vis = '2SM';
      clouds = 'OVC008';
    } else {
      category = FlightCategory.lifr;
      vis = '1/2SM';
      clouds = 'OVC002';
    }

    final String windDir = (_random.nextInt(36) * 10).toString().padLeft(3, '0');
    final String windSpeed = (_random.nextInt(15) + 5).toString().padLeft(2, '0');
    final String temp = (_random.nextInt(20) + 10).toString().padLeft(2, '0');
    final String dew = (int.parse(temp) - _random.nextInt(5)).toString().padLeft(2, '0');

    final rawMetar = 'METAR $airportId 123456Z ${windDir}${windSpeed}KT $vis $clouds ${temp}/${dew} A2992';
    final rawTaf = 'TAF $airportId 123456Z 1212/1312 ${windDir}${windSpeed}KT $vis $clouds';

    final report = WeatherReport(
      airportId: airportId,
      rawMetar: rawMetar,
      rawTaf: rawTaf,
      category: category,
      timestamp: DateTime.now(),
    );

    _cache[airportId] = report;
    return report;
  }
}
