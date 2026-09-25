import 'package:core/core.dart';
import 'package:shared_models/shared_models.dart';

/// Contract for fare estimation and the booking lifecycle.
abstract interface class BookingRepository {
  Future<Result<FareEstimate>> estimateFare({
    required VehicleType vehicleType,
    required double distanceKm,
    required int durationMinutes,
  });

  Future<Result<Booking>> createBooking({
    required String customerId,
    required VehicleType vehicleType,
    required Address pickup,
    required Address drop,
    required FareEstimate fare,
    String? couponCode,
    String? note,
    DateTime? scheduledAt,
  });

  Future<Result<PaginatedResponse<Booking>>> getBookings({
    required String customerId,
    int page = 1,
    int pageSize = 20,
  });

  Future<Result<Booking>> getBooking(String id);
}

/// [ApiClient]-backed implementation.
class ApiBookingRepository implements BookingRepository {
  ApiBookingRepository(this._api);

  final ApiClient _api;

  @override
  Future<Result<FareEstimate>> estimateFare({
    required VehicleType vehicleType,
    required double distanceKm,
    required int durationMinutes,
  }) => guardAsync(() async {
    final json = await _api.post(
      '/fare/estimate',
      body: {
        'vehicleType': vehicleType.name,
        'distanceKm': distanceKm,
        'durationMinutes': durationMinutes,
      },
    );
    return FareEstimate.fromJson(json['fare'] as Map<String, dynamic>);
  });

  @override
  Future<Result<Booking>> createBooking({
    required String customerId,
    required VehicleType vehicleType,
    required Address pickup,
    required Address drop,
    required FareEstimate fare,
    String? couponCode,
    String? note,
    DateTime? scheduledAt,
  }) => guardAsync(() async {
    final json = await _api.post(
      '/bookings',
      body: {
        'customerId': customerId,
        'vehicleType': vehicleType.name,
        'pickup': pickup.toJson(),
        'drop': drop.toJson(),
        'fare': fare.toJson(),
        'couponCode': ?couponCode,
        'note': ?note,
        if (scheduledAt != null) 'scheduledAt': scheduledAt.toIso8601String(),
      },
    );
    return Booking.fromJson(json['booking'] as Map<String, dynamic>);
  });

  @override
  Future<Result<PaginatedResponse<Booking>>> getBookings({
    required String customerId,
    int page = 1,
    int pageSize = 20,
  }) => guardAsync(() async {
    final json = await _api.get(
      '/bookings',
      query: {
        'customerId': customerId,
        'page': page,
        'pageSize': pageSize,
      },
    );
    return PaginatedResponse.fromJson(
      json,
      (item) => Booking.fromJson(item! as Map<String, dynamic>),
    );
  });

  @override
  Future<Result<Booking>> getBooking(String id) => guardAsync(() async {
    final json = await _api.get('/booking', query: {'id': id});
    return Booking.fromJson(json['booking'] as Map<String, dynamic>);
  });
}
