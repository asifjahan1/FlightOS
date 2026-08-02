/// Application-wide constants.
library;

/// Application metadata.
abstract final class AppConstants {
  /// Application name.
  static const String appName = 'SkyNav';

  /// Application version (should match pubspec.yaml).
  static const String version = '0.1.0';

  /// Default data directory path on Linux.
  static const String defaultDataPath = '/opt/skynav/data';

  /// Fallback data directory (user-writable).
  static const String fallbackDataPath = '.skynav/data';

  /// Log file name.
  static const String logFileName = 'skynav.log';

  /// Maximum log file size in bytes (10 MB).
  static const int maxLogSizeBytes = 10 * 1024 * 1024;
}

/// Database file names.
abstract final class DatabaseConstants {
  /// Airport database file.
  static const String airportsDb = 'airports.db';

  /// User data database file (routes, favorites, logs, settings).
  static const String userDb = 'user.db';

  /// Tile cache database file.
  static const String tileCacheDb = 'tile_cache.db';

  /// Weather cache database file.
  static const String weatherCacheDb = 'weather_cache.db';
}
