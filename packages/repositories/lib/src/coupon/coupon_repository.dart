import 'package:core/core.dart';
import 'package:shared_models/shared_models.dart';

/// Contract for browsing and searching coupons.
abstract interface class CouponRepository {
  Future<Result<PaginatedResponse<Coupon>>> getCoupons({
    int page = 1,
    int pageSize = 20,
    String? query,
  });
}

/// [ApiClient]-backed implementation.
class ApiCouponRepository implements CouponRepository {
  ApiCouponRepository(this._api);

  final ApiClient _api;

  @override
  Future<Result<PaginatedResponse<Coupon>>> getCoupons({
    int page = 1,
    int pageSize = 20,
    String? query,
  }) => guardAsync(() async {
    final json = await _api.get(
      '/coupons',
      query: {
        'page': page,
        'pageSize': pageSize,
        if (query != null && query.isNotEmpty) 'q': query,
      },
    );
    return PaginatedResponse.fromJson(
      json,
      (item) => Coupon.fromJson(item! as Map<String, dynamic>),
    );
  });
}
