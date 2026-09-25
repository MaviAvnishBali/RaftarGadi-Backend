# api_client.api.HealthApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**healthControllerCheck**](HealthApi.md#healthcontrollercheck) | **GET** /api/v1/health | 
[**healthControllerLiveness**](HealthApi.md#healthcontrollerliveness) | **GET** /api/v1/health/live | 
[**healthControllerReadiness**](HealthApi.md#healthcontrollerreadiness) | **GET** /api/v1/health/ready | 


# **healthControllerCheck**
> HealthControllerCheck200Response healthControllerCheck()



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getHealthApi();

try {
    final response = api.healthControllerCheck();
    print(response);
} on DioException catch (e) {
    print('Exception when calling HealthApi->healthControllerCheck: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**HealthControllerCheck200Response**](HealthControllerCheck200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **healthControllerLiveness**
> healthControllerLiveness()



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getHealthApi();

try {
    api.healthControllerLiveness();
} on DioException catch (e) {
    print('Exception when calling HealthApi->healthControllerLiveness: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **healthControllerReadiness**
> HealthControllerCheck200Response healthControllerReadiness()



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getHealthApi();

try {
    final response = api.healthControllerReadiness();
    print(response);
} on DioException catch (e) {
    print('Exception when calling HealthApi->healthControllerReadiness: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**HealthControllerCheck200Response**](HealthControllerCheck200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

