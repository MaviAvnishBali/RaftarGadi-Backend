import 'package:core/core.dart';
import 'package:mock_data/src/mock_database.dart';
import 'package:mock_data/src/pagination.dart';
import 'package:shared_models/shared_models.dart';

/// Wires every fake endpoint onto `client`. Called once at app bootstrap:
///
/// ```dart
/// final client = FakeApiClient(environment: env);
/// registerMockRoutes(client);
/// ```
///
/// Each handler mirrors the request/response shape the real backend will use,
/// so repositories are written against the final contract today. `database`
/// can be injected for tests; otherwise a freshly seeded one is used.
/// The verification code the mock accepts. Shown as a hint in the OTP screen.
const String kDemoOtp = '123456';
const String _demoOtp = kDemoOtp;

MockDatabase registerMockRoutes(
  FakeApiClient client, {
  MockDatabase? database,
}) {
  final db = database ?? MockDatabase();

  // --- Auth -----------------------------------------------------------------
  client
    ..registerRoute('POST', '/auth/register', (body) async {
      final json = (body as Json?) ?? const {};
      final fullName = (json['fullName'] as String?)?.trim() ?? '';
      final phone = (json['phone'] as String?)?.trim() ?? '';
      final email = (json['email'] as String?)?.trim();
      if (fullName.length < 2) {
        throw const ValidationFailure('Enter your full name');
      }
      if (!_isIndianPhone(phone)) {
        throw const ValidationFailure('Enter a valid 10-digit phone number');
      }
      if (db.users.any((user) => user.phone == phone)) {
        throw const ValidationFailure(
          'An account already exists for this phone number. Please sign in.',
        );
      }
      db.users.add(
        AppUser(
          id: 'usr_${db.users.length + 1}',
          fullName: fullName,
          phone: phone,
          email: (email?.isEmpty ?? true) ? null : email,
          createdAt: DateTime.now().toUtc(),
        ),
      );
      return {'sent': true};
    })
    ..registerRoute('POST', '/auth/request-otp', (body) async {
      final json = (body as Json?) ?? const {};
      final phone = (json['phone'] as String?)?.trim() ?? '';
      if (!_isIndianPhone(phone)) {
        throw const ValidationFailure('Enter a valid 10-digit phone number');
      }
      if (!db.users.any((user) => user.phone == phone)) {
        throw const NotFoundFailure(
          'We could not find an account for this number. Create one first.',
        );
      }
      return {'sent': true};
    })
    ..registerRoute('POST', '/auth/verify-otp', (body) async {
      final json = (body as Json?) ?? const {};
      final otp = json['otp'] as String?;
      // Demo rule: 123456 succeeds; anything else is rejected, so the UI can
      // exercise the real invalid-code error path.
      if (otp != _demoOtp) {
        throw const AuthFailure('Invalid verification code');
      }
      final phone = (json['phone'] as String?)?.trim() ?? '';
      final user = db.users
          .where((candidate) => candidate.phone == phone)
          .firstOrNull;
      if (user == null) {
        throw const NotFoundFailure('No account found for this phone number');
      }
      return {'user': user.copyWith(isPhoneVerified: true).toJson()};
    })
    // --- Saved addresses ----------------------------------------------------
    ..registerRoute(
      'GET',
      '/addresses',
      (query) async => paginate<Address>(
        db.addresses,
        query as Query?,
        toJson: (a) => a.toJson(),
        matches: (a, q) =>
            a.title.toLowerCase().contains(q) ||
            a.formattedAddress.toLowerCase().contains(q),
      ),
    )
    // --- Coupons ------------------------------------------------------------
    ..registerRoute(
      'GET',
      '/coupons',
      (query) async => paginate<Coupon>(
        db.coupons,
        query as Query?,
        toJson: (c) => c.toJson(),
        matches: (c, q) =>
            c.code.toLowerCase().contains(q) ||
            c.title.toLowerCase().contains(q),
      ),
    )
    // --- Notifications ------------------------------------------------------
    ..registerRoute(
      'GET',
      '/notifications',
      (query) async => paginate<AppNotification>(
        db.notifications,
        query as Query?,
        toJson: (n) => n.toJson(),
      ),
    )
    // --- Drivers ------------------------------------------------------------
    ..registerRoute(
      'GET',
      '/drivers',
      (query) async => paginate<Driver>(
        db.drivers,
        query as Query?,
        toJson: (d) => d.toJson(),
        matches: (d, q) => d.fullName.toLowerCase().contains(q),
      ),
    )
    ..registerRoute('GET', '/driver', (query) async {
      final id = (query as Query?)?['id'] as String?;
      final driver = db.drivers.where((d) => d.id == id).firstOrNull;
      if (driver == null) throw NotFoundFailure('No driver $id');
      return {'driver': driver.toJson()};
    })
    // --- Wallet -------------------------------------------------------------
    ..registerRoute(
      'GET',
      '/wallet',
      (_) async => {'wallet': db.wallet.toJson()},
    )
    // --- Fare estimation ----------------------------------------------------
    ..registerRoute('POST', '/fare/estimate', (body) async {
      final json = (body as Json?) ?? const {};
      final type = VehicleType.values.byName(json['vehicleType'] as String);
      final distanceKm = (json['distanceKm'] as num).toDouble();
      final durationMinutes = (json['durationMinutes'] as num).toInt();
      final estimate = FareEstimate(
        baseFare: type.baseFare,
        distanceFare: type.perKm * distanceKm,
        timeFare: type.perMinute * durationMinutes,
        distanceKm: distanceKm,
        durationMinutes: durationMinutes,
      );
      return {'fare': estimate.toJson()};
    })
    // --- Bookings -----------------------------------------------------------
    ..registerRoute(
      'GET',
      '/bookings',
      (query) async {
        final customerId = (query as Query?)?['customerId'] as String?;
        final scoped = customerId == null
            ? db.bookings
            : db.bookings.where((b) => b.customerId == customerId).toList();
        return paginate<Booking>(
          scoped,
          query,
          toJson: (b) => b.toJson(),
        );
      },
    )
    ..registerRoute('GET', '/booking', (query) async {
      final id = (query as Query?)?['id'] as String?;
      final booking = db.bookings.where((b) => b.id == id).firstOrNull;
      if (booking == null) throw NotFoundFailure('No booking $id');
      return {'booking': booking.toJson()};
    })
    ..registerRoute('POST', '/bookings', (body) async {
      final json = (body as Json?) ?? const {};
      final booking = Booking.fromJson({
        ...json,
        'id': 'bkg_${db.bookings.length + 1}',
        'status': BookingStatus.searching.name,
        'createdAt': DateTime.now().toIso8601String(),
      });
      db.bookings.add(booking);
      return {'booking': booking.toJson()};
    });

  return db;
}

bool _isIndianPhone(String phone) => RegExp(r'^\+91\d{10}$').hasMatch(phone);
