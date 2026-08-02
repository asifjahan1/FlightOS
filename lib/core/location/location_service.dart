import 'dart:async';
import 'dart:math' as math;
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
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

  @override
  Stream<TelemetryData> getPositionStream() async* {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _useSimulator = true;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        _useSimulator = true;
      }
    }

    if (_useSimulator) {
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
    _simulatorTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // Very crude simulation: move aircraft Northeast
      final distMeters = (_simSpeedKnots / 1.94384) * 1.0; // 1 second distance
      final latOffset = (distMeters * math.cos(_simTrack * math.pi / 180)) / 111320.0;
      final lonOffset = (distMeters * math.sin(_simTrack * math.pi / 180)) / (111320.0 * math.cos(_simLat * math.pi / 180));
      
      _simLat += latOffset;
      _simLon += lonOffset;

      controller.add(TelemetryData(
        latitude: _simLat,
        longitude: _simLon,
        altitudeMslFeet: 3500,
        groundSpeedKnots: _simSpeedKnots,
        trueTrack: _simTrack,
        accuracyMeters: 5,
      ));
    });
    
    controller.onCancel = () {
      _simulatorTimer?.cancel();
      controller.close();
    };

    return controller.stream;
  }
}
