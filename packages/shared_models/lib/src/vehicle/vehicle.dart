import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle.freezed.dart';
part 'vehicle.g.dart';

/// The classes of vehicle a customer can book. Ordered lightest to heaviest.
enum VehicleType { bike, auto, miniTruck, truck }

/// Static, non-persisted presentation + pricing metadata for each
/// [VehicleType]. Kept out of the serialized model: it's config, not data.
extension VehicleTypeInfo on VehicleType {
  String get label => switch (this) {
    VehicleType.bike => 'Bike',
    VehicleType.auto => 'Auto',
    VehicleType.miniTruck => 'Mini Truck',
    VehicleType.truck => 'Truck',
  };

  String get description => switch (this) {
    VehicleType.bike => 'Small parcels up to 20 kg',
    VehicleType.auto => 'Boxes and bags up to 500 kg',
    VehicleType.miniTruck => 'Furniture and appliances up to 1 tonne',
    VehicleType.truck => 'Bulk goods up to 3 tonnes',
  };

  int get capacityKg => switch (this) {
    VehicleType.bike => 20,
    VehicleType.auto => 500,
    VehicleType.miniTruck => 1000,
    VehicleType.truck => 3000,
  };

  /// Fare components in the platform's base currency (INR).
  double get baseFare => switch (this) {
    VehicleType.bike => 25,
    VehicleType.auto => 40,
    VehicleType.miniTruck => 200,
    VehicleType.truck => 500,
  };

  double get perKm => switch (this) {
    VehicleType.bike => 8,
    VehicleType.auto => 12,
    VehicleType.miniTruck => 22,
    VehicleType.truck => 40,
  };

  double get perMinute => switch (this) {
    VehicleType.bike => 1,
    VehicleType.auto => 1.5,
    VehicleType.miniTruck => 2,
    VehicleType.truck => 3,
  };
}

/// A concrete vehicle operated by a driver.
@freezed
abstract class Vehicle with _$Vehicle {
  const factory Vehicle({
    required String id,
    required VehicleType type,
    required String registrationNumber,
    required String model,
    String? color,
  }) = _Vehicle;

  factory Vehicle.fromJson(Map<String, dynamic> json) =>
      _$VehicleFromJson(json);
}
