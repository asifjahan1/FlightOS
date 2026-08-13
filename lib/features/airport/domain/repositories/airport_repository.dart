import 'package:skynav/features/airport/domain/entities/airport.dart';
import 'package:skynav/features/airport/domain/entities/frequency.dart';
import 'package:skynav/features/airport/domain/entities/runway.dart';

abstract class AirportRepository {
  /// Fetches an airport by its ICAO code, including its runways and frequencies.
  Future<Airport?> getAirportByIcao(String icao);

  /// Fetches airports within a specific geographic bounding box.
  Future<List<Airport>> getAirportsInBoundingBox({
    required double minLat,
    required double maxLat,
    required double minLon,
    required double maxLon,
    List<String>? types,
  });

  /// Fetches the nearest airports to a given coordinate.
  Future<List<Airport>> getNearestAirports(double lat, double lon, int limit);

  /// Fetches runways for a specific airport.
  Future<List<Runway>> getRunways(String airportIcao);

  /// Fetches frequencies for a specific airport.
  Future<List<Frequency>> getFrequencies(String airportIcao);

  /// Searches for airports by ICAO, IATA, or name.
  Future<List<Airport>> searchAirports(String query);
}
