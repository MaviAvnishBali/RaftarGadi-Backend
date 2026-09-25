# api_client.api.RatingsApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**ratingsControllerCreateRating**](RatingsApi.md#ratingscontrollercreaterating) | **POST** /api/v1/ratings | Create a rating for a booking
[**ratingsControllerGetBookingRating**](RatingsApi.md#ratingscontrollergetbookingrating) | **GET** /api/v1/ratings/booking/{bookingId} | Get rating for a specific booking
[**ratingsControllerGetDriverRatings**](RatingsApi.md#ratingscontrollergetdriverratings) | **GET** /api/v1/ratings/driver/{driverId} | Get ratings for a driver


# **ratingsControllerCreateRating**
> ratingsControllerCreateRating(createRatingDto)

Create a rating for a booking

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getRatingsApi();
final CreateRatingDto createRatingDto = ; // CreateRatingDto | 

try {
    api.ratingsControllerCreateRating(createRatingDto);
} on DioException catch (e) {
    print('Exception when calling RatingsApi->ratingsControllerCreateRating: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createRatingDto** | [**CreateRatingDto**](CreateRatingDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **ratingsControllerGetBookingRating**
> JsonObject ratingsControllerGetBookingRating(bookingId)

Get rating for a specific booking

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getRatingsApi();
final String bookingId = bookingId_example; // String | 

try {
    final response = api.ratingsControllerGetBookingRating(bookingId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RatingsApi->ratingsControllerGetBookingRating: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookingId** | **String**|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **ratingsControllerGetDriverRatings**
> ratingsControllerGetDriverRatings(driverId, page, limit, cursor)

Get ratings for a driver

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getRatingsApi();
final String driverId = driverId_example; // String | 
final num page = 8.14; // num | Page number (1-indexed)
final num limit = 8.14; // num | Items per page
final String cursor = cursor_example; // String | Cursor for cursor-based pagination

try {
    api.ratingsControllerGetDriverRatings(driverId, page, limit, cursor);
} on DioException catch (e) {
    print('Exception when calling RatingsApi->ratingsControllerGetDriverRatings: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **driverId** | **String**|  | 
 **page** | **num**| Page number (1-indexed) | [optional] [default to 1]
 **limit** | **num**| Items per page | [optional] [default to 20]
 **cursor** | **String**| Cursor for cursor-based pagination | [optional] 

### Return type

void (empty response body)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

