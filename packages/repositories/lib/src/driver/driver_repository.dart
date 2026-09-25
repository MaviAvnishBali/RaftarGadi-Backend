import 'package:core/core.dart';

abstract interface class DriverRepository {
  Future<Result<void>> registerDriver(String licenseNumber);
}

class ApiDriverRepository implements DriverRepository {
  ApiDriverRepository(this._api);
  final ApiClient _api;

  @override
  Future<Result<void>> registerDriver(String licenseNumber) => guardAsync(() async {
    await _api.post('/api/v1/drivers/register', body: {'licenseNumber': licenseNumber});
  });
}
