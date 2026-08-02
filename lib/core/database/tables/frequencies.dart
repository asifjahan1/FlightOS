import 'package:drift/drift.dart';
import 'package:skynav/core/database/tables/airports.dart';

@DataClassName('FrequencyData')
class Frequencies extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get airportIcao => text().references(Airports, #icao)();
  TextColumn get type => text()(); // TWR, APP, GND, ATIS
  RealColumn get frequency => real()();
  TextColumn get description => text().nullable()();
}
