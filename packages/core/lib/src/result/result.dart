import 'package:core/src/result/failure.dart';
import 'package:fpdart/fpdart.dart';

/// The canonical return type for anything that can fail: a repository call,
/// a use case, a service. `Left` is a [Failure]; `Right` is the value.
///
/// Chosen over throwing so failure is part of the type signature and callers
/// are forced to handle it (no silent uncaught exceptions crossing layers).
typedef Result<T> = Either<Failure, T>;

/// Ergonomic constructors so call sites don't import `fpdart` directly.
Result<T> success<T>(T value) => Right(value);
Result<T> failure<T>(Failure failure) => Left(failure);

/// Wraps a throwing async computation into a [Result], mapping any thrown
/// object to [UnknownFailure] unless a [mapError] is supplied.
Future<Result<T>> guardAsync<T>(
  Future<T> Function() body, {
  Failure Function(Object error, StackTrace stackTrace)? mapError,
}) async {
  try {
    return success(await body());
  } on Failure catch (failure) {
    // Already-typed domain failures (e.g. NotFoundFailure) pass through
    // unchanged so callers can switch on the specific type.
    return Left(failure);
  } on Object catch (error, stackTrace) {
    return failure(
      mapError?.call(error, stackTrace) ??
          UnknownFailure(error.toString(), error),
    );
  }
}
