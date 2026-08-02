import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:skynav/core/database/connection.dart';
import 'package:skynav/core/database/daos/airport_dao.dart';
import 'package:skynav/core/database/tables/airports.dart';
import 'package:skynav/core/database/tables/frequencies.dart';
import 'package:skynav/core/database/tables/runways.dart';

part 'database.g.dart';

@lazySingleton
@DriftDatabase(
  tables: [Airports, Runways, Frequencies],
  daos: [AirportDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        // Here we could parse initial JSON and insert it.
      },
    );
  }
}
