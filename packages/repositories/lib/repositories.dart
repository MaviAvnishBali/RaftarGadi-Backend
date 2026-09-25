/// Raftar Gaddi — `repositories` package.
///
/// Repository contracts (abstract interfaces) plus `ApiClient`-backed
/// implementations, exposed through Riverpod providers. All I/O returns
/// `Result<T>`; the same implementation runs against the mock or a real API,
/// so business logic and UI never change when the backend arrives.
library;

export 'src/address/address_repository.dart';
export 'src/auth/auth_repository.dart';
export 'src/booking/booking_repository.dart';
export 'src/coupon/coupon_repository.dart';
export 'src/driver/driver_repository.dart';
export 'src/notification/notification_repository.dart';
export 'src/repository_providers.dart';
export 'src/wallet/wallet_repository.dart';
export 'src/vehicle/vehicle_repository.dart';
