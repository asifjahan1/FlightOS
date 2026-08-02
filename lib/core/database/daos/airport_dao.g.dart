// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airport_dao.dart';

// ignore_for_file: type=lint
mixin _$AirportDaoMixin on DatabaseAccessor<AppDatabase> {
  $AirportsTable get airports => attachedDatabase.airports;
  $RunwaysTable get runways => attachedDatabase.runways;
  $FrequenciesTable get frequencies => attachedDatabase.frequencies;
  AirportDaoManager get managers => AirportDaoManager(this);
}

class AirportDaoManager {
  final _$AirportDaoMixin _db;
  AirportDaoManager(this._db);
  $$AirportsTableTableManager get airports =>
      $$AirportsTableTableManager(_db.attachedDatabase, _db.airports);
  $$RunwaysTableTableManager get runways =>
      $$RunwaysTableTableManager(_db.attachedDatabase, _db.runways);
  $$FrequenciesTableTableManager get frequencies =>
      $$FrequenciesTableTableManager(_db.attachedDatabase, _db.frequencies);
}
