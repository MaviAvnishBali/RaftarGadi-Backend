# api_client.api.DriversApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**driversControllerApproveDriver**](DriversApi.md#driverscontrollerapprovedriver) | **POST** /api/v1/drivers/{id}/approve | Approve driver KYC
[**driversControllerFindAll**](DriversApi.md#driverscontrollerfindall) | **GET** /api/v1/drivers | List all drivers
[**driversControllerFindById**](DriversApi.md#driverscontrollerfindbyid) | **GET** /api/v1/drivers/{id} | Get driver by id
[**driversControllerGetProfile**](DriversApi.md#driverscontrollergetprofile) | **GET** /api/v1/drivers/profile | Get own driver profile
[**driversControllerGoOffline**](DriversApi.md#driverscontrollergooffline) | **POST** /api/v1/drivers/go-offline | Go offline
[**driversControllerGoOnline**](DriversApi.md#driverscontrollergoonline) | **POST** /api/v1/drivers/go-online | Go online
[**driversControllerRegisterDriver**](DriversApi.md#driverscontrollerregisterdriver) | **POST** /api/v1/drivers/register | Register as driver
[**driversControllerSuspendDriver**](DriversApi.md#driverscontrollersuspenddriver) | **POST** /api/v1/drivers/{id}/suspend | Suspend driver
[**driversControllerUpdateProfile**](DriversApi.md#driverscontrollerupdateprofile) | **PATCH** /api/v1/drivers/profile | Update driver profile
[**driversControllerUploadDocument**](DriversApi.md#driverscontrolleruploaddocument) | **POST** /api/v1/drivers/documents | Upload document


# **driversControllerApproveDriver**
> driversControllerApproveDriver(id)

Approve driver KYC

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriversApi();
final String id = id_example; // String | 

try {
    api.driversControllerApproveDriver(id);
} on DioException catch (e) {
    print('Exception when calling DriversApi->driversControllerApproveDriver: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driversControllerFindAll**
> driversControllerFindAll(page, limit, cursor, status, kycStatus, search)

List all drivers

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriversApi();
final num page = 8.14; // num | Page number (1-indexed)
final num limit = 8.14; // num | Items per page
final String cursor = cursor_example; // String | Cursor for cursor-based pagination
final String status = status_example; // String | 
final String kycStatus = kycStatus_example; // String | 
final String search = search_example; // String | 

try {
    api.driversControllerFindAll(page, limit, cursor, status, kycStatus, search);
} on DioException catch (e) {
    print('Exception when calling DriversApi->driversControllerFindAll: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **num**| Page number (1-indexed) | [optional] [default to 1]
 **limit** | **num**| Items per page | [optional] [default to 20]
 **cursor** | **String**| Cursor for cursor-based pagination | [optional] 
 **status** | **String**|  | [optional] 
 **kycStatus** | **String**|  | [optional] 
 **search** | **String**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driversControllerFindById**
> JsonObject driversControllerFindById(id)

Get driver by id

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriversApi();
final String id = id_example; // String | 

try {
    final response = api.driversControllerFindById(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling DriversApi->driversControllerFindById: $e\n');
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

# **driversControllerGetProfile**
> JsonObject driversControllerGetProfile()

Get own driver profile

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriversApi();

try {
    final response = api.driversControllerGetProfile();
    print(response);
} on DioException catch (e) {
    print('Exception when calling DriversApi->driversControllerGetProfile: $e\n');
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

# **driversControllerGoOffline**
> driversControllerGoOffline()

Go offline

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriversApi();

try {
    api.driversControllerGoOffline();
} on DioException catch (e) {
    print('Exception when calling DriversApi->driversControllerGoOffline: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driversControllerGoOnline**
> driversControllerGoOnline()

Go online

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriversApi();

try {
    api.driversControllerGoOnline();
} on DioException catch (e) {
    print('Exception when calling DriversApi->driversControllerGoOnline: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driversControllerRegisterDriver**
> driversControllerRegisterDriver(registerDriverDto)

Register as driver

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriversApi();
final RegisterDriverDto registerDriverDto = ; // RegisterDriverDto | 

try {
    api.driversControllerRegisterDriver(registerDriverDto);
} on DioException catch (e) {
    print('Exception when calling DriversApi->driversControllerRegisterDriver: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **registerDriverDto** | [**RegisterDriverDto**](RegisterDriverDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driversControllerSuspendDriver**
> driversControllerSuspendDriver(id)

Suspend driver

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriversApi();
final String id = id_example; // String | 

try {
    api.driversControllerSuspendDriver(id);
} on DioException catch (e) {
    print('Exception when calling DriversApi->driversControllerSuspendDriver: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driversControllerUpdateProfile**
> driversControllerUpdateProfile(updateDriverDto)

Update driver profile

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriversApi();
final UpdateDriverDto updateDriverDto = ; // UpdateDriverDto | 

try {
    api.driversControllerUpdateProfile(updateDriverDto);
} on DioException catch (e) {
    print('Exception when calling DriversApi->driversControllerUpdateProfile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateDriverDto** | [**UpdateDriverDto**](UpdateDriverDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driversControllerUploadDocument**
> driversControllerUploadDocument(uploadDocumentDto)

Upload document

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriversApi();
final UploadDocumentDto uploadDocumentDto = ; // UploadDocumentDto | 

try {
    api.driversControllerUploadDocument(uploadDocumentDto);
} on DioException catch (e) {
    print('Exception when calling DriversApi->driversControllerUploadDocument: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **uploadDocumentDto** | [**UploadDocumentDto**](UploadDocumentDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

