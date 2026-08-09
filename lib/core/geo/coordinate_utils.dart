/// Coordinate conversion utilities for aviation.
///
/// Converts between decimal degrees, DMS (degrees-minutes-seconds),
/// and various aviation coordinate formats.
library;

import 'dart:math' as math;

/// Utility class for coordinate format conversions.
abstract final class CoordinateUtils {
  /// Converts decimal degrees to DMS string.
  ///
  /// Example: `toDms(40.6413, isLatitude: true)` → `"N 40° 38' 28.68""`
  static String toDms(double decimal, {required bool isLatitude}) {
    final direction = isLatitude
        ? (decimal >= 0 ? 'N' : 'S')
        : (decimal >= 0 ? 'E' : 'W');

    final abs = decimal.abs();
    final degrees = abs.floor();
    final minutesDecimal = (abs - degrees) * 60;
    final minutes = minutesDecimal.floor();
    final seconds = (minutesDecimal - minutes) * 60;

    return "$direction $degrees° $minutes' ${seconds.toStringAsFixed(2)}\"";
  }

  /// Converts DMS components to decimal degrees.
  ///
  /// [direction] must be one of 'N', 'S', 'E', 'W'.
  static double fromDms(
    int degrees,
    int minutes,
    double seconds,
    String direction,
  ) {
    final decimal = degrees + minutes / 60.0 + seconds / 3600.0;
    return (direction == 'S' || direction == 'W') ? -decimal : decimal;
  }

  /// Formats a latitude/longitude pair for aviation display.
  ///
  /// Example: `formatLatLon(40.6413, -73.7781)` →
  ///   `"N 40° 38' 28.68" / W 073° 46' 41.16""`
  static String formatLatLon(double lat, double lon) {
    return '${toDms(lat, isLatitude: true)} / ${toDms(lon, isLatitude: false)}';
  }

  /// Formats a latitude/longitude pair in compact decimal format.
  ///
  /// Example: `formatDecimal(40.6413, -73.7781)` → `"40.6413, -73.7781"`
  static String formatDecimal(double lat, double lon, {int precision = 4}) {
    return '${lat.toStringAsFixed(precision)}, '
        '${lon.toStringAsFixed(precision)}';
  }

  /// Converts degrees to radians.
  static double toRadians(double degrees) => degrees * math.pi / 180.0;

  /// Converts radians to degrees.
  static double toDegrees(double radians) => radians * 180.0 / math.pi;

  /// Normalizes a longitude to the range [-180, 180].
  static double normalizeLongitude(double lon) {
    while (lon > 180) {
      lon -= 360;
    }
    while (lon < -180) {
      lon += 360;
    }
    return lon;
  }

  /// Normalizes a bearing to the range [0, 360).
  static double normalizeBearing(double bearing) {
    return ((bearing % 360) + 360) % 360;
  }
}
