import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repositories/src/address/address_repository.dart';
import 'package:repositories/src/auth/auth_repository.dart';
import 'package:repositories/src/booking/booking_repository.dart';
import 'package:repositories/src/coupon/coupon_repository.dart';
import 'package:repositories/src/driver/driver_repository.dart';
import 'package:repositories/src/vehicle/vehicle_repository.dart';
import 'package:repositories/src/notification/notification_repository.dart';
import 'package:repositories/src/wallet/wallet_repository.dart';

/// Repository providers. Each binds an abstract contract to its
/// [ApiClient]-backed implementation, reading the client from
/// `apiClientProvider` in `core`. Swapping mock for a real backend happens once
/// in that single provider — every repository below is unaffected.

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => ApiAuthRepository(ref.watch(apiClientProvider)),
);

final addressRepositoryProvider = Provider<AddressRepository>(
  (ref) => ApiAddressRepository(ref.watch(apiClientProvider)),
);

final bookingRepositoryProvider = Provider<BookingRepository>(
  (ref) => ApiBookingRepository(ref.watch(apiClientProvider)),
);

final couponRepositoryProvider = Provider<CouponRepository>(
  (ref) => ApiCouponRepository(ref.watch(apiClientProvider)),
);

final walletRepositoryProvider = Provider<WalletRepository>(
  (ref) => ApiWalletRepository(ref.watch(apiClientProvider)),
);

final notificationRepositoryProvider = Provider<NotificationRepository>(
  (ref) => ApiNotificationRepository(ref.watch(apiClientProvider)),
);

final driverRepositoryProvider = Provider<DriverRepository>(
  (ref) => ApiDriverRepository(ref.watch(apiClientProvider)),
);

final vehicleRepositoryProvider = Provider<VehicleRepository>(
  (ref) => ApiVehicleRepository(ref.watch(apiClientProvider)),
);
