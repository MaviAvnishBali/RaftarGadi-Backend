# api_client.api.CustomersApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**customersControllerFindAll**](CustomersApi.md#customerscontrollerfindall) | **GET** /api/v1/customers | List all customers (Admin)
[**customersControllerFindById**](CustomersApi.md#customerscontrollerfindbyid) | **GET** /api/v1/customers/{id} | Get customer by id (Admin)
[**customersControllerGetProfile**](CustomersApi.md#customerscontrollergetprofile) | **GET** /api/v1/customers/profile | Get customer profile
[**customersControllerUpdateProfile**](CustomersApi.md#customerscontrollerupdateprofile) | **PATCH** /api/v1/customers/profile | Update customer profile


# **customersControllerFindAll**
> customersControllerFindAll(page, limit, cursor)

List all customers (Admin)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getCustomersApi();
final num page = 8.14; // num | Page number (1-indexed)
final num limit = 8.14; // num | Items per page
final String cursor = cursor_example; // String | Cursor for cursor-based pagination

try {
    api.customersControllerFindAll(page, limit, cursor);
} on DioException catch (e) {
    print('Exception when calling CustomersApi->customersControllerFindAll: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
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

# **customersControllerFindById**
> JsonObject customersControllerFindById(id)

Get customer by id (Admin)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getCustomersApi();
final String id = id_example; // String | 

try {
    final response = api.customersControllerFindById(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomersApi->customersControllerFindById: $e\n');
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

# **customersControllerGetProfile**
> JsonObject customersControllerGetProfile()

Get customer profile

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getCustomersApi();

try {
    final response = api.customersControllerGetProfile();
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomersApi->customersControllerGetProfile: $e\n');
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

# **customersControllerUpdateProfile**
> JsonObject customersControllerUpdateProfile(updateCustomerDto)

Update customer profile

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getCustomersApi();
final UpdateCustomerDto updateCustomerDto = ; // UpdateCustomerDto | 

try {
    final response = api.customersControllerUpdateProfile(updateCustomerDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomersApi->customersControllerUpdateProfile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateCustomerDto** | [**UpdateCustomerDto**](UpdateCustomerDto.md)|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

