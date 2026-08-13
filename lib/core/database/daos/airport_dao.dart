import 'package:drift/drift.dart';
import 'package:skynav/core/database/database.dart';
import 'package:skynav/core/database/tables/airports.dart';
import 'package:skynav/core/database/tables/frequencies.dart';
import 'package:skynav/core/database/tables/runways.dart';

part 'airport_dao.g.dart';

@DriftAccessor(tables: [Airports, Runways, Frequencies])
class AirportDao extends DatabaseAccessor<AppDatabase> with _$AirportDaoMixin {
  AirportDao(super.db);

  /// Fetch a single airport with its runways and frequencies by ICAO.
  Future<AirportData?> getAirportByIcao(String icao) {
    return (select(
      airports,
    )..where((t) => t.icao.equals(icao))).getSingleOrNull();
  }

  /// Get runways for a specific airport.
  Future<List<RunwayData>> getRunwaysForAirport(String icao) {
    return (select(runways)..where((t) => t.airportIcao.equals(icao))).get();
  }

  /// Get frequencies for a specific airport.
  Future<List<FrequencyData>> getFrequenciesForAirport(String icao) {
    return (select(
      frequencies,
    )..where((t) => t.airportIcao.equals(icao))).get();
  }

  /// Query airports within a bounding box.
  Future<List<AirportData>> getAirportsInBoundingBox({
    required double minLat,
    required double maxLat,
    required double minLon,
    required double maxLon,
    List<String>? types,
  }) {
    final query = select(airports)
      ..where((t) => t.latitude.isBetweenValues(minLat, maxLat))
      ..where((t) => t.longitude.isBetweenValues(minLon, maxLon));

    if (types != null && types.isNotEmpty) {
      query.where((t) => t.type.isIn(types));
    }

    return query.get();
  }

  /// Search airports by ICAO, IATA, or name.
  Future<List<AirportData>> searchAirports(String query) {
    final searchPattern = '%$query%';
    return (select(airports)
          ..where(
            (t) =>
                t.icao.like(searchPattern) |
                t.iata.like(searchPattern) |
                t.name.like(searchPattern),
          )
          ..limit(10))
        .get();
  }

  /// Get the total number of airports in the database.
  Future<int> getAirportsCount() async {
    final countExp = airports.icao.count();
    final query = selectOnly(airports)..addColumns([countExp]);
    final result = await query.getSingle();
    return result.read(countExp) ?? 0;
  }

  /// Batch insert airports.
  Future<void> insertAirportsBatch(List<AirportsCompanion> newAirports) async {
    await batch((batch) {
      batch.insertAll(airports, newAirports, mode: InsertMode.insertOrIgnore);
    });
  }
}
