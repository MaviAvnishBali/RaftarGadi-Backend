import 'package:freezed_annotation/freezed_annotation.dart';

part 'coupon.freezed.dart';
part 'coupon.g.dart';

/// Whether a coupon takes off a flat amount or a percentage.
enum DiscountType { flat, percentage }

/// A promotional discount a customer can apply to a booking.
@freezed
abstract class Coupon with _$Coupon {
  const factory Coupon({
    required String code,
    required String title,
    required String description,
    required DiscountType discountType,
    required double value,
    required DateTime expiresAt,
    @Default(0) double minOrderValue,
    double? maxDiscount,
    @Default(true) bool isActive,
  }) = _Coupon;

  const Coupon._();

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);

  bool get isExpired => DateTime.now().isAfter(expiresAt);

  /// Computes the discount this coupon yields for [orderValue], respecting
  /// the minimum-order gate and the percentage cap.
  double discountFor(double orderValue) {
    if (!isActive || isExpired || orderValue < minOrderValue) return 0;
    final raw = switch (discountType) {
      DiscountType.flat => value,
      DiscountType.percentage => orderValue * value / 100,
    };
    final capped = maxDiscount != null && raw > maxDiscount!
        ? maxDiscount!
        : raw;
    return capped > orderValue ? orderValue : capped;
  }
}
