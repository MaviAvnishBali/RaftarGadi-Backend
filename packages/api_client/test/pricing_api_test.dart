import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for PricingApi
void main() {
  final instance = ApiClient().getPricingApi();

  group(PricingApi, () {
    // Create pricing rule
    //
    //Future pricingControllerCreateRule(CreatePricingRuleDto createPricingRuleDto) async
    test('test pricingControllerCreateRule', () async {
      // TODO
    });

    // Calculate fare estimate
    //
    //Future<JsonObject> pricingControllerEstimateFare(CalculateFareDto calculateFareDto) async
    test('test pricingControllerEstimateFare', () async {
      // TODO
    });

    // List pricing rules
    //
    //Future pricingControllerGetRules({ num page, num limit, String cursor }) async
    test('test pricingControllerGetRules', () async {
      // TODO
    });

    // Set surge multiplier
    //
    //Future pricingControllerSetSurge() async
    test('test pricingControllerSetSurge', () async {
      // TODO
    });

    // Update pricing rule
    //
    //Future pricingControllerUpdateRule(String id, UpdatePricingRuleDto updatePricingRuleDto) async
    test('test pricingControllerUpdateRule', () async {
      // TODO
    });

  });
}
