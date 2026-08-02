/// Great Circle navigation calculations using the WGS-84 ellipsoid.
///
/// Provides Haversine (fast, ~0.3% error) and Vincenty (accurate, <0.5mm error)
/// calculations for distance, bearing, and destination point computation.
///
/// All angles are in **degrees** at the API boundary.
/// Internal calculations use radians.
library;

import 'dart:math' as math;

import 'package:latlong2/latlong.dart';

import 'package:skynav/core/constants/aviation_constants.dart';

/// Great Circle calculations for aviation navigation.
///
/// Usage:
/// ```dart
/// final dist = GreatCircle.haversineDistanceNm(
///   LatLng(40.6413, -73.7781), // KJFK
///   LatLng(33.9425, -118.4081), // KLAX
/// );
/// // ≈ 2145 NM
/// ```
abstract final class GreatCircle {
  /// Degrees to radians conversion factor.
  static const double _deg2Rad = math.pi / 180.0;

  /// Radians to degrees conversion factor.
  static const double _rad2Deg = 180.0 / math.pi;

  // ── Haversine (Fast, ~0.3% error on sphere) ──

  /// Computes the great-circle distance in **nautical miles** using the
  /// Haversine formula (spherical Earth model).
  ///
  /// Accuracy: ~0.3% error (sufficient for display/ETA, not survey).
  /// Speed: ~10x faster than Vincenty.
  static double haversineDistanceNm(LatLng from, LatLng to) {
    return haversineDistanceMeters(from, to) * AviationUnits.metersToNm;
  }

