# api_client.api.AdminApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**adminControllerActivateUser**](AdminApi.md#admincontrolleractivateuser) | **POST** /api/v1/admin/users/{id}/activate | 
[**adminControllerDeactivateUser**](AdminApi.md#admincontrollerdeactivateuser) | **POST** /api/v1/admin/users/{id}/deactivate | 
[**adminControllerGetAuditLogs**](AdminApi.md#admincontrollergetauditlogs) | **GET** /api/v1/admin/audit-logs | 
[**adminControllerGetOverview**](AdminApi.md#admincontrollergetoverview) | **GET** /api/v1/admin/overview | 
[**reportsControllerGetBookingTrends**](AdminApi.md#reportscontrollergetbookingtrends) | **GET** /api/v1/reports/booking-trends | 
[**reportsControllerGetDashboardStats**](AdminApi.md#reportscontrollergetdashboardstats) | **GET** /api/v1/reports/dashboard | 
[**reportsControllerGetDriverPerformanceReport**](AdminApi.md#reportscontrollergetdriverperformancereport) | **GET** /api/v1/reports/driver-performance | 
[**reportsControllerGetRevenueReport**](AdminApi.md#reportscontrollergetrevenuereport) | **GET** /api/v1/reports/revenue | 


# **adminControllerActivateUser**
> adminControllerActivateUser(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String id = id_example; // String | 

try {
    api.adminControllerActivateUser(id);
} on DioException catch (e) {
    print('Exception when calling AdminApi->adminControllerActivateUser: $e\n');
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

# **adminControllerDeactivateUser**
> adminControllerDeactivateUser(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String id = id_example; // String | 

try {
    api.adminControllerDeactivateUser(id);
} on DioException catch (e) {
    print('Exception when calling AdminApi->adminControllerDeactivateUser: $e\n');
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

# **adminControllerGetAuditLogs**
> adminControllerGetAuditLogs(page, limit, actorId, action, entityType, entityId, from, to)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String page = page_example; // String | 
final String limit = limit_example; // String | 
final String actorId = actorId_example; // String | 
final String action = action_example; // String | 
final String entityType = entityType_example; // String | 
final String entityId = entityId_example; // String | 
final String from = from_example; // String | 
final String to = to_example; // String | 

try {
    api.adminControllerGetAuditLogs(page, limit, actorId, action, entityType, entityId, from, to);
} on DioException catch (e) {
    print('Exception when calling AdminApi->adminControllerGetAuditLogs: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **String**|  | [optional] 
 **limit** | **String**|  | [optional] 
 **actorId** | **String**|  | [optional] 
 **action** | **String**|  | [optional] 
 **entityType** | **String**|  | [optional] 
 **entityId** | **String**|  | [optional] 
 **from** | **String**|  | [optional] 
 **to** | **String**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminControllerGetOverview**
> JsonObject adminControllerGetOverview()



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();

try {
    final response = api.adminControllerGetOverview();
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminApi->adminControllerGetOverview: $e\n');
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

# **reportsControllerGetBookingTrends**
> BuiltList<JsonObject> reportsControllerGetBookingTrends(from, to, interval)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String from = 2023-01-01T00:00:00.000Z; // String | 
final String to = 2023-12-31T23:59:59.999Z; // String | 
final String interval = interval_example; // String | 

try {
    final response = api.reportsControllerGetBookingTrends(from, to, interval);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminApi->reportsControllerGetBookingTrends: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **from** | **String**|  | [optional] 
 **to** | **String**|  | [optional] 
 **interval** | **String**|  | [optional] 

### Return type

[**BuiltList&lt;JsonObject&gt;**](JsonObject.md)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reportsControllerGetDashboardStats**
> JsonObject reportsControllerGetDashboardStats()



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();

try {
    final response = api.reportsControllerGetDashboardStats();
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminApi->reportsControllerGetDashboardStats: $e\n');
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

# **reportsControllerGetDriverPerformanceReport**
> BuiltList<JsonObject> reportsControllerGetDriverPerformanceReport(from, to, interval)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String from = 2023-01-01T00:00:00.000Z; // String | 
final String to = 2023-12-31T23:59:59.999Z; // String | 
final String interval = interval_example; // String | 

try {
    final response = api.reportsControllerGetDriverPerformanceReport(from, to, interval);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminApi->reportsControllerGetDriverPerformanceReport: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **from** | **String**|  | [optional] 
 **to** | **String**|  | [optional] 
 **interval** | **String**|  | [optional] 

### Return type

[**BuiltList&lt;JsonObject&gt;**](JsonObject.md)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reportsControllerGetRevenueReport**
> JsonObject reportsControllerGetRevenueReport(from, to, interval)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String from = 2023-01-01T00:00:00.000Z; // String | 
final String to = 2023-12-31T23:59:59.999Z; // String | 
final String interval = interval_example; // String | 

try {
    final response = api.reportsControllerGetRevenueReport(from, to, interval);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminApi->reportsControllerGetRevenueReport: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **from** | **String**|  | [optional] 
 **to** | **String**|  | [optional] 
 **interval** | **String**|  | [optional] 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

