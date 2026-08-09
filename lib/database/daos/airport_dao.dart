/// Airport Data Access Object (DAO) for Drift.
///
/// Provides type-safe, compiled SQL queries for airport data access.
/// This DAO implements the data operations that the repository layer
/// delegates to.
library;

import 'package:drift/drift.dart';

import 'package:skynav/database/app_database.dart';
import 'package:skynav/database/tables/airport_tables.dart';

part 'airport_dao.g.dart';

/// DAO for airport-related database operations.
@DriftAccessor(tables: [AirportTable, RunwayTable, FrequencyTable, NavaidTable])
class AirportDao extends DatabaseAccessor<AppDatabase> with _$AirportDaoMixin {
  AirportDao(super.db);

  // ── Airport Queries ──

  /// Returns all airports within a bounding box.
  ///
  /// Used for rendering airport markers on the visible map viewport.
  Future<List<AirportEntry>> getAirportsInBounds(
    double minLat,
    double maxLat,
    double minLon,
    double maxLon, {
    int limit = 500,
    List<String>? types,
  }) {
    return (select(airportTable)
          ..where((a) {
            var condition =
                a.latitude.isBetweenValues(minLat, maxLat) &
                a.longitude.isBetweenValues(minLon, maxLon);
            if (types != null && types.isNotEmpty) {
              condition = condition & a.type.isIn(types);
            }
            return condition;
          })
          ..limit(limit))
        .get();
  }

  /// Returns a single airport by ICAO code.
  Future<AirportEntry?> getByIcao(String icaoCode) {
    return (select(airportTable)
          ..where((a) => a.icaoCode.equals(icaoCode))
          ..limit(1))
        .getSingleOrNull();
  }

  /// Returns a single airport by FAA code.
  Future<AirportEntry?> getByFaaCode(String faaCode) {
    return (select(airportTable)
          ..where((a) => a.faaCode.equals(faaCode))
          ..limit(1))
        .getSingleOrNull();
  }

  /// Returns a single airport by internal ID.
  Future<AirportEntry?> getById(int id) {
    return (select(
      airportTable,
    )..where((a) => a.id.equals(id))).getSingleOrNull();
  }

  /// Searches airports by name or code using LIKE.
  ///
  /// For MVP, uses SQL LIKE. Will be upgraded to FTS5 in a future iteration.
  Future<List<AirportEntry>> searchByQuery(String query, {int limit = 20}) {
    final pattern = '%$query%';
    return (select(airportTable)
          ..where(
            (a) =>
                a.name.like(pattern) |
                a.icaoCode.like(pattern) |
                a.faaCode.like(pattern) |
                a.iataCode.like(pattern) |
                a.municipality.like(pattern),
          )
          ..orderBy([
            // Prefer exact code matches first
            (a) => OrderingTerm(
              expression: a.icaoCode.like(query) | a.faaCode.like(query),
              mode: OrderingMode.desc,
            ),
          ])
          ..limit(limit))
        .get();
  }

  /// Returns the total number of airports.
  Future<int> countAirports() async {
    final count = airportTable.id.count();
    final query = selectOnly(airportTable)..addColumns([count]);
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  // ── Runway Queries ──

  /// Returns all runways for a given airport.
  Future<List<RunwayEntry>> getRunwaysForAirport(int airportId) {
    return (select(runwayTable)
          ..where((r) => r.airportId.equals(airportId))
          ..orderBy([(r) => OrderingTerm.asc(r.designator)]))
        .get();
  }

  // ── Frequency Queries ──

  /// Returns all frequencies for a given airport.
  Future<List<FrequencyEntry>> getFrequenciesForAirport(int airportId) {
    return (select(frequencyTable)
          ..where((f) => f.airportId.equals(airportId))
          ..orderBy([(f) => OrderingTerm.asc(f.type)]))
        .get();
  }

  // ── Navaid Queries ──

  /// Returns navaids within a bounding box.
  Future<List<NavaidEntry>> getNavaidsInBounds(
    double minLat,
    double maxLat,
    double minLon,
    double maxLon, {
    int limit = 500,
  }) {
    return (select(navaidTable)
          ..where(
            (n) =>
                n.latitude.isBetweenValues(minLat, maxLat) &
                n.longitude.isBetweenValues(minLon, maxLon),
          )
          ..limit(limit))
        .get();
  }

  /// Returns a navaid by its identifier (e.g., 'JFK').
  Future<NavaidEntry?> getNavaidByIdent(String ident) {
    return (select(navaidTable)
          ..where((n) => n.ident.equals(ident))
          ..limit(1))
        .getSingleOrNull();
  }

  // ── Bulk Insert (for NASR import) ──

  /// Inserts a batch of airports in a transaction.
  Future<void> insertAirportsBatch(List<AirportTableCompanion> airports) async {
    await batch((batch) {
      batch.insertAll(airportTable, airports);
    });
  }

  /// Inserts a batch of runways in a transaction.
  Future<void> insertRunwaysBatch(List<RunwayTableCompanion> runways) async {
    await batch((batch) {
      batch.insertAll(runwayTable, runways);
    });
  }

  /// Inserts a batch of frequencies in a transaction.
  Future<void> insertFrequenciesBatch(
    List<FrequencyTableCompanion> frequencies,
  ) async {
    await batch((batch) {
      batch.insertAll(frequencyTable, frequencies);
    });
  }

  /// Inserts a batch of navaids in a transaction.
  Future<void> insertNavaidsBatch(List<NavaidTableCompanion> navaids) async {
    await batch((batch) {
      batch.insertAll(navaidTable, navaids);
    });
  }

  // ── AIRAC Cycle ──

  /// Returns the most recent AIRAC cycle from the airport data.
  Future<String?> getCurrentAiracCycle() async {
    final query = selectOnly(airportTable)
      ..addColumns([airportTable.airacCycle])
      ..where(airportTable.airacCycle.isNotNull())
      ..limit(1);
    final result = await query.getSingleOrNull();
    return result?.read(airportTable.airacCycle);
  }
}
