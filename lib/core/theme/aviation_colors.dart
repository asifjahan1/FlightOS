/// Aviation-specific colors following FAA/ICAO standards.
///
/// These colors are used consistently for flight categories, airspace types,
/// and map overlays across the entire application.
library;

import 'package:flutter/material.dart';

/// Standard aviation colors for flight categories and map features.
abstract final class AviationColors {
  // ── Flight Category Colors (FAA Standard) ──

  /// VFR — Visual Flight Rules (ceiling > 3000ft, visibility > 5sm).
  static const Color vfr = Color(0xFF00C853);

  /// MVFR — Marginal VFR (ceiling 1000-3000ft, visibility 3-5sm).
  static const Color mvfr = Color(0xFF2979FF);

  /// IFR — Instrument Flight Rules (ceiling 500-1000ft, visibility 1-3sm).
  static const Color ifr = Color(0xFFFF1744);

  /// LIFR — Low IFR (ceiling < 500ft, visibility < 1sm).
  static const Color lifr = Color(0xFFE040FB);

  // ── Airport Marker Colors ──

  /// Towered airport marker color.
  static const Color toweredAirport = Color(0xFF2196F3);

  /// Non-towered airport marker color.
  static const Color nonToweredAirport = Color(0xFFE040FB);

  /// Heliport marker color.
  static const Color heliport = Color(0xFF9C27B0);

  /// Seaplane base marker color.
  static const Color seaplaneBase = Color(0xFF00BCD4);

  /// Closed airport marker color.
  static const Color closedAirport = Color(0xFF9E9E9E);

  // ── Airspace Colors (Semi-transparent for overlay) ──

  /// Class B airspace.
  static const Color airspaceClassB = Color(0x402979FF);

  /// Class C airspace.
  static const Color airspaceClassC = Color(0x40E040FB);

  /// Class D airspace.
  static const Color airspaceClassD = Color(0x402979FF);

  /// Class E airspace.
  static const Color airspaceClassE = Color(0x20E040FB);

  /// Restricted/Prohibited area.
  static const Color airspaceRestricted = Color(0x40FF1744);

  /// MOA (Military Operations Area).
  static const Color airspaceMoa = Color(0x20FF9100);

  /// TFR (Temporary Flight Restriction).
  static const Color tfrOverlay = Color(0x60FF1744);

  // ── Route Colors ──

  /// Active route/course line (standard aviation magenta).
  static const Color routeLine = Color(0xFFE040FB);

  /// Planned (inactive) route line.
  static const Color routeLinePlanned = Color(0xAAE040FB);

  /// Route waypoint marker.
  static const Color routeWaypoint = Color(0xFFFFFFFF);

  // ── Terrain Elevation Colors ──

  /// Terrain below 500ft AGL — danger.
  static const Color terrainDanger = Color(0xFFFF1744);

  /// Terrain 500–1000ft AGL — caution.
  static const Color terrainCaution = Color(0xFFFFD600);

  /// Terrain > 1000ft AGL — safe.
  static const Color terrainSafe = Color(0xFF00C853);

  // ── Traffic Colors ──

  /// Traffic — no threat.
  static const Color trafficNone = Color(0xFFB0BEC5);

  /// Traffic — proximate.
  static const Color trafficProximate = Color(0xFF00BCD4);

  /// Traffic advisory.
  static const Color trafficAdvisory = Color(0xFFFFD600);

  /// Resolution advisory (TCAS-like).
  static const Color trafficResolution = Color(0xFFFF1744);

  // ── Navaid Colors ──

  /// VOR symbol color.
  static const Color vorSymbol = Color(0xFF4CAF50);

  /// NDB symbol color.
  static const Color ndbSymbol = Color(0xFFFF9800);

  /// DME symbol color.
  static const Color dmeSymbol = Color(0xFF2196F3);
}
