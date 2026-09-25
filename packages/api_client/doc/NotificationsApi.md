# api_client.api.NotificationsApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**notificationsControllerGetMyNotifications**](NotificationsApi.md#notificationscontrollergetmynotifications) | **GET** /api/v1/notifications | Get my notifications
[**notificationsControllerGetUnreadCount**](NotificationsApi.md#notificationscontrollergetunreadcount) | **GET** /api/v1/notifications/unread-count | Get unread notification count
[**notificationsControllerMarkAllAsRead**](NotificationsApi.md#notificationscontrollermarkallasread) | **POST** /api/v1/notifications/read-all | Mark all notifications as read
[**notificationsControllerMarkAsRead**](NotificationsApi.md#notificationscontrollermarkasread) | **PATCH** /api/v1/notifications/{id}/read | Mark a notification as read
[**notificationsControllerSendNotification**](NotificationsApi.md#notificationscontrollersendnotification) | **POST** /api/v1/notifications/send | Send a notification manually


# **notificationsControllerGetMyNotifications**
> notificationsControllerGetMyNotifications(page, limit, cursor)

Get my notifications

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getNotificationsApi();
final num page = 8.14; // num | Page number (1-indexed)
final num limit = 8.14; // num | Items per page
final String cursor = cursor_example; // String | Cursor for cursor-based pagination

try {
    api.notificationsControllerGetMyNotifications(page, limit, cursor);
} on DioException catch (e) {
    print('Exception when calling NotificationsApi->notificationsControllerGetMyNotifications: $e\n');
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

# **notificationsControllerGetUnreadCount**
> notificationsControllerGetUnreadCount()

Get unread notification count

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getNotificationsApi();

try {
    api.notificationsControllerGetUnreadCount();
} on DioException catch (e) {
    print('Exception when calling NotificationsApi->notificationsControllerGetUnreadCount: $e\n');
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

# **notificationsControllerMarkAllAsRead**
> notificationsControllerMarkAllAsRead()

Mark all notifications as read

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getNotificationsApi();

try {
    api.notificationsControllerMarkAllAsRead();
} on DioException catch (e) {
    print('Exception when calling NotificationsApi->notificationsControllerMarkAllAsRead: $e\n');
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

# **notificationsControllerMarkAsRead**
> notificationsControllerMarkAsRead(id)

Mark a notification as read

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getNotificationsApi();
final String id = id_example; // String | 

try {
    api.notificationsControllerMarkAsRead(id);
} on DioException catch (e) {
    print('Exception when calling NotificationsApi->notificationsControllerMarkAsRead: $e\n');
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

# **notificationsControllerSendNotification**
> notificationsControllerSendNotification(sendNotificationDto)

Send a notification manually

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getNotificationsApi();
final SendNotificationDto sendNotificationDto = ; // SendNotificationDto | 

try {
    api.notificationsControllerSendNotification(sendNotificationDto);
} on DioException catch (e) {
    print('Exception when calling NotificationsApi->notificationsControllerSendNotification: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sendNotificationDto** | [**SendNotificationDto**](SendNotificationDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

