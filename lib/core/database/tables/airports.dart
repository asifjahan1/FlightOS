import 'package:drift/drift.dart';

@DataClassName('AirportData')
class Airports extends Table {
  TextColumn get icao => text().customConstraint('UNIQUE NOT NULL')();
  TextColumn get iata => text().nullable()();
  TextColumn get name => text()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  RealColumn get elevation => real()(); // in feet
  TextColumn get type => text()();
  TextColumn get municipality => text().nullable()();
  TextColumn get countryCode => text()();

  @override
  Set<Column> get primaryKey => {icao};
}
