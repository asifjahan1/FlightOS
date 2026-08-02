/// Drift database table definitions for the airport database.
///
/// These tables map directly to the SQLite schema defined in the
/// architecture document (Section 6.2).
library;

import 'package:drift/drift.dart';

/// Core airport table.
@DataClassName('AirportEntry')
class AirportTable extends Table {
  @override
  String get tableName => 'airports';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get icaoCode => text().nullable()();
  TextColumn get faaCode => text().nullable()();
  TextColumn get iataCode => text().nullable()();
  TextColumn get name => text()();
  TextColumn get type => text()(); // 'large_airport', 'medium_airport', etc.
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  RealColumn get elevationFt => real().nullable()();
  TextColumn get countryCode => text()();
  TextColumn get regionCode => text().nullable()();
  TextColumn get municipality => text().nullable()();
  TextColumn get timezone => text().nullable()();
  BoolColumn get hasTower => boolean().withDefault(const Constant(false))();
  RealColumn get magneticVariation => real().nullable()();
  TextColumn get dataSource => text()();
  TextColumn get airacCycle => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();
}

/// Runway table.
@DataClassName('RunwayEntry')
class RunwayTable extends Table {
  @override
  String get tableName => 'runways';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get airportId => integer().references(AirportTable, #id)();
  TextColumn get designator => text()();
  RealColumn get lengthFt => real().nullable()();
  RealColumn get widthFt => real().nullable()();
  TextColumn get surface => text().nullable()();
  BoolColumn get lighted => boolean().withDefault(const Constant(false))();
  BoolColumn get closed => boolean().withDefault(const Constant(false))();
  TextColumn get heDesignator => text().nullable()();
  RealColumn get heLatitude => real().nullable()();
  RealColumn get heLongitude => real().nullable()();
  RealColumn get heElevationFt => real().nullable()();
  RealColumn get heHeadingTrue => real().nullable()();
  TextColumn get leDesignator => text().nullable()();
  RealColumn get leLatitude => real().nullable()();
  RealColumn get leLongitude => real().nullable()();
  RealColumn get leElevationFt => real().nullable()();
  RealColumn get leHeadingTrue => real().nullable()();
}

/// Radio frequency table.
@DataClassName('FrequencyEntry')
class FrequencyTable extends Table {
  @override
  String get tableName => 'frequencies';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get airportId => integer().references(AirportTable, #id)();
  TextColumn get type => text()();
  TextColumn get description => text().nullable()();
  RealColumn get frequencyMhz => real()();
}

/// Navaid table (VOR, NDB, DME, etc.).
@DataClassName('NavaidEntry')
class NavaidTable extends Table {
  @override
  String get tableName => 'navaids';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get ident => text()();
  TextColumn get name => text()();
  TextColumn get type => text()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  RealColumn get elevationFt => real().nullable()();
  RealColumn get frequency => real().nullable()();
  RealColumn get magneticVariation => real().nullable()();
  RealColumn get rangeNm => real().nullable()();
}
