/// Domain-level error taxonomy used at repository boundaries.
///
/// UI and business logic switch over these instead of catching raw
/// exceptions, so swapping the data source (mock -> real API) never leaks
/// transport-specific error types upward.
sealed class Failure implements Exception {
  const Failure(this.message, [this.cause]);

  final String message;
  final Object? cause;
}

/// Connectivity / transport problem (timeouts, no network, 5xx).
final class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Network error', super.cause]);
}

/// The requested resource does not exist (404-equivalent).
final class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Not found', super.cause]);
}

/// Input failed validation before or after reaching the data source.
final class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Invalid input', super.cause]);
}

/// Local cache / storage read or write failed.
final class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache error', super.cause]);
}

/// Authentication or authorization problem (401/403-equivalent).
final class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Authentication error', super.cause]);
}

/// Anything not otherwise classified.
final class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Something went wrong', super.cause]);
}
