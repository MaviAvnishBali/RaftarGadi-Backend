import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Result', () {
    test('success carries the value', () {
      final result = success<int>(42);
      expect(result.getRight().toNullable(), 42);
    });

    test('failure carries the Failure', () {
      final result = failure<int>(const NotFoundFailure());
      expect(result.getLeft().toNullable(), isA<NotFoundFailure>());
    });

    test('guardAsync maps a thrown error to UnknownFailure', () async {
      final result = await guardAsync<int>(() async => throw Exception('boom'));
      expect(result.isLeft(), isTrue);
      expect(result.getLeft().toNullable(), isA<UnknownFailure>());
    });
  });

  group('FakeApiClient', () {
    FakeApiClient client() => FakeApiClient(
      environment: const AppEnvironment(
        flavor: AppFlavor.development,
        apiBaseUrl: 'x',
        simulatedLatency: Duration.zero,
      ),
    );

    test('routes to a registered handler after simulated latency', () async {
      final api = client()
        ..registerRoute('GET', '/ping', (_) async => {'ok': true});
      final response = await api.get('/ping');
      expect(response['ok'], isTrue);
    });

    test('unregistered route yields NotFoundFailure', () async {
      expect(
        () => client().get('/missing'),
        throwsA(isA<NotFoundFailure>()),
      );
    });
  });
}
