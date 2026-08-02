/// Unit tests for the Great Circle navigation library.
///
/// Tests validated against known aviation distances and bearings.
/// Reference data sourced from aviation databases and calculators.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';

import 'package:skynav/core/geo/great_circle.dart';

void main() {
  group('Haversine Distance', () {
    test('KJFK to KLAX — known distance ~2145 NM', () {
      const jfk = LatLng(40.6413, -73.7781);
      const lax = LatLng(33.9425, -118.4081);

      final distNm = GreatCircle.haversineDistanceNm(jfk, lax);

      // Accept 1% tolerance for spherical approximation
      expect(distNm, closeTo(2145, 25));
    });

    test('KJFK to EGLL (London) — known distance ~3000 NM', () {
      const jfk = LatLng(40.6413, -73.7781);
      const lhr = LatLng(51.4700, -0.4543);

      final distNm = GreatCircle.haversineDistanceNm(jfk, lhr);

      expect(distNm, closeTo(3000, 40));
    });

    test('Same point — distance should be 0', () {
      const point = LatLng(40, -74);

      final distNm = GreatCircle.haversineDistanceNm(point, point);

      expect(distNm, closeTo(0, 0.001));
    });

    test('Short distance — KJFK to KLGA (~10 NM)', () {
      const jfk = LatLng(40.6413, -73.7781);
      const lga = LatLng(40.7769, -73.8740);

      final distNm = GreatCircle.haversineDistanceNm(jfk, lga);

      expect(distNm, closeTo(10, 2));
    });
  });

  group('Vincenty Distance', () {
    test('KJFK to KLAX — should match Haversine within 1%', () {
      const jfk = LatLng(40.6413, -73.7781);
      const lax = LatLng(33.9425, -118.4081);

      final haversine = GreatCircle.haversineDistanceNm(jfk, lax);
      final vincenty = GreatCircle.vincentyDistanceNm(jfk, lax);

      // Vincenty should be within 1% of Haversine
      expect((vincenty - haversine).abs(), lessThan(haversine * 0.01));
    });

    test('Same point — distance should be 0', () {
      const point = LatLng(40, -74);

      final distNm = GreatCircle.vincentyDistanceNm(point, point);

      expect(distNm, closeTo(0, 0.001));
    });
  });

  group('Initial Bearing', () {
    test('Due north — 0°', () {
      const from = LatLng(40, -74);
      const to = LatLng(41, -74);

      final bearing = GreatCircle.initialBearing(from, to);

      expect(bearing, closeTo(0, 1));
    });

    test('Due east — 90°', () {
      const from = LatLng(0, 0);
      const to = LatLng(0, 1);

      final bearing = GreatCircle.initialBearing(from, to);

      expect(bearing, closeTo(90, 1));
    });

    test('Due south — 180°', () {
      const from = LatLng(41, -74);
      const to = LatLng(40, -74);

      final bearing = GreatCircle.initialBearing(from, to);

      expect(bearing, closeTo(180, 1));
    });

    test('Due west — 270°', () {
      const from = LatLng(0, 1);
      const to = LatLng(0, 0);

      final bearing = GreatCircle.initialBearing(from, to);

      expect(bearing, closeTo(270, 1));
    });

    test('KJFK to KLAX — approximately 274° (westbound)', () {
      const jfk = LatLng(40.6413, -73.7781);
      const lax = LatLng(33.9425, -118.4081);

      final bearing = GreatCircle.initialBearing(jfk, lax);

      // Westbound great circle from JFK to LAX
      expect(bearing, closeTo(274, 5));
    });
  });

  group('Final Bearing', () {
    test('Due north — final bearing should also be ~0°', () {
      const from = LatLng(40, -74);
      const to = LatLng(41, -74);

      final bearing = GreatCircle.finalBearing(from, to);

      expect(bearing, closeTo(0, 1));
    });
  });

  group('Destination Point', () {
    test('100 NM north from equator/prime meridian', () {
      const from = LatLng(0, 0);
      final dest = GreatCircle.destinationPoint(from, 0, 100);

      // ~1.67° north
      expect(dest.latitude, closeTo(1.67, 0.05));
      expect(dest.longitude, closeTo(0, 0.01));
    });

    test('0 NM — should return the same point', () {
      const from = LatLng(40, -74);
      final dest = GreatCircle.destinationPoint(from, 90, 0);

      expect(dest.latitude, closeTo(from.latitude, 0.001));
      expect(dest.longitude, closeTo(from.longitude, 0.001));
    });
  });

  group('Intermediate Points', () {
    test('Should return correct number of points', () {
      const from = LatLng(40, -74);
      const to = LatLng(41, -73);

      final points = GreatCircle.intermediatePoints(from, to, numPoints: 10);

      expect(points.length, equals(10));
    });

    test('First and last points should match from/to', () {
      const from = LatLng(40, -74);
      const to = LatLng(41, -73);

      final points = GreatCircle.intermediatePoints(from, to, numPoints: 10);

      expect(points.first.latitude, closeTo(from.latitude, 0.001));
      expect(points.first.longitude, closeTo(from.longitude, 0.001));
      expect(points.last.latitude, closeTo(to.latitude, 0.001));
      expect(points.last.longitude, closeTo(to.longitude, 0.001));
    });

    test('Same point — should return 2 identical points', () {
      const point = LatLng(40, -74);

      final points = GreatCircle.intermediatePoints(point, point, numPoints: 5);

      expect(points.length, equals(2));
    });
  });

  group('ETE Computation', () {
    test('100 NM at 100 kts — should be 1 hour', () {
      final ete = GreatCircle.computeEte(100, 100);

      expect(ete.inMinutes, equals(60));
    });

    test('250 NM at 120 kts — ~125 minutes', () {
      final ete = GreatCircle.computeEte(250, 120);

      expect(ete.inMinutes, closeTo(125, 1));
    });

    test('Zero ground speed — should return Duration.zero', () {
      final ete = GreatCircle.computeEte(100, 0);

      expect(ete, equals(Duration.zero));
    });

    test('Negative ground speed — should return Duration.zero', () {
      final ete = GreatCircle.computeEte(100, -50);

      expect(ete, equals(Duration.zero));
    });
  });

  group('Ground Speed', () {
    test('No wind — GS equals TAS', () {
      final gs = GreatCircle.groundSpeed(120, 90, 90, 0);

      expect(gs, closeTo(120, 0.1));
    });

    test('Direct headwind — GS = TAS - wind', () {
      // Heading 360 (north), wind from 360 (north) at 20 kts
      final gs = GreatCircle.groundSpeed(120, 0, 0, 20);

      expect(gs, closeTo(100, 0.5));
    });

    test('Direct tailwind — GS = TAS + wind', () {
      // Heading 360 (north), wind from 180 (south) at 20 kts
      final gs = GreatCircle.groundSpeed(120, 0, 180, 20);

      expect(gs, closeTo(140, 0.5));
    });
  });

  group('Bounding Box', () {
    test('50 NM radius around KJFK', () {
      const jfk = LatLng(40.6413, -73.7781);

      final (sw, ne) = GreatCircle.boundingBox(jfk, 50);

      // Box should be roughly 100 NM wide/tall
      expect(sw.latitude, lessThan(jfk.latitude));
      expect(sw.longitude, lessThan(jfk.longitude));
      expect(ne.latitude, greaterThan(jfk.latitude));
      expect(ne.longitude, greaterThan(jfk.longitude));

      // Check approximate extent (50 NM ≈ 0.83°)
      expect(ne.latitude - sw.latitude, closeTo(1.66, 0.1));
    });
  });
}
