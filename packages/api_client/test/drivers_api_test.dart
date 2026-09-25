import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for DriversApi
void main() {
  final instance = ApiClient().getDriversApi();

  group(DriversApi, () {
    // Approve driver KYC
    //
    //Future driversControllerApproveDriver(String id) async
    test('test driversControllerApproveDriver', () async {
      // TODO
    });

    // List all drivers
    //
    //Future driversControllerFindAll({ num page, num limit, String cursor, String status, String kycStatus, String search }) async
    test('test driversControllerFindAll', () async {
      // TODO
    });

    // Get driver by id
    //
    //Future<JsonObject> driversControllerFindById(String id) async
    test('test driversControllerFindById', () async {
      // TODO
    });

    // Get own driver profile
    //
    //Future<JsonObject> driversControllerGetProfile() async
    test('test driversControllerGetProfile', () async {
      // TODO
    });

    // Go offline
    //
    //Future driversControllerGoOffline() async
    test('test driversControllerGoOffline', () async {
      // TODO
    });

    // Go online
    //
    //Future driversControllerGoOnline() async
    test('test driversControllerGoOnline', () async {
      // TODO
    });

    // Register as driver
    //
    //Future driversControllerRegisterDriver(RegisterDriverDto registerDriverDto) async
    test('test driversControllerRegisterDriver', () async {
      // TODO
    });

    // Suspend driver
    //
    //Future driversControllerSuspendDriver(String id) async
    test('test driversControllerSuspendDriver', () async {
      // TODO
    });

    // Update driver profile
    //
    //Future driversControllerUpdateProfile(UpdateDriverDto updateDriverDto) async
    test('test driversControllerUpdateProfile', () async {
      // TODO
    });

    // Upload document
    //
    //Future driversControllerUploadDocument(UploadDocumentDto uploadDocumentDto) async
    test('test driversControllerUploadDocument', () async {
      // TODO
    });

  });
}
