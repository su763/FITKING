/// failures.dart
///
/// Sealed class hierarchy representing all domain-level failures in FitKing.
///
/// These are used as the Left side of a `dartz.Either<Failure, T>` result
/// returned from use cases and repositories. No layer above the Domain
/// should ever see raw exceptions — only typed Failures.
library;

import 'package:equatable/equatable.dart';

// ── Base ────────────────────────────────────────────────────────────────────

/// The root type for every failure in the system.
///
/// All concrete failures extend [Failure] so callers can pattern-match
/// exhaustively with a `switch` expression.
sealed class Failure extends Equatable {
  const Failure({
    required this.message,
    this.code,
    this.stackTrace,
  });

  /// Human-readable reason for the failure (for logs, not UI strings).
  final String message;

  /// Optional machine-readable code (e.g. HTTP status, Hive error code).
  final String? code;

  /// Captured stack trace for diagnostics; stripped in production logs.
  final StackTrace? stackTrace;

  @override
  List<Object?> get props => [message, code];
}

// ── Network Failures ────────────────────────────────────────────────────────

/// The device has no active internet connection.
final class NoInternetFailure extends Failure {
  const NoInternetFailure({
    super.message = 'No internet connection. Please check your network.',
    super.code = 'NO_INTERNET',
    super.stackTrace,
  });
}

/// The request timed out before a response was received.
final class TimeoutFailure extends Failure {
  const TimeoutFailure({
    super.message = 'The request timed out. Please try again.',
    super.code = 'TIMEOUT',
    super.stackTrace,
  });
}

/// The server returned a non-2xx HTTP response.
final class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.code,
    super.stackTrace,
    this.statusCode,
    this.responseBody,
  });

  /// The HTTP status code returned by the server.
  final int? statusCode;

  /// Raw response body for diagnostic purposes.
  final String? responseBody;

  @override
  List<Object?> get props => [...super.props, statusCode];
}

/// The server response could not be decoded into the expected shape.
final class DeserializationFailure extends Failure {
  const DeserializationFailure({
    required super.message,
    super.code = 'DESERIALIZATION_ERROR',
    super.stackTrace,
  });
}

// ── Cache / Storage Failures ─────────────────────────────────────────────────

/// A read or write operation on the local Hive store failed.
final class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.code = 'CACHE_ERROR',
    super.stackTrace,
  });
}

/// The requested item was not found in local storage.
final class CacheNotFoundFailure extends Failure {
  const CacheNotFoundFailure({
    super.message = 'The requested data was not found in local storage.',
    super.code = 'CACHE_NOT_FOUND',
    super.stackTrace,
  });
}

// ── Domain / Validation Failures ────────────────────────────────────────────

/// Business rule or input validation failed.
final class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.code = 'VALIDATION_ERROR',
    super.stackTrace,
    this.fieldErrors = const {},
  });

  /// Map of field name → list of error messages for form validation.
  final Map<String, List<String>> fieldErrors;

  @override
  List<Object?> get props => [...super.props, fieldErrors];
}

/// An operation was attempted that is not permitted under the current state.
final class InvalidOperationFailure extends Failure {
  const InvalidOperationFailure({
    required super.message,
    super.code = 'INVALID_OPERATION',
    super.stackTrace,
  });
}

// ── Unexpected / Internal Failures ───────────────────────────────────────────

/// A failure that was not anticipated — wraps an unexpected exception.
///
/// This should be the last resort; prefer using specific subtypes.
final class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    super.message = 'An unexpected error occurred. Please try again.',
    super.code = 'UNEXPECTED_ERROR',
    super.stackTrace,
    this.originalException,
  });

  /// The original unhandled exception, available for diagnostics.
  final Object? originalException;

  @override
  List<Object?> get props => [...super.props, originalException];
}
