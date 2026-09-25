import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for PaymentsApi
void main() {
  final instance = ApiClient().getPaymentsApi();

  group(PaymentsApi, () {
    // List all payments
    //
    //Future paymentsControllerGetAllPayments({ num page, num limit, String cursor, String status, String method, String from, String to }) async
    test('test paymentsControllerGetAllPayments', () async {
      // TODO
    });

    // Get payments for a booking
    //
    //Future paymentsControllerGetPaymentByBooking(String bookingId) async
    test('test paymentsControllerGetPaymentByBooking', () async {
      // TODO
    });

    // Initiate payment
    //
    //Future paymentsControllerInitiatePayment(InitiatePaymentDto initiatePaymentDto, { String idempotencyKey }) async
    test('test paymentsControllerInitiatePayment', () async {
      // TODO
    });

    // Process payment webhook
    //
    //Future paymentsControllerProcessWebhook(WebhookPayloadDto webhookPayloadDto) async
    test('test paymentsControllerProcessWebhook', () async {
      // TODO
    });

    // Refund a payment
    //
    //Future paymentsControllerRefundPayment(String id) async
    test('test paymentsControllerRefundPayment', () async {
      // TODO
    });

  });
}
