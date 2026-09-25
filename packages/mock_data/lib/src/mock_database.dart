import 'package:mock_data/src/fixtures/seed_data.dart';
import 'package:shared_models/shared_models.dart';

/// The in-memory store behind the fake API. Mutable collections (bookings,
/// wallet) let the app exercise create/update flows within a session. A future
/// backend replaces this entirely — nothing outside `mock_data` references it.
class MockDatabase {
  MockDatabase({
    List<AppUser>? users,
    List<Address>? addresses,
    List<Driver>? drivers,
    List<Coupon>? coupons,
    List<AppNotification>? notifications,
    List<Booking>? bookings,
    Wallet? wallet,
  }) : users = users ?? [SeedData.customer],
       addresses = addresses ?? SeedData.addresses,
       drivers = drivers ?? SeedData.drivers,
       coupons = coupons ?? SeedData.coupons,
       notifications = notifications ?? SeedData.notifications,
       bookings = bookings ?? [],
       wallet = wallet ?? SeedData.wallet;

  final List<AppUser> users;
  final List<Address> addresses;
  final List<Driver> drivers;
  final List<Coupon> coupons;
  final List<AppNotification> notifications;
  final List<Booking> bookings;
  Wallet wallet;
}
