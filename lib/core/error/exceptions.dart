/// Data-layer exception types.
///
/// Exceptions are thrown by data sources and caught by repository
/// implementations, which convert them into domain [Failure]s.
library;

/// Base class for all data-layer exceptions.
sealed class AppException implements Exception {
  const AppException({this.message = '', this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() => '$runtimeType: $message';
}

/// Thrown when a database query or operation fails.
class DatabaseException extends AppException {
  const DatabaseException({super.message = 'Database error', super.cause});
}

/// Thrown when a required file cannot be read or is corrupted.
class FileSystemException extends AppException {
  const FileSystemException({
    super.message = 'File system error',
    super.cause,
  });
}

/// Thrown when map tile data cannot be read or decoded.
class TileException extends AppException {
  const TileException({super.message = 'Tile read error', super.cause});
}

/// Thrown when SHA-256 checksum verification fails.
class IntegrityException extends AppException {
  const IntegrityException({
    super.message = 'Integrity check failed',
    super.cause,
  });
}

/// Thrown when a network request fails.
class NetworkException extends AppException {
  const NetworkException({super.message = 'Network error', super.cause});
}

/// Thrown when a serial port or telemetry device fails.
class TelemetryException extends AppException {
  const TelemetryException({
    super.message = 'Telemetry device error',
    super.cause,
  });
}
