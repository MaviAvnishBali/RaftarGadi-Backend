import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for CustomersApi
void main() {
  final instance = ApiClient().getCustomersApi();

  group(CustomersApi, () {
    // List all customers (Admin)
    //
    //Future customersControllerFindAll({ num page, num limit, String cursor }) async
    test('test customersControllerFindAll', () async {
      // TODO
    });

    // Get customer by id (Admin)
    //
    //Future<JsonObject> customersControllerFindById(String id) async
    test('test customersControllerFindById', () async {
      // TODO
    });

    // Get customer profile
    //
    //Future<JsonObject> customersControllerGetProfile() async
    test('test customersControllerGetProfile', () async {
      // TODO
    });

    // Update customer profile
    //
    //Future<JsonObject> customersControllerUpdateProfile(UpdateCustomerDto updateCustomerDto) async
    test('test customersControllerUpdateProfile', () async {
      // TODO
    });

  });
}
