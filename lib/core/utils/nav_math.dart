import 'package:latlong2/latlong.dart';

/// Navigation Math utility class.
class NavMath {
  static const Distance _distanceCalculator = Distance();
  static const double metersPerNm = 1852;

  /// Calculate great circle distance between two points in Nautical Miles (NM).
  static double distanceNm(double lat1, double lon1, double lat2, double lon2) {
    final meters = _distanceCalculator(LatLng(lat1, lon1), LatLng(lat2, lon2));
    return meters / metersPerNm;
  }

  /// Calculate great circle distance between two points in Kilometers (KM).
  static double distanceKm(double lat1, double lon1, double lat2, double lon2) {
    final meters = _distanceCalculator(LatLng(lat1, lon1), LatLng(lat2, lon2));
    return meters / 1000.0;
  }

  /// Calculate Estimated Time Enroute (ETE) in minutes based on distance (NM) and speed (Knots).
  static double calculateEteMinutes(double distanceNm, double speedKnots) {
    if (speedKnots <= 0) return 0;
    // Time (hours) = Distance (NM) / Speed (Knots)
    final hours = distanceNm / speedKnots;
    return hours * 60.0;
  }

  /// Formats minutes into a standard aviation HH:MM string.
  static String formatEte(double minutes) {
    if (minutes <= 0 || minutes.isInfinite || minutes.isNaN) return '--:--';
    final hours = (minutes / 60).floor();
    final remainingMins = (minutes % 60).round();
    return '${hours.toString().padLeft(2, '0')}:${remainingMins.toString().padLeft(2, '0')}';
  }

  /// Formats minutes into Days and Hours or Hours and Minutes (e.g., "1D 14H").
  static String formatEteDh(double minutes) {
    if (minutes <= 0 || minutes.isInfinite || minutes.isNaN) return '--';

    final int days = (minutes / (60 * 24)).floor();
    final int hours = ((minutes % (60 * 24)) / 60).floor();
    final int mins = (minutes % 60).round();

    if (days > 0) {
      return '${days}D ${hours}H';
    } else if (hours > 0) {
      return '${hours}H ${mins}M';
    } else {
      return '${mins}M';
    }
  }
}