  /// Computes the great-circle distance in **meters** using Haversine.
  static double haversineDistanceMeters(LatLng from, LatLng to) {
    final lat1 = from.latitudeInRad;
    final lat2 = to.latitudeInRad;
    final dLat = lat2 - lat1;
    final dLon = to.longitudeInRad - from.longitudeInRad;

    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(lat1) *
            math.cos(lat2) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);

    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return Earth.meanRadiusMeters * c;
  }

  // ── Vincenty (Accurate, <0.5mm error on ellipsoid) ──

  /// Computes the geodesic distance in **nautical miles** using the
  /// Vincenty inverse formula (WGS-84 ellipsoid).
  ///
  /// Accuracy: <0.5 mm (survey-grade).
  /// Falls back to Haversine for near-antipodal points where Vincenty
  /// may fail to converge.
  static double vincentyDistanceNm(LatLng from, LatLng to) {
    return vincentyDistanceMeters(from, to) * AviationUnits.metersToNm;
  }

  /// Computes the geodesic distance in **meters** using Vincenty.
  static double vincentyDistanceMeters(LatLng from, LatLng to) {
    final result = _vincentyInverse(from, to);
    return result.distanceMeters;
  }

  // ── Bearing ──

  /// Computes the **initial bearing** (forward azimuth) in degrees [0, 360)
  /// from [from] to [to].
  ///
  /// This is the compass heading to set at departure.
  static double initialBearing(LatLng from, LatLng to) {
    final lat1 = from.latitudeInRad;
    final lat2 = to.latitudeInRad;
    final dLon = (to.longitude - from.longitude) * _deg2Rad;

    final y = math.sin(dLon) * math.cos(lat2);
    final x = math.cos(lat1) * math.sin(lat2) -
        math.sin(lat1) * math.cos(lat2) * math.cos(dLon);

    return (_normalizeAngle(math.atan2(y, x) * _rad2Deg) + 360) % 360;
  }

  /// Computes the **final bearing** in degrees [0, 360) — the compass
  /// heading upon arrival at [to].
  static double finalBearing(LatLng from, LatLng to) {
    // Final bearing = reverse of initial bearing from `to` to `from`, + 180°.
    return (initialBearing(to, from) + 180) % 360;
  }

  // ── Destination Point ──

  /// Computes the destination point given a start point, initial bearing
  /// (degrees), and distance (nautical miles).
  static LatLng destinationPoint(
    LatLng from,
    double bearingDeg,
    double distanceNm,
  ) {
    final distRad =
        (distanceNm * AviationUnits.nmToMeters) / Earth.meanRadiusMeters;
    final bearingRad = bearingDeg * _deg2Rad;

    final lat1 = from.latitudeInRad;
    final lon1 = from.longitudeInRad;

    final lat2 = math.asin(
      math.sin(lat1) * math.cos(distRad) +
          math.cos(lat1) * math.sin(distRad) * math.cos(bearingRad),
    );

    final lon2 = lon1 +
        math.atan2(
          math.sin(bearingRad) * math.sin(distRad) * math.cos(lat1),
          math.cos(distRad) - math.sin(lat1) * math.sin(lat2),
        );

    return LatLng(lat2 * _rad2Deg, lon2 * _rad2Deg);
  }

  // ── Intermediate Points (for rendering great-circle arcs) ──

  /// Returns a list of intermediate points along the great circle from
  /// [from] to [to], suitable for rendering a route line.
  ///
  /// [numPoints] includes the start and end points.
  static List<LatLng> intermediatePoints(
    LatLng from,
    LatLng to, {
    int numPoints = 50,
  }) {
    if (numPoints < 2) {
      return [from, to];
    }

    final points = <LatLng>[];
    final lat1 = from.latitudeInRad;
    final lon1 = from.longitudeInRad;
    final lat2 = to.latitudeInRad;
    final lon2 = to.longitudeInRad;

    final d = haversineDistanceMeters(from, to) / Earth.meanRadiusMeters;

    if (d < 1e-10) {
      return [from, to];
    }

    for (var i = 0; i < numPoints; i++) {
      final f = i / (numPoints - 1);
      final a = math.sin((1 - f) * d) / math.sin(d);
      final b = math.sin(f * d) / math.sin(d);

      final x =
          a * math.cos(lat1) * math.cos(lon1) +
          b * math.cos(lat2) * math.cos(lon2);
      final y =
          a * math.cos(lat1) * math.sin(lon1) +
          b * math.cos(lat2) * math.sin(lon2);
      final z = a * math.sin(lat1) + b * math.sin(lat2);

      final lat = math.atan2(z, math.sqrt(x * x + y * y));
      final lon = math.atan2(y, x);

      points.add(LatLng(lat * _rad2Deg, lon * _rad2Deg));
    }

    return points;
  }

  // ── ETA / Ground Speed ──

  /// Computes estimated time enroute (ETE) as a [Duration].
  ///
  /// [distanceNm] is the distance in nautical miles.
  /// [groundSpeedKts] is the ground speed in knots.
  ///
  /// Returns [Duration.zero] if ground speed is zero or negative.
  static Duration computeEte(double distanceNm, double groundSpeedKts) {
    if (groundSpeedKts <= 0) {
      return Duration.zero;
    }
    final hours = distanceNm / groundSpeedKts;
    return Duration(seconds: (hours * 3600).round());
  }

  /// Computes ground speed from true airspeed and wind.
  ///
  /// [tasKts] — True Airspeed in knots.
  /// [headingTrue] — Aircraft heading (true) in degrees.
  /// [windDirTrue] — Wind direction (true) in degrees ("from").
  /// [windSpeedKts] — Wind speed in knots.
  static double groundSpeed(
    double tasKts,
    double headingTrue,
    double windDirTrue,
    double windSpeedKts,
  ) {
    // Wind correction: headwind component
    final windAngle = (windDirTrue - headingTrue) * _deg2Rad;
    final headwind = windSpeedKts * math.cos(windAngle);
    return tasKts - headwind;
  }

  /// Computes wind correction angle (WCA) in degrees.
  ///
  /// Positive = crab right, Negative = crab left.
  static double windCorrectionAngle(
    double tasKts,
    double courseTrue,
    double windDirTrue,
    double windSpeedKts,
  ) {
    final windAngle = (windDirTrue - courseTrue) * _deg2Rad;
    final crosswind = windSpeedKts * math.sin(windAngle);
    return math.asin(crosswind / tasKts) * _rad2Deg;
  }

  // ── Bounding Box ──

  /// Computes a bounding box around [center] with radius [radiusNm].
  ///
  /// Returns `(southWest, northEast)`.
  static (LatLng, LatLng) boundingBox(LatLng center, double radiusNm) {
    final latDelta =
        (radiusNm * AviationUnits.nmToMeters) /
        Earth.meanRadiusMeters *
        _rad2Deg;
    final lonDelta =
        latDelta / math.cos(center.latitudeInRad);

    return (
      LatLng(center.latitude - latDelta, center.longitude - lonDelta),
      LatLng(center.latitude + latDelta, center.longitude + lonDelta),
    );
  }

  // ── Private Helpers ──

  /// Normalizes an angle to the range [-180, 180].
  static double _normalizeAngle(double deg) {
    while (deg > 180) {
      deg -= 360;
    }
    while (deg < -180) {
      deg += 360;
    }
    return deg;
  }

  /// Vincenty inverse formula result.
  static _VincentyResult _vincentyInverse(LatLng from, LatLng to) {
    const a = Earth.semiMajorAxisMeters;
    const b = Earth.semiMinorAxisMeters;
    const f = Earth.flattening;
    const maxIterations = 200;
    const tolerance = 1e-12;

    final phi1 = from.latitudeInRad;
    final phi2 = to.latitudeInRad;
    final l = (to.longitude - from.longitude) * _deg2Rad;

    final u1 = math.atan((1 - f) * math.tan(phi1));
    final u2 = math.atan((1 - f) * math.tan(phi2));
    final sinU1 = math.sin(u1);
    final cosU1 = math.cos(u1);
    final sinU2 = math.sin(u2);
    final cosU2 = math.cos(u2);

    var lambda = l;
    var prevLambda = double.infinity;

    double sinSigma = 0;
    double cosSigma = 0;
    double sigma = 0;
    double sinAlpha = 0;
    double cos2Alpha = 0;
    double cos2SigmaM = 0;

    for (var i = 0; i < maxIterations; i++) {
      final sinLambda = math.sin(lambda);
      final cosLambda = math.cos(lambda);

      sinSigma = math.sqrt(
        (cosU2 * sinLambda) * (cosU2 * sinLambda) +
            (cosU1 * sinU2 - sinU1 * cosU2 * cosLambda) *
                (cosU1 * sinU2 - sinU1 * cosU2 * cosLambda),
      );

      if (sinSigma == 0) {
        return const _VincentyResult(distanceMeters: 0, initialBearing: 0);
      }

      cosSigma = sinU1 * sinU2 + cosU1 * cosU2 * cosLambda;
      sigma = math.atan2(sinSigma, cosSigma);

      sinAlpha = cosU1 * cosU2 * sinLambda / sinSigma;
      cos2Alpha = 1 - sinAlpha * sinAlpha;
      cos2SigmaM =
          cos2Alpha == 0 ? 0 : cosSigma - 2 * sinU1 * sinU2 / cos2Alpha;

      final c = f / 16 * cos2Alpha * (4 + f * (4 - 3 * cos2Alpha));

      prevLambda = lambda;
      lambda = l +
          (1 - c) *
              f *
              sinAlpha *
              (sigma +
                  c *
                      sinSigma *
                      (cos2SigmaM +
                          c * cosSigma * (-1 + 2 * cos2SigmaM * cos2SigmaM)));

      if ((lambda - prevLambda).abs() < tolerance) {
        break;
      }
    }

    // If Vincenty didn't converge, fall back to Haversine
    if ((lambda - prevLambda).abs() >= tolerance) {
      return _VincentyResult(
        distanceMeters: haversineDistanceMeters(from, to),
        initialBearing: initialBearing(from, to),
      );
    }

    final uSq = cos2Alpha * (a * a - b * b) / (b * b);
    final bigA =
        1 + uSq / 16384 * (4096 + uSq * (-768 + uSq * (320 - 175 * uSq)));
    final bigB =
        uSq / 1024 * (256 + uSq * (-128 + uSq * (74 - 47 * uSq)));

    final deltaSigma = bigB *
        sinSigma *
        (cos2SigmaM +
            bigB /
                4 *
                (cosSigma * (-1 + 2 * cos2SigmaM * cos2SigmaM) -
                    bigB /
                        6 *
                        cos2SigmaM *
                        (-3 + 4 * sinSigma * sinSigma) *
                        (-3 + 4 * cos2SigmaM * cos2SigmaM)));

    final s = b * bigA * (sigma - deltaSigma);

    return _VincentyResult(
      distanceMeters: s,
      initialBearing: initialBearing(from, to),
    );
  }
}

/// Internal result from Vincenty inverse computation.
class _VincentyResult {
  const _VincentyResult({
    required this.distanceMeters,
    required this.initialBearing,
  });

  final double distanceMeters;
  final double initialBearing;
}
