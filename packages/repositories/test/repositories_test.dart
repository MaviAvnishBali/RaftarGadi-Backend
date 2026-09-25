import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_data/mock_data.dart';
import 'package:repositories/repositories.dart';
import 'package:shared_models/shared_models.dart';

void main() {
  ProviderContainer makeContainer() {
    const env = AppEnvironment(
      flavor: AppFlavor.development,
      apiBaseUrl: 'x',
      simulatedLatency: Duration.zero,
    );
    final client = FakeApiClient(environment: env);
    registerMockRoutes(client);

    final container = ProviderContainer(
      overrides: [
        appEnvironmentProvider.overrideWithValue(env),
        apiClientProvider.overrideWithValue(client),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('BookingRepository.estimateFare returns a computed fare', () async {
    final repo = makeContainer().read(bookingRepositoryProvider);

    final result = await repo.estimateFare(
      vehicleType: VehicleType.auto,
      distanceKm: 5,
      durationMinutes: 15,
    );

    expect(result.isRight(), isTrue);
    expect(result.getRight().toNullable()!.distanceFare, 60);
  });

  test('CouponRepository.getCoupons paginates', () async {
    final repo = makeContainer().read(couponRepositoryProvider);

    final result = await repo.getCoupons(pageSize: 2);

    final page = result.getRight().toNullable()!;
    expect(page.items.length, 2);
    expect(page.total, 3);
    expect(page.hasMore, isTrue);
  });

  test('BookingRepository.getBooking surfaces NotFoundFailure', () async {
    final repo = makeContainer().read(bookingRepositoryProvider);

    final result = await repo.getBooking('does_not_exist');

    expect(result.isLeft(), isTrue);
    expect(result.getLeft().toNullable(), isA<NotFoundFailure>());
  });

  test('createBooking yields a searching booking', () async {
    final repo = makeContainer().read(bookingRepositoryProvider);
    final addresses = SeedData.addresses;

    final created = await repo.createBooking(
      customerId: 'usr_1',
      vehicleType: VehicleType.auto,
      pickup: addresses[0],
      drop: addresses[1],
      fare: const FareEstimate(
        baseFare: 40,
        distanceFare: 60,
        timeFare: 22.5,
        distanceKm: 5,
        durationMinutes: 15,
      ),
    );

    expect(created.isRight(), isTrue);
    expect(created.getRight().toNullable()!.status, BookingStatus.searching);
  });
}
