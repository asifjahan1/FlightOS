/// Drift database table definitions for user data.
///
/// These tables store user-generated data: routes, favorites,
/// flight logs, and application settings.
library;

import 'package:drift/drift.dart';


/// User settings table (key-value store).
@DataClassName('SettingEntry')
class SettingsTable extends Table {
  @override
  String get tableName => 'settings';

  TextColumn get key => text()();
  TextColumn get value => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {key};
}

/// Favorite airports/navaids.
@DataClassName('FavoriteEntry')
class FavoritesTable extends Table {
  @override
  String get tableName => 'favorites';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get type => text()(); // 'airport', 'navaid', 'waypoint'
  IntColumn get referenceId => integer()(); // FK to airports.id or navaids.id
  TextColumn get label => text().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
}

/// Saved flight routes.
@DataClassName('RouteEntry')
class RoutesTable extends Table {
  @override
  String get tableName => 'routes';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get waypointsJson => text()(); // JSON array of waypoints
  RealColumn get totalDistanceNm => real().nullable()();
  IntColumn get totalTimeSeconds => integer().nullable()();
  TextColumn get aircraftProfileId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

/// Flight log entries.
@DataClassName('FlightLogEntry')
class FlightLogsTable extends Table {
  @override
  String get tableName => 'flight_logs';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get routeId => integer().nullable().references(RoutesTable, #id)();
  TextColumn get departureIcao => text().nullable()();
  TextColumn get arrivalIcao => text().nullable()();
  DateTimeColumn get departureTime => dateTime().nullable()();
  DateTimeColumn get arrivalTime => dateTime().nullable()();
  RealColumn get totalDistanceNm => real().nullable()();
  RealColumn get totalFuelGallons => real().nullable()();
  RealColumn get maxAltitudeFt => real().nullable()();
  TextColumn get trackJson => text().nullable()(); // JSON array of lat/lon/alt/time
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}
