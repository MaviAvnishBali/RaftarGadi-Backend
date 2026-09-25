import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_models/src/address/address.dart';
import 'package:shared_models/src/booking/fare_estimate.dart';
import 'package:shared_models/src/vehicle/vehicle.dart';

part 'booking.freezed.dart';
part 'booking.g.dart';

/// Lifecycle of a booking from request to completion.
enum BookingStatus {
  draft,
  searching,
  driverAssigned,
  arrivingPickup,
  inTransit,
  completed,
  cancelled,
}

/// A customer's request to move goods from [pickup] to [drop]. When a driver
/// is assigned a `Trip` is created to track execution; the booking holds the
/// commercial facts (who, what, how much).
@freezed
abstract class Booking with _$Booking {
  const factory Booking({
    required String id,
    required String customerId,
    required VehicleType vehicleType,
    required Address pickup,
    required Address drop,
    required FareEstimate fare,
    required DateTime createdAt,
    @Default(BookingStatus.draft) BookingStatus status,
    String? driverId,
    String? tripId,
    String? couponCode,
    String? note,
    DateTime? scheduledAt,
  }) = _Booking;

  const Booking._();

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);

  /// A scheduled booking is one with a future pickup time.
  bool get isScheduled => scheduledAt != null;

  bool get isActive => switch (status) {
    BookingStatus.searching ||
    BookingStatus.driverAssigned ||
    BookingStatus.arrivingPickup ||
    BookingStatus.inTransit => true,
    _ => false,
  };
}
