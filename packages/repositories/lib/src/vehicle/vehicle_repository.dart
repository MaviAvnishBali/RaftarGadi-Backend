import 'package:core/core.dart';

abstract interface class VehicleRepository {
  Future<Result<List<dynamic>>> getVehicleTypes();
  Future<Result<void>> registerVehicle(String vehicleTypeId, String registrationNumber);
}

class ApiVehicleRepository implements VehicleRepository {
  ApiVehicleRepository(this._api);
  final ApiClient _api;

  @override
  Future<Result<List<dynamic>>> getVehicleTypes() => guardAsync(() async {
    final response = await _api.get('/api/v1/vehicles/types');
    return response as List<dynamic>;
  });

  @override
  Future<Result<void>> registerVehicle(String vehicleTypeId, String registrationNumber) => guardAsync(() async {
    await _api.post('/api/v1/vehicles/register', body: {
      'vehicleTypeId': vehicleTypeId,
      'registrationNumber': registrationNumber,
    });
  });
}
