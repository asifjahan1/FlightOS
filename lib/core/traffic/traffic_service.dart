import 'dart:async';
import 'dart:math' as math;
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
@LazySingleton(as: TrafficService)
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
        altitudeFeet: center.altitudeMslFeet + ((_random.nextDouble() - 0.5) * 4000), // +/- 2000ft
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
      final latOffset = (distMeters * math.cos(ghost.trackDegrees * math.pi / 180)) / 111320.0;
      final lonOffset = (distMeters * math.sin(ghost.trackDegrees * math.pi / 180)) / (111320.0 * math.cos(ghost.latitude * math.pi / 180));
      
      updated.add(ghost.copyWith(
        latitude: ghost.latitude + latOffset,
        longitude: ghost.longitude + lonOffset,
      ));
    }
    _ghosts = updated;
  }
}
