import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for RatingsApi
void main() {
  final instance = ApiClient().getRatingsApi();

  group(RatingsApi, () {
    // Create a rating for a booking
    //
    //Future ratingsControllerCreateRating(CreateRatingDto createRatingDto) async
    test('test ratingsControllerCreateRating', () async {
      // TODO
    });

    // Get rating for a specific booking
    //
    //Future<JsonObject> ratingsControllerGetBookingRating(String bookingId) async
    test('test ratingsControllerGetBookingRating', () async {
      // TODO
    });

    // Get ratings for a driver
    //
    //Future ratingsControllerGetDriverRatings(String driverId, { num page, num limit, String cursor }) async
    test('test ratingsControllerGetDriverRatings', () async {
      // TODO
    });

  });
}
