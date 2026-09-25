import 'package:shared_models/shared_models.dart';

/// Deterministic seed fixtures for the mock API. Kept in one place so demo
/// data is consistent across apps and easy to extend per feature.
abstract final class SeedData {
  static AppUser get customer => AppUser(
    id: 'usr_1',
    fullName: 'Aarav Sharma',
    phone: '+919812345678',
    email: 'aarav@example.com',
    isPhoneVerified: true,
    savedAddressIds: const ['adr_home', 'adr_work'],
    createdAt: DateTime.utc(2026, 1, 12),
  );

  static List<Address> get addresses => const [
    Address(
      id: 'adr_home',
      label: AddressLabel.home,
      title: 'Home',
      formattedAddress: '221B, Koramangala, Bengaluru',
      location: GeoPoint(latitude: 12.9352, longitude: 77.6245),
    ),
    Address(
      id: 'adr_work',
      label: AddressLabel.work,
      title: 'Office',
      formattedAddress: 'WeWork, Indiranagar, Bengaluru',
      location: GeoPoint(latitude: 12.9719, longitude: 77.6412),
    ),
  ];

  static List<Driver> get drivers => const [
    Driver(
      id: 'drv_1',
      fullName: 'Rakesh Kumar',
      phone: '+919900112233',
      rating: 4.8,
      totalTrips: 1240,
      availability: DriverAvailability.online,
      vehicle: Vehicle(
        id: 'veh_1',
        type: VehicleType.auto,
        registrationNumber: 'KA01AB1234',
        model: 'Bajaj RE',
        color: 'Yellow',
      ),
    ),
    Driver(
      id: 'drv_2',
      fullName: 'Suresh Patel',
      phone: '+919900445566',
      rating: 4.6,
      totalTrips: 860,
      availability: DriverAvailability.online,
      vehicle: Vehicle(
        id: 'veh_2',
        type: VehicleType.miniTruck,
        registrationNumber: 'KA05CD5678',
        model: 'Tata Ace',
        color: 'White',
      ),
    ),
  ];

  static List<Coupon> get coupons => [
    Coupon(
      code: 'RAFTAR50',
      title: '₹50 off your first move',
      description: 'Flat ₹50 off on orders above ₹200.',
      discountType: DiscountType.flat,
      value: 50,
      minOrderValue: 200,
      expiresAt: DateTime.utc(2026, 12, 31),
    ),
    Coupon(
      code: 'SAVE20',
      title: '20% off up to ₹100',
      description: '20% discount, capped at ₹100.',
      discountType: DiscountType.percentage,
      value: 20,
      minOrderValue: 300,
      maxDiscount: 100,
      expiresAt: DateTime.utc(2026, 9, 30),
    ),
    Coupon(
      code: 'TRUCK10',
      title: '10% off truck bookings',
      description: '10% off, capped at ₹300.',
      discountType: DiscountType.percentage,
      value: 10,
      maxDiscount: 300,
      expiresAt: DateTime.utc(2026, 10, 15),
    ),
  ];

  static List<AppNotification> get notifications => [
    AppNotification(
      id: 'ntf_1',
      title: 'Welcome to Raftar Gaddi',
      body: 'Book your first move and get ₹50 off with RAFTAR50.',
      type: NotificationType.promo,
      createdAt: DateTime.utc(2026, 7, 15, 9),
    ),
    AppNotification(
      id: 'ntf_2',
      title: 'Payment successful',
      body: 'Your wallet was topped up with ₹500.',
      type: NotificationType.payment,
      createdAt: DateTime.utc(2026, 7, 15, 12, 30),
      isRead: true,
    ),
  ];

  static Wallet get wallet => Wallet(
    ownerId: 'usr_1',
    balance: 500,
    transactions: [
      WalletTransaction(
        id: 'txn_1',
        type: WalletTransactionType.credit,
        amount: 500,
        description: 'Wallet top-up',
        timestamp: DateTime.utc(2026, 7, 15, 12, 30),
      ),
    ],
  );
}
