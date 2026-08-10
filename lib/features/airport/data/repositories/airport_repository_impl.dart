import 'package:injectable/injectable.dart';
import 'package:skynav/core/database/daos/airport_dao.dart';
import 'package:skynav/core/database/database.dart';
import 'package:skynav/core/utils/nav_math.dart';
import 'package:skynav/features/airport/domain/entities/airport.dart';
import 'package:skynav/features/airport/domain/entities/frequency.dart';
import 'package:skynav/features/airport/domain/entities/runway.dart';
import 'package:skynav/features/airport/domain/repositories/airport_repository.dart';

@LazySingleton(as: AirportRepository)
class AirportRepositoryImpl implements AirportRepository {
  AirportRepositoryImpl(AppDatabase db) : _dao = db.airportDao;
  final AirportDao _dao;

  @override
  Future<Airport?> getAirportByIcao(String icao) async {
    final data = await _dao.getAirportByIcao(icao);
    if (data == null) return null;
    return _mapAirport(data);
  }

  @override
  Future<List<Airport>> getAirportsInBoundingBox({
    required double minLat,
    required double maxLat,
    required double minLon,
    required double maxLon,
    List<String>? types,
  }) async {
    final list = await _dao.getAirportsInBoundingBox(
      minLat: minLat,
      maxLat: maxLat,
      minLon: minLon,
      maxLon: maxLon,
      types: types,
    );
    return list.map(_mapAirport).toList();
  }

  @override
  Future<List<Airport>> getNearestAirports(double lat, double lon, int limit) async {
    final boxSize = 1.0; // roughly 60nm
    final list = await _dao.getAirportsInBoundingBox(
      minLat: lat - boxSize,
      maxLat: lat + boxSize,
      minLon: lon - boxSize,
      maxLon: lon + boxSize,
    );
    
    final mapped = list.map(_mapAirport).toList();
    mapped.sort((a, b) {
       final distA = NavMath.distanceNm(lat, lon, a.latitude, a.longitude);
       final distB = NavMath.distanceNm(lat, lon, b.latitude, b.longitude);
       return distA.compareTo(distB);
    });
    
    return mapped.take(limit).toList();
  }

  @override
  Future<List<Runway>> getRunways(String airportIcao) async {
    final list = await _dao.getRunwaysForAirport(airportIcao);
    return list.map(_mapRunway).toList();
  }

  @override
  Future<List<Frequency>> getFrequencies(String airportIcao) async {
    final list = await _dao.getFrequenciesForAirport(airportIcao);
    return list.map(_mapFrequency).toList();
  }

  @override
  Future<List<Airport>> searchAirports(String query) async {
    final list = await _dao.searchAirports(query);
    return list.map(_mapAirport).toList();
  }

  // --- Mappers ---

  Airport _mapAirport(AirportData data) {
    return Airport(
      icao: data.icao,
      iata: data.iata,
      name: data.name,
      latitude: data.latitude,
      longitude: data.longitude,
      elevation: data.elevation,
      type: data.type,
      municipality: data.municipality,
      countryCode: data.countryCode,
    );
  }

  Runway _mapRunway(RunwayData data) {
    return Runway(
      id: data.id,
      airportIcao: data.airportIcao,
      length: data.length,
      width: data.width,
      surface: data.surface,
      ident: data.ident,
    );
  }

  Frequency _mapFrequency(FrequencyData data) {
    return Frequency(
      id: data.id,
      airportIcao: data.airportIcao,
      type: data.type,
      frequency: data.frequency,
      description: data.description,
    );
  }
}
