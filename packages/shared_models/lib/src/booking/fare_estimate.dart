import 'package:freezed_annotation/freezed_annotation.dart';

part 'fare_estimate.freezed.dart';
part 'fare_estimate.g.dart';

/// A priced quote for a trip. Broken into components so the UI can show a
/// transparent fare breakdown and so a coupon can be applied to [discount].
@freezed
abstract class FareEstimate with _$FareEstimate {
  const factory FareEstimate({
    required double baseFare,
    required double distanceFare,
    required double timeFare,
    required double distanceKm,
    required int durationMinutes,
    @Default(1) double surgeMultiplier,
    @Default(0) double discount,
    @Default('INR') String currency,
  }) = _FareEstimate;

  const FareEstimate._();

  factory FareEstimate.fromJson(Map<String, dynamic> json) =>
      _$FareEstimateFromJson(json);

  /// Final payable amount after surge and discount.
  double get total {
    final subtotal = (baseFare + distanceFare + timeFare) * surgeMultiplier;
    final net = subtotal - discount;
    return net < 0 ? 0 : net;
  }
}
