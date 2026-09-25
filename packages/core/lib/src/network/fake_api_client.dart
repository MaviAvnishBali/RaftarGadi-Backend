import 'dart:math';

import 'package:core/src/config/app_environment.dart';
import 'package:core/src/network/api_client.dart';
import 'package:core/src/result/failure.dart';

/// In-memory [ApiClient] that simulates real network behaviour: latency and
/// optional random failures. It owns no data itself — the `mock_data` package
/// registers route handlers in later phases. Phase 0 ships the timing and
/// failure machinery so the seam is proven end-to-end.
class FakeApiClient implements ApiClient {
  FakeApiClient({required this.environment, Random? random})
    : _random = random ?? Random();

  final AppEnvironment environment;
  final Random _random;

  /// Route handlers keyed by "METHOD path". Populated by `mock_data`.
  final Map<String, Future<Json> Function(Object? payload)> _routes = {};

  void registerRoute(
    String method,
    String path,
    Future<Json> Function(Object? payload) handler,
  ) {
    _routes['${method.toUpperCase()} $path'] = handler;
  }

  Future<Json> _handle(String method, String path, Object? payload) async {
    await Future<void>.delayed(environment.simulatedLatency);

    if (environment.simulatedFailureRate > 0 &&
        _random.nextDouble() < environment.simulatedFailureRate) {
      throw const NetworkFailure('Simulated network failure');
    }

    final handler = _routes['${method.toUpperCase()} $path'];
    if (handler == null) {
      throw NotFoundFailure('No fake route for $method $path');
    }
    return handler(payload);
  }

  @override
  Future<Json> get(String path, {Query? query}) => _handle('GET', path, query);

  @override
  Future<Json> post(String path, {Object? body}) => _handle('POST', path, body);

  @override
  Future<Json> put(String path, {Object? body}) => _handle('PUT', path, body);

  @override
  Future<Json> delete(String path, {Object? body}) =>
      _handle('DELETE', path, body);
}
