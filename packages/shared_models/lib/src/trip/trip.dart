import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_models/src/common/geo_point.dart';

part 'trip.freezed.dart';
part 'trip.g.dart';

/// Execution state of an assigned trip (mirrors the driver's progress).
enum TripStatus {
  assigned,
  headingToPickup,
  atPickup,
  goodsLoaded,
  inTransit,
  atDrop,
  completed,
  cancelled,
}

/// A single timeline entry, used to render the trip progress feed.
@freezed
abstract class TripEvent with _$TripEvent {
  const factory TripEvent({
    required TripStatus status,
    required DateTime timestamp,
    String? note,
  }) = _TripEvent;

  factory TripEvent.fromJson(Map<String, dynamic> json) =>
      _$TripEventFromJson(json);
}

/// The live, driver-side execution of a `Booking`. Holds the moving parts:
/// current status, last known driver location, and the event timeline.
@freezed
abstract class Trip with _$Trip {
  const factory Trip({
    required String id,
    required String bookingId,
    required String driverId,
    @Default(TripStatus.assigned) TripStatus status,
    GeoPoint? driverLocation,
    @Default(<TripEvent>[]) List<TripEvent> events,
    DateTime? startedAt,
    DateTime? completedAt,
  }) = _Trip;

  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);
}
