// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airport_dao.dart';

// ignore_for_file: type=lint
mixin _$AirportDaoMixin on DatabaseAccessor<AppDatabase> {
  $AirportTableTable get airportTable => attachedDatabase.airportTable;
  $RunwayTableTable get runwayTable => attachedDatabase.runwayTable;
  $FrequencyTableTable get frequencyTable => attachedDatabase.frequencyTable;
  $NavaidTableTable get navaidTable => attachedDatabase.navaidTable;
  AirportDaoManager get managers => AirportDaoManager(this);
}

class AirportDaoManager {
  final _$AirportDaoMixin _db;
  AirportDaoManager(this._db);
  $$AirportTableTableTableManager get airportTable =>
      $$AirportTableTableTableManager(_db.attachedDatabase, _db.airportTable);
  $$RunwayTableTableTableManager get runwayTable =>
      $$RunwayTableTableTableManager(_db.attachedDatabase, _db.runwayTable);
  $$FrequencyTableTableTableManager get frequencyTable =>
      $$FrequencyTableTableTableManager(
        _db.attachedDatabase,
        _db.frequencyTable,
      );
  $$NavaidTableTableTableManager get navaidTable =>
      $$NavaidTableTableTableManager(_db.attachedDatabase, _db.navaidTable);
}
