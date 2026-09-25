# api_client.api.BookingsApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**bookingsControllerAcceptBooking**](BookingsApi.md#bookingscontrolleracceptbooking) | **POST** /api/v1/bookings/{id}/accept | 
[**bookingsControllerCancelBooking**](BookingsApi.md#bookingscontrollercancelbooking) | **POST** /api/v1/bookings/{id}/cancel | 
[**bookingsControllerCompleteTrip**](BookingsApi.md#bookingscontrollercompletetrip) | **POST** /api/v1/bookings/{id}/complete | 
[**bookingsControllerCreateBooking**](BookingsApi.md#bookingscontrollercreatebooking) | **POST** /api/v1/bookings | 
[**bookingsControllerDriverArrived**](BookingsApi.md#bookingscontrollerdriverarrived) | **POST** /api/v1/bookings/{id}/arrived | 
[**bookingsControllerGetAllBookings**](BookingsApi.md#bookingscontrollergetallbookings) | **GET** /api/v1/bookings/all | 
[**bookingsControllerGetBookingById**](BookingsApi.md#bookingscontrollergetbookingbyid) | **GET** /api/v1/bookings/{id} | 
[**bookingsControllerGetBookingStats**](BookingsApi.md#bookingscontrollergetbookingstats) | **GET** /api/v1/bookings/stats | 
[**bookingsControllerGetCustomerBookings**](BookingsApi.md#bookingscontrollergetcustomerbookings) | **GET** /api/v1/bookings | 
[**bookingsControllerGetDriverBookings**](BookingsApi.md#bookingscontrollergetdriverbookings) | **GET** /api/v1/bookings/driver | 
[**bookingsControllerStartTrip**](BookingsApi.md#bookingscontrollerstarttrip) | **POST** /api/v1/bookings/{id}/start | 


# **bookingsControllerAcceptBooking**
> JsonObject bookingsControllerAcceptBooking(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBookingsApi();
final String id = id_example; // String | 

try {
    final response = api.bookingsControllerAcceptBooking(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling BookingsApi->bookingsControllerAcceptBooking: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **bookingsControllerCancelBooking**
> JsonObject bookingsControllerCancelBooking(id, cancelBookingDto)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBookingsApi();
final String id = id_example; // String | 
final CancelBookingDto cancelBookingDto = ; // CancelBookingDto | 

try {
    final response = api.bookingsControllerCancelBooking(id, cancelBookingDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling BookingsApi->bookingsControllerCancelBooking: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **cancelBookingDto** | [**CancelBookingDto**](CancelBookingDto.md)|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **bookingsControllerCompleteTrip**
> JsonObject bookingsControllerCompleteTrip(id, completeTripDto)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBookingsApi();
final String id = id_example; // String | 
final CompleteTripDto completeTripDto = ; // CompleteTripDto | 

try {
    final response = api.bookingsControllerCompleteTrip(id, completeTripDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling BookingsApi->bookingsControllerCompleteTrip: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **completeTripDto** | [**CompleteTripDto**](CompleteTripDto.md)|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **bookingsControllerCreateBooking**
> JsonObject bookingsControllerCreateBooking(idempotencyKey, createBookingDto)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBookingsApi();
final String idempotencyKey = idempotencyKey_example; // String | 
final CreateBookingDto createBookingDto = ; // CreateBookingDto | 

try {
    final response = api.bookingsControllerCreateBooking(idempotencyKey, createBookingDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling BookingsApi->bookingsControllerCreateBooking: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **idempotencyKey** | **String**|  | 
 **createBookingDto** | [**CreateBookingDto**](CreateBookingDto.md)|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **bookingsControllerDriverArrived**
> JsonObject bookingsControllerDriverArrived(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBookingsApi();
final String id = id_example; // String | 

try {
    final response = api.bookingsControllerDriverArrived(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling BookingsApi->bookingsControllerDriverArrived: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **bookingsControllerGetAllBookings**
> bookingsControllerGetAllBookings(page, limit, cursor, status, from, to, customerId, driverId, paymentStatus, search)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBookingsApi();
final num page = 8.14; // num | Page number (1-indexed)
final num limit = 8.14; // num | Items per page
final String cursor = cursor_example; // String | Cursor for cursor-based pagination
final String status = status_example; // String | 
final String from = from_example; // String | From date (ISO string)
final String to = to_example; // String | To date (ISO string)
final String customerId = customerId_example; // String | Customer ID
final String driverId = driverId_example; // String | Driver ID
final String paymentStatus = paymentStatus_example; // String | 
final String search = search_example; // String | Search term (booking number, etc.)

try {
    api.bookingsControllerGetAllBookings(page, limit, cursor, status, from, to, customerId, driverId, paymentStatus, search);
} on DioException catch (e) {
    print('Exception when calling BookingsApi->bookingsControllerGetAllBookings: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **num**| Page number (1-indexed) | [optional] [default to 1]
 **limit** | **num**| Items per page | [optional] [default to 20]
 **cursor** | **String**| Cursor for cursor-based pagination | [optional] 
 **status** | **String**|  | [optional] 
 **from** | **String**| From date (ISO string) | [optional] 
 **to** | **String**| To date (ISO string) | [optional] 
 **customerId** | **String**| Customer ID | [optional] 
 **driverId** | **String**| Driver ID | [optional] 
 **paymentStatus** | **String**|  | [optional] 
 **search** | **String**| Search term (booking number, etc.) | [optional] 

### Return type

void (empty response body)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **bookingsControllerGetBookingById**
> JsonObject bookingsControllerGetBookingById(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBookingsApi();
final String id = id_example; // String | 

try {
    final response = api.bookingsControllerGetBookingById(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling BookingsApi->bookingsControllerGetBookingById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **bookingsControllerGetBookingStats**
> JsonObject bookingsControllerGetBookingStats()



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBookingsApi();

try {
    final response = api.bookingsControllerGetBookingStats();
    print(response);
} on DioException catch (e) {
    print('Exception when calling BookingsApi->bookingsControllerGetBookingStats: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **bookingsControllerGetCustomerBookings**
> bookingsControllerGetCustomerBookings(page, limit, cursor, status, from, to)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBookingsApi();
final num page = 8.14; // num | Page number (1-indexed)
final num limit = 8.14; // num | Items per page
final String cursor = cursor_example; // String | Cursor for cursor-based pagination
final String status = status_example; // String | 
final String from = from_example; // String | From date (ISO string)
final String to = to_example; // String | To date (ISO string)

try {
    api.bookingsControllerGetCustomerBookings(page, limit, cursor, status, from, to);
} on DioException catch (e) {
    print('Exception when calling BookingsApi->bookingsControllerGetCustomerBookings: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **num**| Page number (1-indexed) | [optional] [default to 1]
 **limit** | **num**| Items per page | [optional] [default to 20]
 **cursor** | **String**| Cursor for cursor-based pagination | [optional] 
 **status** | **String**|  | [optional] 
 **from** | **String**| From date (ISO string) | [optional] 
 **to** | **String**| To date (ISO string) | [optional] 

### Return type

void (empty response body)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **bookingsControllerGetDriverBookings**
> bookingsControllerGetDriverBookings(page, limit, cursor, status, from, to)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBookingsApi();
final num page = 8.14; // num | Page number (1-indexed)
final num limit = 8.14; // num | Items per page
final String cursor = cursor_example; // String | Cursor for cursor-based pagination
final String status = status_example; // String | 
final String from = from_example; // String | From date (ISO string)
final String to = to_example; // String | To date (ISO string)

try {
    api.bookingsControllerGetDriverBookings(page, limit, cursor, status, from, to);
} on DioException catch (e) {
    print('Exception when calling BookingsApi->bookingsControllerGetDriverBookings: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **num**| Page number (1-indexed) | [optional] [default to 1]
 **limit** | **num**| Items per page | [optional] [default to 20]
 **cursor** | **String**| Cursor for cursor-based pagination | [optional] 
 **status** | **String**|  | [optional] 
 **from** | **String**| From date (ISO string) | [optional] 
 **to** | **String**| To date (ISO string) | [optional] 

### Return type

void (empty response body)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **bookingsControllerStartTrip**
> JsonObject bookingsControllerStartTrip(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBookingsApi();
final String id = id_example; // String | 

try {
    final response = api.bookingsControllerStartTrip(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling BookingsApi->bookingsControllerStartTrip: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

