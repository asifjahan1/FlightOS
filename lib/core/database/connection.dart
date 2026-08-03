import 'dart:ffi';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/open.dart';
import 'package:sqlite3/sqlite3.dart';

DynamicLibrary openSqliteOnLinux() {
  final libraryNames = [
    'libsqlite3.so.0',
    'libsqlite3.so',
    'libsqlite3.so.1',
    '/lib/x86_64-linux-gnu/libsqlite3.so.0',
    '/usr/lib/x86_64-linux-gnu/libsqlite3.so.0',
    '/lib/x86_64-linux-gnu/libsqlite3.so',
    '/usr/lib/x86_64-linux-gnu/libsqlite3.so',
    '/lib/aarch64-linux-gnu/libsqlite3.so.0',
    '/usr/lib/aarch64-linux-gnu/libsqlite3.so.0',
    '/usr/lib/libsqlite3.so',
    '/usr/lib/libsqlite3.so.0',
  ];

  for (final name in libraryNames) {
    try {
      return DynamicLibrary.open(name);
    } catch (_) {}
  }

  throw ArgumentError(
    'Failed to load SQLite3 dynamic library. Please install it using `sudo apt-get install libsqlite3-0` or `sudo apt-get install sqlite3`',
  );
}

void setupSqliteDatabase() {
  if (Platform.isLinux) {
    open.overrideFor(OperatingSystem.linux, openSqliteOnLinux);
  }
}

LazyDatabase openConnection() {
  return LazyDatabase(() async {
    setupSqliteDatabase();

    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'skynav.sqlite'));

    // Make sqlite3 pick a more suitable location for temporary files - the
    // one from the system may be inaccessible due to sandboxing.
    final cachebase = (await getTemporaryDirectory()).path;
    // We can't access /tmp on Android, which sqlite3 would try by default.
    // Explicitly tell it about the correct temporary directory.
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(
      file,
      setup: (db) {
        setupSqliteDatabase();
      },
      isolateSetup: () {
        setupSqliteDatabase();
      },
    );
  });
}
