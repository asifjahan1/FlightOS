import 'package:drift/drift.dart';
import 'package:skynav/core/database/tables/airports.dart';

@DataClassName('RunwayData')
class Runways extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get airportIcao => text().references(Airports, #icao)();
  RealColumn get length => real()(); // in feet
  RealColumn get width => real()(); // in feet
  TextColumn get surface => text().nullable()();
  TextColumn get ident => text()();
}
