/// Domain-layer failure types.
///
/// Failures represent expected error conditions that the domain layer
/// communicates to the presentation layer. They do NOT carry stack traces.
library;

import 'package:equatable/equatable.dart';

/// Base class for all domain failures.
sealed class Failure extends Equatable {
  const Failure({this.message = ''});

  /// Human-readable error message.
  final String message;

  @override
  List<Object?> get props => [message];
}

/// Failure when a required database operation fails.
class DatabaseFailure extends Failure {
  const DatabaseFailure({super.message = 'Database operation failed'});
}

/// Failure when a required file is missing or corrupted.
class FileSystemFailure extends Failure {
  const FileSystemFailure({super.message = 'File system error'});
}

/// Failure when map tiles cannot be loaded.
class TileLoadFailure extends Failure {
  const TileLoadFailure({super.message = 'Failed to load map tiles'});
}

/// Failure when a data package has an invalid checksum.
class IntegrityFailure extends Failure {
  const IntegrityFailure({super.message = 'Data integrity check failed'});
}

/// Failure when a network request fails (only relevant when online).
class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'Network request failed'});
}

/// Failure when a GPS/telemetry source is unavailable.
class TelemetryFailure extends Failure {
  const TelemetryFailure({super.message = 'Telemetry source unavailable'});
}

/// Failure when a requested entity is not found.
class NotFoundFailure extends Failure {
  const NotFoundFailure({super.message = 'Entity not found'});
}

/// Failure for unexpected/unknown errors.
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({super.message = 'An unexpected error occurred'});
}
