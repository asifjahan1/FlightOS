import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:skynav/core/database/database.dart';

@lazySingleton
class AirportSeeder {
  AirportSeeder(this._db);
  final AppDatabase _db;
  final _logger = Logger();

  Future<void> seedDatabaseIfEmpty() async {
    final count = await _db.airportDao.getAirportsCount();
    if (count > 0) {
      _logger.i('Airports already seeded (Count: $count).');
      // ignore: avoid_print
      print('[AirportSeeder] DB already has $count airports. Skipping seed.');
      return;
    }

    _logger.i('Seeding airports from assets/data/airports_seed.json...');
    // ignore: avoid_print
    print('[AirportSeeder] DB is empty, starting seed...');
    try {
      final jsonString = await rootBundle.loadString(
        'assets/data/airports_seed.json',
      );
      final List<dynamic> jsonList = jsonDecode(jsonString);
      _logger.i('Seeding ${jsonList.length} airports...');
      // ignore: avoid_print
      print('[AirportSeeder] Parsed ${jsonList.length} airports from JSON.');

      final airports = jsonList.map((dynamic item) {
        final json = item as Map<String, dynamic>;
        return AirportsCompanion.insert(
          icao: json['icao'] as String,
          iata: Value(json['iata'] as String?),
          name: json['name'] as String,
          latitude: (json['latitude'] as num).toDouble(),
          longitude: (json['longitude'] as num).toDouble(),
          elevation: (json['elevation'] as num).toDouble(),
          type: json['type'] as String,
          municipality: Value(json['municipality'] as String?),
          countryCode: json['countryCode'] as String? ?? 'US',
        );
      }).toList();

      await _db.airportDao.insertAirportsBatch(airports);

      // Verify the insert actually worked
      final newCount = await _db.airportDao.getAirportsCount();
      _logger.i('Successfully seeded. Verification count: $newCount');
      // ignore: avoid_print
      print('[AirportSeeder] Seed complete. Verification count: $newCount');
    } catch (e, stack) {
      _logger.e('Failed to seed airports', error: e, stackTrace: stack);
      // ignore: avoid_print
      print('[AirportSeeder] SEED FAILED: $e');
    }
  }
}
