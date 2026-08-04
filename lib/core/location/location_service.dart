import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skynav/core/database/daos/airport_dao.dart';
import 'package:skynav/features/telemetry/domain/entities/telemetry_data.dart';

abstract class LocationService {
  Stream<TelemetryData> getPositionStream();
}

@LazySingleton(as: LocationService)
class GeolocatorLocationService implements LocationService {
  GeolocatorLocationService();

  // A simple desktop simulator variables
  bool _useSimulator = false;
  Timer? _simulatorTimer;
  double _simLat = 23.8433; // Dhaka VGHS approx
  double _simLon = 90.4000;
  final double _simTrack = 45; // Heading NE
  final double _simSpeedKnots = 110;

  Future<void> _loadSimLocation() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/skynav_sim_location.json');
      if (await file.exists()) {
        // Resume from last saved location
        final data =
            jsonDecode(await file.readAsString()) as Map<String, dynamic>;
        if (data['lat'] != null && data['lon'] != null) {
          _simLat = (data['lat'] as num).toDouble();
          _simLon = (data['lon'] as num).toDouble();
          return;
        }
      }

      // If no saved location exists (first run), dynamically fetch the user's REAL location
      // via IP-based Geolocation to give the client an authentic "real vibe"
      await _fetchRealLocationFromIP();
    } catch (_) {}
  }

  Future<void> _fetchRealLocationFromIP() async {
    try {
      final response = await http
          .get(Uri.parse('http://ip-api.com/json/'))
          .timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        if (data['lat'] != null && data['lon'] != null) {
          final ipLat = (data['lat'] as num).toDouble();
          final ipLon = (data['lon'] as num).toDouble();

          // ── Professional Aviation Logic ──
          // A flight simulator shouldn't spawn over a random house or street.
          // We will find the nearest real-world airport to the user's IP location
          // and spawn the aircraft there to begin the flight.
          try {
            // Using GetIt directly to avoid changing constructor signatures for this fallback
            final airportDao = GetIt.I<AirportDao>();

            // Search 1.0 degree bounding box (roughly 60 miles)
            final nearbyAirports = await airportDao.getAirportsInBoundingBox(
              minLat: ipLat - 1.0,
              maxLat: ipLat + 1.0,
              minLon: ipLon - 1.0,
              maxLon: ipLon + 1.0,
            );

            if (nearbyAirports.isNotEmpty) {
              // Find the absolute closest airport using simple distance formula
              nearbyAirports.sort((a, b) {
                final distA =
                    math.pow(a.latitude - ipLat, 2) +
                    math.pow(a.longitude - ipLon, 2);
                final distB =
                    math.pow(b.latitude - ipLat, 2) +
                    math.pow(b.longitude - ipLon, 2);
                return distA.compareTo(distB);
              });

              final nearestAirport = nearbyAirports.first;
              _simLat = nearestAirport.latitude;
              _simLon = nearestAirport.longitude;
              return;
            }
          } catch (_) {
            // Ignore DB errors
          }

          // Fallback to exact IP location if no airports exist within 60 miles
          _simLat = ipLat;
          _simLon = ipLon;
        }
      }
    } catch (_) {
      // Keep default Dhaka coordinates if API fails or no internet
    }
  }

  Future<void> _saveSimLocation() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/skynav_sim_location.json');
      await file.writeAsString(jsonEncode({'lat': _simLat, 'lon': _simLon}));
    } catch (_) {}
  }

  @override
  Stream<TelemetryData> getPositionStream() async* {
    if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      _useSimulator =
          true; // Desktop environments often lack reliable GPS and can crash CoreLocation
    } else {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _useSimulator = true;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          _useSimulator = true;
        }
      }

      if (!_useSimulator) {
        try {
          await Geolocator.getCurrentPosition(
            locationSettings: const LocationSettings(
              timeLimit: Duration(seconds: 5),
            ),
          );
        } catch (e) {
          _useSimulator = true;
        }
      }
    }

    if (_useSimulator) {
      await _loadSimLocation();
      yield* _simulateGps();
    } else {
      yield* Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      ).map((Position pos) {
        return TelemetryData(
          latitude: pos.latitude,
          longitude: pos.longitude,
          altitudeMslFeet: pos.altitude * 3.28084, // meters to feet
          groundSpeedKnots: pos.speed * 1.94384, // m/s to knots
          trueTrack: pos.heading,
          accuracyMeters: pos.accuracy,
        );
      });
    }
  }

  Stream<TelemetryData> _simulateGps() {
    final controller = StreamController<TelemetryData>();
    var tickCount = 0;

    _simulatorTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // Very crude simulation: move aircraft Northeast
      final distMeters = (_simSpeedKnots / 1.94384) * 1.0; // 1 second distance
      final latOffset =
          (distMeters * math.cos(_simTrack * math.pi / 180)) / 111320.0;
      final lonOffset =
          (distMeters * math.sin(_simTrack * math.pi / 180)) /
          (111320.0 * math.cos(_simLat * math.pi / 180));

      _simLat += latOffset;
      _simLon += lonOffset;

      controller.add(
        TelemetryData(
          latitude: _simLat,
          longitude: _simLon,
          altitudeMslFeet: 3500,
          groundSpeedKnots: _simSpeedKnots,
          trueTrack: _simTrack,
          accuracyMeters: 5,
        ),
      );

      // Save location every 5 seconds
      tickCount++;
      if (tickCount % 5 == 0) {
        _saveSimLocation();
      }
    });

    controller.onCancel = () {
      _saveSimLocation();
      _simulatorTimer?.cancel();
      controller.close();
    };

    return controller.stream;
  }
}
