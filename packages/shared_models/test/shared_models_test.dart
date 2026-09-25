import 'package:shared_models/shared_models.dart';
import 'package:test/test.dart';

void main() {
  group('JSON round-trip', () {
    test('Booking survives toJson/fromJson', () {
      final booking = Booking(
        id: 'b1',
        customerId: 'c1',
        vehicleType: VehicleType.auto,
        pickup: const Address(
          id: 'a1',
          label: AddressLabel.home,
          title: 'Home',
          formattedAddress: '1 A St',
          location: GeoPoint(latitude: 12.9, longitude: 77.6),
        ),
        drop: const Address(
          id: 'a2',
          label: AddressLabel.work,
          title: 'Office',
          formattedAddress: '2 B Rd',
          location: GeoPoint(latitude: 12.8, longitude: 77.7),
        ),
        fare: const FareEstimate(
          baseFare: 40,
          distanceFare: 60,
          timeFare: 15,
          distanceKm: 5,
          durationMinutes: 15,
        ),
        createdAt: DateTime.utc(2026, 7, 16),
      );

      final restored = Booking.fromJson(booking.toJson());
      expect(restored, booking);
    });
  });

  group('Derived logic', () {
    test('FareEstimate.total applies surge then discount, floored at 0', () {
      const fare = FareEstimate(
        baseFare: 100,
        distanceFare: 0,
        timeFare: 0,
        distanceKm: 1,
        durationMinutes: 1,
        surgeMultiplier: 1.5,
        discount: 200,
      );
      // (100 * 1.5) - 200 = -50 -> clamped to 0.
      expect(fare.total, 0);
    });

    test('Coupon.discountFor caps percentage and respects min order', () {
      final coupon = Coupon(
        code: 'SAVE20',
        title: '20% off',
        description: '',
        discountType: DiscountType.percentage,
        value: 20,
        minOrderValue: 100,
        maxDiscount: 50,
        expiresAt: DateTime.now().add(const Duration(days: 1)),
      );
      expect(coupon.discountFor(50), 0); // Below min order.
      expect(coupon.discountFor(1000), 50); // 200 capped at 50.
    });

    test('VehicleType exposes pricing metadata', () {
      expect(VehicleType.truck.capacityKg, 3000);
      expect(VehicleType.bike.label, 'Bike');
    });
  });
}
