import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for CouponsApi
void main() {
  final instance = ApiClient().getCouponsApi();

  group(CouponsApi, () {
    // Create a new coupon
    //
    //Future couponsControllerCreateCoupon(CreateCouponDto createCouponDto) async
    test('test couponsControllerCreateCoupon', () async {
      // TODO
    });

    // Deactivate a coupon
    //
    //Future couponsControllerDeactivateCoupon(String id) async
    test('test couponsControllerDeactivateCoupon', () async {
      // TODO
    });

    // List active coupons
    //
    //Future couponsControllerGetActiveCoupons() async
    test('test couponsControllerGetActiveCoupons', () async {
      // TODO
    });

    // List all coupons
    //
    //Future couponsControllerGetCoupons({ num page, num limit, String cursor }) async
    test('test couponsControllerGetCoupons', () async {
      // TODO
    });

    // Update a coupon
    //
    //Future couponsControllerUpdateCoupon(String id, UpdateCouponDto updateCouponDto) async
    test('test couponsControllerUpdateCoupon', () async {
      // TODO
    });

    // Validate a coupon
    //
    //Future couponsControllerValidateCoupon(ValidateCouponDto validateCouponDto) async
    test('test couponsControllerValidateCoupon', () async {
      // TODO
    });

  });
}
