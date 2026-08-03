/// SkyNav application database (Drift/SQLite).
///
/// This is the central database class that Drift uses for code generation.
/// Run `dart run build_runner build` to generate `app_database.g.dart`.
library;

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'package:skynav/core/constants/app_constants.dart';
import 'package:skynav/core/database/connection.dart';
import 'package:skynav/database/daos/airport_dao.dart';
import 'package:skynav/database/tables/airport_tables.dart';
import 'package:skynav/database/tables/user_tables.dart';

part 'app_database.g.dart';

/// Main application database.
///
/// Contains all tables for airport data, user data, and settings.
/// The airport data is read-only (populated from NASR imports);
/// user data is read-write.
@DriftDatabase(
  tables: [
    // Airport data (read-only, populated from NASR)
    AirportTable,
    RunwayTable,
    FrequencyTable,
    NavaidTable,
    // User data (read-write)
    SettingsTable,
    FavoritesTable,
    RoutesTable,
    FlightLogsTable,
  ],
  daos: [AirportDao],
)
class AppDatabase extends _$AppDatabase {
  /// Creates a database instance with the default connection.
  AppDatabase() : super(_openConnection());

  /// Creates a database instance with a custom connection (for testing).
  AppDatabase.forTesting(super.e);

  /// Schema version — increment when tables change.
  @override
  int get schemaVersion => 1;

  /// Migration strategy.
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();

        // Create indexes for spatial queries
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_airports_location '
          'ON airports(latitude, longitude)',
        );
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_airports_icao '
          'ON airports(icao_code)',
        );
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_airports_faa '
          'ON airports(faa_code)',
        );
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_airports_name '
          'ON airports(name)',
        );
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_airports_type '
          'ON airports(type)',
        );
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_runways_airport '
          'ON runways(airport_id)',
        );
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_frequencies_airport '
          'ON frequencies(airport_id)',
        );
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_navaids_ident '
          'ON navaids(ident)',
        );
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_navaids_location '
          'ON navaids(latitude, longitude)',
        );
      },
      onUpgrade: (m, from, to) async {
        // Future migrations go here.
        // Use `if (from < 2)` pattern for incremental migrations.
      },
    );
  }
}

/// Opens the SQLite database connection.
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    setupSqliteDatabase();

    final appDir = await getApplicationSupportDirectory();
    final dbPath = p.join(appDir.path, DatabaseConstants.userDb);

    // Ensure the directory exists
    final dbDir = Directory(p.dirname(dbPath));
    if (!dbDir.existsSync()) {
      dbDir.createSync(recursive: true);
    }

    return NativeDatabase.createInBackground(
      File(dbPath),
      isolateSetup: () {
        setupSqliteDatabase();
      },
      setup: (db) {
        setupSqliteDatabase();
      },
    );
  });
}
