import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_models/src/vehicle/vehicle.dart';

part 'driver.freezed.dart';
part 'driver.g.dart';

/// A driver's current availability to receive ride offers.
enum DriverAvailability { offline, online, onTrip }

/// A driver/partner on the platform.
@freezed
abstract class Driver with _$Driver {
  const factory Driver({
    required String id,
    required String fullName,
    required String phone,
    required Vehicle vehicle,
    @Default(DriverAvailability.offline) DriverAvailability availability,
    @Default(0) double rating,
    @Default(0) int totalTrips,
    String? photoUrl,
  }) = _Driver;

  factory Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);
}
