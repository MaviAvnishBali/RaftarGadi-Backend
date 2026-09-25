/// Raftar Gaddi — `shared_models` package.
///
/// Immutable domain entities (Freezed + JSON) shared by every app and the
/// data layer. Models are pure data with derived getters only — no I/O, no
/// framework dependency — so they are safe to use in any layer.
library;

export 'src/address/address.dart';
export 'src/booking/booking.dart';
export 'src/booking/fare_estimate.dart';
export 'src/common/geo_point.dart';
export 'src/common/paginated_response.dart';
export 'src/coupon/coupon.dart';
export 'src/driver/driver.dart';
export 'src/notification/app_notification.dart';
export 'src/trip/trip.dart';
export 'src/user/app_user.dart';
export 'src/vehicle/vehicle.dart';
export 'src/wallet/wallet.dart';
