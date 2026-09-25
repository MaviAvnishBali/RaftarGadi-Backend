import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for VehiclesApi
void main() {
  final instance = ApiClient().getVehiclesApi();

  group(VehiclesApi, () {
    // Create vehicle type
    //
    //Future vehiclesControllerCreateVehicleType(CreateVehicleTypeDto createVehicleTypeDto) async
    test('test vehiclesControllerCreateVehicleType', () async {
      // TODO
    });

    // Get own vehicle
    //
    //Future<JsonObject> vehiclesControllerGetDriverVehicle() async
    test('test vehiclesControllerGetDriverVehicle', () async {
      // TODO
    });

    // List vehicle types
    //
    //Future vehiclesControllerGetVehicleTypes() async
    test('test vehiclesControllerGetVehicleTypes', () async {
      // TODO
    });

    // Register vehicle
    //
    //Future vehiclesControllerRegisterVehicle(RegisterVehicleDto registerVehicleDto) async
    test('test vehiclesControllerRegisterVehicle', () async {
      // TODO
    });

    // Update vehicle
    //
    //Future vehiclesControllerUpdateVehicle(String id, UpdateVehicleDto updateVehicleDto) async
    test('test vehiclesControllerUpdateVehicle', () async {
      // TODO
    });

  });
}
