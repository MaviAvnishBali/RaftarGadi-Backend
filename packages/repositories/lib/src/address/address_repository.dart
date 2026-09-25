import 'package:core/core.dart';
import 'package:shared_models/shared_models.dart';

/// Contract for the customer's saved addresses (home, work, …).
abstract interface class AddressRepository {
  Future<Result<PaginatedResponse<Address>>> getSavedAddresses({
    int page = 1,
    int pageSize = 20,
  });
}

/// [ApiClient]-backed implementation.
class ApiAddressRepository implements AddressRepository {
  ApiAddressRepository(this._api);

  final ApiClient _api;

  @override
  Future<Result<PaginatedResponse<Address>>> getSavedAddresses({
    int page = 1,
    int pageSize = 20,
  }) => guardAsync(() async {
    // TEMPORARY BYPASS: The NestJS backend does not have an addresses table yet.
    return const PaginatedResponse<Address>(
      items: [],
      page: 1,
      pageSize: 20,
      total: 0,
    );
  });
}
