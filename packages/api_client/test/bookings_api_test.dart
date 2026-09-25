import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for BookingsApi
void main() {
  final instance = ApiClient().getBookingsApi();

  group(BookingsApi, () {
    //Future<JsonObject> bookingsControllerAcceptBooking(String id) async
    test('test bookingsControllerAcceptBooking', () async {
      // TODO
    });

    //Future<JsonObject> bookingsControllerCancelBooking(String id, CancelBookingDto cancelBookingDto) async
    test('test bookingsControllerCancelBooking', () async {
      // TODO
    });

    //Future<JsonObject> bookingsControllerCompleteTrip(String id, CompleteTripDto completeTripDto) async
    test('test bookingsControllerCompleteTrip', () async {
      // TODO
    });

    //Future<JsonObject> bookingsControllerCreateBooking(String idempotencyKey, CreateBookingDto createBookingDto) async
    test('test bookingsControllerCreateBooking', () async {
      // TODO
    });

    //Future<JsonObject> bookingsControllerDriverArrived(String id) async
    test('test bookingsControllerDriverArrived', () async {
      // TODO
    });

    //Future bookingsControllerGetAllBookings({ num page, num limit, String cursor, String status, String from, String to, String customerId, String driverId, String paymentStatus, String search }) async
    test('test bookingsControllerGetAllBookings', () async {
      // TODO
    });

    //Future<JsonObject> bookingsControllerGetBookingById(String id) async
    test('test bookingsControllerGetBookingById', () async {
      // TODO
    });

    //Future<JsonObject> bookingsControllerGetBookingStats() async
    test('test bookingsControllerGetBookingStats', () async {
      // TODO
    });

    //Future bookingsControllerGetCustomerBookings({ num page, num limit, String cursor, String status, String from, String to }) async
    test('test bookingsControllerGetCustomerBookings', () async {
      // TODO
    });

    //Future bookingsControllerGetDriverBookings({ num page, num limit, String cursor, String status, String from, String to }) async
    test('test bookingsControllerGetDriverBookings', () async {
      // TODO
    });

    //Future<JsonObject> bookingsControllerStartTrip(String id) async
    test('test bookingsControllerStartTrip', () async {
      // TODO
    });

  });
}
