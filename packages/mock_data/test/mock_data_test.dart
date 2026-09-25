import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_data/mock_data.dart';
import 'package:shared_models/shared_models.dart';

void main() {
  late FakeApiClient client;

  setUp(() {
    client = FakeApiClient(
      environment: const AppEnvironment(
        flavor: AppFlavor.development,
        apiBaseUrl: 'x',
        simulatedLatency: Duration.zero,
      ),
    );
    registerMockRoutes(client);
  });

  test('coupons paginate', () async {
    final res = await client.get('/coupons', query: {'page': 1, 'pageSize': 2});
    expect((res['items'] as List).length, 2);
    expect(res['total'], 3);
  });

  test('coupon search filters by code/title', () async {
    final res = await client.get('/coupons', query: {'q': 'truck'});
    expect((res['items'] as List).length, 1);
  });

  test('fare estimate is computed from vehicle metadata', () async {
    final res = await client.post(
      '/fare/estimate',
      body: {'vehicleType': 'auto', 'distanceKm': 5, 'durationMinutes': 15},
    );
    final fare = FareEstimate.fromJson(res['fare'] as Map<String, dynamic>);
    expect(fare.baseFare, 40); // auto base
    expect(fare.distanceFare, 60); // 12 * 5
    expect(fare.timeFare, 22.5); // 1.5 * 15
  });

  test('creating a booking persists it and it is then listable', () async {
    final addresses = SeedData.addresses;
    final res = await client.post(
      '/bookings',
      body: {
        'customerId': 'usr_1',
        'vehicleType': VehicleType.auto.name,
        'pickup': addresses[0].toJson(),
        'drop': addresses[1].toJson(),
        'fare': const FareEstimate(
          baseFare: 40,
          distanceFare: 60,
          timeFare: 22.5,
          distanceKm: 5,
          durationMinutes: 15,
        ).toJson(),
      },
    );

    final created = Booking.fromJson(res['booking'] as Map<String, dynamic>);
    expect(created.status, BookingStatus.searching);
    expect(created.id, 'bkg_1');

    final list = await client.get('/bookings', query: {'customerId': 'usr_1'});
    expect((list['items'] as List).length, 1);
  });

  test('unknown single resource yields NotFoundFailure', () async {
    expect(
      () => client.get('/booking', query: {'id': 'nope'}),
      throwsA(isA<NotFoundFailure>()),
    );
  });

  group('OTP verification', () {
    test('the demo code returns the account for the entered phone', () async {
      final res = await client.post(
        '/auth/verify-otp',
        body: {'phone': '+919812345678', 'otp': kDemoOtp},
      );
      final user = AppUser.fromJson(res['user'] as Map<String, dynamic>);
      expect(user.phone, '+919812345678');
      expect(user.isPhoneVerified, isTrue);
    });

    test('a wrong code throws AuthFailure', () async {
      expect(
        () => client.post(
          '/auth/verify-otp',
          body: {'phone': '+910000000000', 'otp': '000000'},
        ),
        throwsA(isA<AuthFailure>()),
      );
    });
  });

  test(
    'registration creates an account that can receive and verify an OTP',
    () async {
      await client.post(
        '/auth/register',
        body: {
          'fullName': 'Meera Iyer',
          'phone': '+919876543210',
          'email': 'meera@example.com',
        },
      );
      await client.post(
        '/auth/request-otp',
        body: {'phone': '+919876543210'},
      );
      final response = await client.post(
        '/auth/verify-otp',
        body: {'phone': '+919876543210', 'otp': kDemoOtp},
      );

      final user = AppUser.fromJson(response['user'] as Map<String, dynamic>);
      expect(user.fullName, 'Meera Iyer');
      expect(user.email, 'meera@example.com');
    },
  );

  test('login rejects an unknown account', () async {
    expect(
      () => client.post(
        '/auth/request-otp',
        body: {'phone': '+919876543210'},
      ),
      throwsA(isA<NotFoundFailure>()),
    );
  });
}
