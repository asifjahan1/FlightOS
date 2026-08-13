import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:skynav/core/database/connection.dart';
import 'package:skynav/core/database/daos/airport_dao.dart';
import 'package:skynav/core/database/tables/airports.dart';
import 'package:skynav/core/database/tables/frequencies.dart';
import 'package:skynav/core/database/tables/runways.dart';

part 'database.g.dart';

@lazySingleton
@DriftDatabase(tables: [Airports, Runways, Frequencies], daos: [AirportDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // Destructive migration for early development
          for (final table in allTables) {
            // ignore: deprecated_member_use
            await m.issueCustomQuery(
              'DROP TABLE IF EXISTS ${table.actualTableName}',
            );
          }
          await m.createAll();
        }
      },
    );
  }
}
