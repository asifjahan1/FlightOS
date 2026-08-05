import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:skynav/core/location/location_service.dart';
import 'package:skynav/features/telemetry/domain/entities/telemetry_data.dart';
import 'package:skynav/features/traffic/domain/entities/traffic_target.dart';

abstract class TrafficService {
  /// Stream of all active traffic targets around the aircraft.
  Stream<List<TrafficTarget>> getTrafficStream();
}

/// A simulated traffic service that generates realistic moving traffic
/// around the ownship's current location.
class SimulatorTrafficService implements TrafficService {
  SimulatorTrafficService(this._locationService);

  final LocationService _locationService;

  Timer? _simulatorTimer;
  StreamSubscription<TelemetryData>? _locationSub;

  TelemetryData? _latestLocation;
  List<TrafficTarget> _ghosts = [];
  final _random = math.Random();

  @override
  Stream<List<TrafficTarget>> getTrafficStream() {
    final controller = StreamController<List<TrafficTarget>>();

    // Keep track of our ownship location to center the ghost spawning
    _locationSub = _locationService.getPositionStream().listen((data) {
      if (_latestLocation == null) {
        // First fix, generate initial ghosts around this location
        _generateGhosts(data);
      }
      _latestLocation = data;
    });

    _simulatorTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_latestLocation == null) return;
      _updateGhosts();
      controller.add(List.unmodifiable(_ghosts));
    });

    controller.onCancel = () {
      _simulatorTimer?.cancel();
      _locationSub?.cancel();
      controller.close();
    };

    return controller.stream;
  }

  void _generateGhosts(TelemetryData center) {
    _ghosts = List.generate(8, (index) {
      // Spawn aircraft within roughly ~10 nautical miles (0.15 degrees)
      final latOffset = (_random.nextDouble() - 0.5) * 0.3;
      final lonOffset = (_random.nextDouble() - 0.5) * 0.3;

      return TrafficTarget(
        icaoHex: 'A${index.toRadixString(16).padLeft(5, '0').toUpperCase()}',
        callsign: 'GHOST$index',
        latitude: center.latitude + latOffset,
        longitude: center.longitude + lonOffset,
        altitudeFeet:
            center.altitudeMslFeet +
            ((_random.nextDouble() - 0.5) * 4000), // +/- 2000ft
        groundSpeedKnots: 80.0 + _random.nextDouble() * 150.0,
        trackDegrees: _random.nextDouble() * 360.0,
      );
    });
  }

  void _updateGhosts() {
    // Move ghosts based on their track and speed
    final updated = <TrafficTarget>[];
    for (final ghost in _ghosts) {
      final distMeters = (ghost.groundSpeedKnots / 1.94384) * 1.0; // 1 sec
      final latOffset =
          (distMeters * math.cos(ghost.trackDegrees * math.pi / 180)) /
          111320.0;
      final lonOffset =
          (distMeters * math.sin(ghost.trackDegrees * math.pi / 180)) /
          (111320.0 * math.cos(ghost.latitude * math.pi / 180));

      updated.add(
        ghost.copyWith(
          latitude: ghost.latitude + latOffset,
          longitude: ghost.longitude + lonOffset,
        ),
      );
    }
    _ghosts = updated;
  }
}

/// Real-time traffic service using OpenSky Network API.
@LazySingleton(as: TrafficService)
class OpenSkyTrafficService implements TrafficService {
  OpenSkyTrafficService(this._locationService);

  final LocationService _locationService;
  Timer? _pollingTimer;
  StreamSubscription<TelemetryData>? _locationSub;
  TelemetryData? _latestLocation;
  List<TrafficTarget> _targets = [];

  @override
  Stream<List<TrafficTarget>> getTrafficStream() {
    final controller = StreamController<List<TrafficTarget>>();

    _locationSub = _locationService.getPositionStream().listen((data) {
      _latestLocation = data;
    });

    // OpenSky data refreshes roughly every 10 seconds.
    _pollingTimer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      if (_latestLocation == null) return;

      await _fetchTraffic();
      controller.add(List.unmodifiable(_targets));
    });

    // Initial fetch
    Future.delayed(const Duration(seconds: 2), () async {
      if (_latestLocation != null) {
        await _fetchTraffic();
        controller.add(List.unmodifiable(_targets));
      }
    });

    controller.onCancel = () {
      _pollingTimer?.cancel();
      _locationSub?.cancel();
      controller.close();
    };

    return controller.stream;
  }

  Future<void> _fetchTraffic() async {
    final center = _latestLocation;
    if (center == null) return;

    // Bounding box to fetch traffic.
    // WARNING: OpenSky's free API strictly limits requests to 25 square degrees!
    // Using +/- 5.0 degrees covers 100 sq degrees and WILL BE BLOCKED (400 Bad Request).
    // We MUST use +/- 2.0 degrees (which is 16 sq degrees) or less to get data!
    final lamin = center.latitude - 5.0;
    final lamax = center.latitude + 5.0;
    final lomin = center.longitude - 5.0;
    final lomax = center.longitude + 5.0;

    final url = Uri.parse(
      'https://opensky-network.org/api/states/all?lamin=$lamin&lomin=$lomin&lamax=$lamax&lomax=$lomax',
    );

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // ignore: avoid_dynamic_calls
        final states = data['states'] as List<dynamic>?;

        if (states == null) {
          _targets = [];
          return;
        }

        final parsedTargets = <TrafficTarget>[];

        for (final state in states) {
          // OpenSky state array format:
          // 0: icao24 (string)
          // 1: callsign (string)
          // 2: origin_country (string)
          // 3: time_position (int)
          // 4: last_contact (int)
          // 5: longitude (float)
          // 6: latitude (float)
          // 7: baro_altitude (float)
          // 8: on_ground (boolean)
          // 9: velocity (float) m/s
          // 10: true_track (float)
          // ...

          // ignore: avoid_dynamic_calls
          final icao = state[0]?.toString() ?? 'UNKNOWN';
          // ignore: avoid_dynamic_calls
          final callsignRaw = state[1]?.toString().trim();
          final callsign = (callsignRaw != null && callsignRaw.isNotEmpty)
              ? callsignRaw
              : null;

          // ignore: avoid_dynamic_calls
          final lon = (state[5] as num?)?.toDouble();
          // ignore: avoid_dynamic_calls
          final lat = (state[6] as num?)?.toDouble();
          // ignore: avoid_dynamic_calls
          final altMeters = (state[7] as num?)?.toDouble();
          // ignore: avoid_dynamic_calls
          final velocityMps = (state[9] as num?)?.toDouble() ?? 0.0;
          // ignore: avoid_dynamic_calls
          final track = (state[10] as num?)?.toDouble() ?? 0.0;

          if (lat != null && lon != null && altMeters != null) {
            parsedTargets.add(
              TrafficTarget(
                icaoHex: icao,
                callsign: callsign,
                latitude: lat,
                longitude: lon,
                altitudeFeet: altMeters * 3.28084,
                groundSpeedKnots: velocityMps * 1.94384,
                trackDegrees: track,
              ),
            );
          }
        }

        _targets = parsedTargets;
      }
    } catch (e) {
      // Ignore network errors to keep the stream running
      // Optionally fallback to cached _targets or clear them depending on staleness.
    }
  }
}
