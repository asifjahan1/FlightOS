/// Map-related constants: defaults, zoom levels, tile configuration.
library;

import 'package:latlong2/latlong.dart';

/// Default map configuration values.
abstract final class MapConstants {
  /// Default map center (geographic center of contiguous US).
  static const LatLng defaultCenter = LatLng(39.8283, -98.5795);

  /// Default zoom level.
  static const double defaultZoom = 5;

  /// Minimum zoom level.
  static const double minZoom = 2;

  /// Maximum zoom level.
  static const double maxZoom = 18;

  /// Default tile size in pixels.
  static const int tileSize = 256;

  /// Maximum MBTiles zoom level for basemap (aviation doesn't need z15+).
  static const int maxBasemapZoom = 14;

  /// Maximum MBTiles zoom level for aviation overlay.
  static const int maxAviationZoom = 12;

  /// Zoom level at which marker clustering begins.
  static const double clusterZoomThreshold = 8;

  /// Zoom level at which individual airport markers appear.
  static const double airportMarkerZoom = 6;

  /// Number of tiles to pre-fetch beyond viewport edge.
  static const int tilePrefetchMargin = 1;

  /// Maximum memory cache size for decoded tiles (bytes).
  /// 256 MB — suitable for Linux desktop with ample RAM.
  static const int maxTileCacheBytes = 256 * 1024 * 1024;

  /// Duration to keep tiles in memory cache before eviction (minutes).
  static const int tileCacheTtlMinutes = 60;
}
