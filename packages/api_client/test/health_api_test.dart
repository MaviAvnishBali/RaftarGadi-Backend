import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for HealthApi
void main() {
  final instance = ApiClient().getHealthApi();

  group(HealthApi, () {
    //Future<HealthControllerCheck200Response> healthControllerCheck() async
    test('test healthControllerCheck', () async {
      // TODO
    });

    //Future healthControllerLiveness() async
    test('test healthControllerLiveness', () async {
      // TODO
    });

    //Future<HealthControllerCheck200Response> healthControllerReadiness() async
    test('test healthControllerReadiness', () async {
      // TODO
    });

  });
}
