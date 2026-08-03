import 'dart:math';
import 'package:injectable/injectable.dart';

@lazySingleton
class TerrainService {
  /// Returns a simulated terrain elevation in feet MSL for the given coordinates.
  double getElevationAt(double lat, double lon) {
    // A simple math function to generate hills and valleys based on coordinates
    // We add some base elevation and use sine waves for topology
    final baseElevation = 500.0;
    
    // Scale lat/lon so the waves are reasonably sized
    final latRad = lat * 10;
    final lonRad = lon * 10;
    
    final hill1 = sin(latRad) * cos(lonRad) * 1000;
    final hill2 = sin(latRad * 2.5 + lonRad * 1.5) * 500;
    
    double elevation = baseElevation + hill1 + hill2;
    return max(0.0, elevation); // Elevation cannot be below sea level in this model
  }
}
