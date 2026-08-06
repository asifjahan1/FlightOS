import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sqlite3/sqlite3.dart';
import 'package:csv/csv.dart'; // Need to add this to pubspec if not there

void main() async {
  print('Starting OurAirports Data Import...');
  
  final dbPath = 'assets/data/airports.sqlite';
  final dbDir = Directory('assets/data');
  if (!dbDir.existsSync()) {
    dbDir.createSync(recursive: true);
  }
  
  // Delete existing to start fresh
  final dbFile = File(dbPath);
  if (dbFile.existsSync()) {
    dbFile.deleteSync();
  }
  
  final db = sqlite3.open(dbPath);
  
  // Create tables mimicking the drift schema
  db.execute('''
    CREATE TABLE airports (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      icao_code TEXT,
      faa_code TEXT,
      iata_code TEXT,
      name TEXT NOT NULL,
      type TEXT NOT NULL,
      latitude REAL NOT NULL,
      longitude REAL NOT NULL,
      elevation_ft REAL,
      country_code TEXT NOT NULL,
      region_code TEXT,
      municipality TEXT,
      timezone TEXT,
      has_tower INTEGER NOT NULL DEFAULT 0,
      magnetic_variation REAL,
      data_source TEXT NOT NULL,
      airac_cycle TEXT,
      updated_at INTEGER NOT NULL
    );
  ''');
  
  db.execute('''
    CREATE TABLE runways (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      airport_id INTEGER NOT NULL REFERENCES airports(id),
      designator TEXT NOT NULL,
      length_ft REAL,
      width_ft REAL,
      surface TEXT,
      lighted INTEGER NOT NULL DEFAULT 0,
      closed INTEGER NOT NULL DEFAULT 0,
      he_designator TEXT,
      he_latitude REAL,
      he_longitude REAL,
      he_elevation_ft REAL,
      he_heading_true REAL,
      le_designator TEXT,
      le_latitude REAL,
      le_longitude REAL,
      le_elevation_ft REAL,
      le_heading_true REAL
    );
  ''');
  
  // Indexes
  db.execute('CREATE INDEX idx_airports_location ON airports(latitude, longitude);');
  db.execute('CREATE INDEX idx_airports_icao ON airports(icao_code);');
  db.execute('CREATE INDEX idx_airports_iata ON airports(iata_code);');
  db.execute('CREATE INDEX idx_runways_airport ON runways(airport_id);');

  // We will only download US airports for now as per requirements
  print('Downloading airports.csv...');
  final airportsRes = await http.get(Uri.parse('https://davidmegginson.github.io/ourairports-data/airports.csv'));
  if (airportsRes.statusCode != 200) throw Exception('Failed to download airports');
  
  print('Parsing airports.csv...');
  final airportsCsv = const CsvDecoder().convert(airportsRes.body);
  
  final airportStmt = db.prepare('''
    INSERT INTO airports (
      icao_code, iata_code, name, type, latitude, longitude, elevation_ft,
      country_code, region_code, municipality, data_source, updated_at
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  ''');
  
  final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  int airportCount = 0;
  Map<String, int> identToDbId = {}; // Map OurAirports ident to inserted DB id
  
  db.execute('BEGIN TRANSACTION');
  for (int i = 1; i < airportsCsv.length; i++) {
    final row = airportsCsv[i];
    if (row.length < 18) continue;
    
    final ident = row[1].toString();
    final type = row[2].toString();
    if (type == 'closed') continue;
    
    final country = row[8].toString();
    if (country != 'US') continue; // Scope: US only
    
    final name = row[3].toString();
    final lat = double.tryParse(row[4].toString()) ?? 0.0;
    final lon = double.tryParse(row[5].toString()) ?? 0.0;
    final elev = double.tryParse(row[6].toString());
    final region = row[9].toString();
    final municipality = row[10].toString();
    final iata = row[13].toString();
    final icao = ident.length == 4 ? ident : null; // Rough approximation
    
    airportStmt.execute([
      icao,
      iata.isEmpty ? null : iata,
      name,
      type,
      lat,
      lon,
      elev,
      country,
      region,
      municipality,
      'OurAirports',
      now
    ]);
    identToDbId[ident] = db.lastInsertRowId;
    airportCount++;
  }
  db.execute('COMMIT');
  airportStmt.dispose();
  print('Inserted $airportCount US airports.');

  print('Downloading runways.csv...');
  final runwaysRes = await http.get(Uri.parse('https://davidmegginson.github.io/ourairports-data/runways.csv'));
  if (runwaysRes.statusCode != 200) throw Exception('Failed to download runways');
  
  print('Parsing runways.csv...');
  final runwaysCsv = const CsvDecoder().convert(runwaysRes.body);
  
  final runwayStmt = db.prepare('''
    INSERT INTO runways (
      airport_id, designator, length_ft, width_ft, surface, lighted, closed,
      le_designator, he_designator
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
  ''');
  
  int runwayCount = 0;
  db.execute('BEGIN TRANSACTION');
  for (int i = 1; i < runwaysCsv.length; i++) {
    final row = runwaysCsv[i];
    if (row.length < 20) continue;
    
    final airportIdent = row[2].toString();
    final airportId = identToDbId[airportIdent];
    if (airportId == null) continue; // Skip non-US or closed
    
    final length = double.tryParse(row[3].toString());
    final width = double.tryParse(row[4].toString());
    final surface = row[5].toString();
    final lighted = row[6].toString() == '1' ? 1 : 0;
    final closed = row[7].toString() == '1' ? 1 : 0;
    final leIdent = row[8].toString();
    final heIdent = row[14].toString();
    
    final designator = '\$leIdent/\$heIdent';
    
    runwayStmt.execute([
      airportId,
      designator,
      length,
      width,
      surface,
      lighted,
      closed,
      leIdent,
      heIdent
    ]);
    runwayCount++;
  }
  db.execute('COMMIT');
  runwayStmt.dispose();
  print('Inserted $runwayCount runways.');
  
  db.dispose();
  print('Database generation complete. Saved to $dbPath');
}
