# api_client.api.SupportApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**supportControllerCreateTicket**](SupportApi.md#supportcontrollercreateticket) | **POST** /api/v1/support/tickets | Create a support ticket
[**supportControllerGetAllTickets**](SupportApi.md#supportcontrollergetalltickets) | **GET** /api/v1/support/tickets | Get all support tickets
[**supportControllerGetMyTickets**](SupportApi.md#supportcontrollergetmytickets) | **GET** /api/v1/support/tickets/my | Get my support tickets
[**supportControllerGetTicketById**](SupportApi.md#supportcontrollergetticketbyid) | **GET** /api/v1/support/tickets/{id} | Get a specific ticket
[**supportControllerUpdateTicket**](SupportApi.md#supportcontrollerupdateticket) | **PATCH** /api/v1/support/tickets/{id} | Update a ticket


# **supportControllerCreateTicket**
> supportControllerCreateTicket(createTicketDto)

Create a support ticket

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSupportApi();
final CreateTicketDto createTicketDto = ; // CreateTicketDto | 

try {
    api.supportControllerCreateTicket(createTicketDto);
} on DioException catch (e) {
    print('Exception when calling SupportApi->supportControllerCreateTicket: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createTicketDto** | [**CreateTicketDto**](CreateTicketDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **supportControllerGetAllTickets**
> supportControllerGetAllTickets(page, limit, cursor, status, priority, assignedTo)

Get all support tickets

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSupportApi();
final num page = 8.14; // num | Page number (1-indexed)
final num limit = 8.14; // num | Items per page
final String cursor = cursor_example; // String | Cursor for cursor-based pagination
final String status = status_example; // String | 
final String priority = priority_example; // String | 
final String assignedTo = assignedTo_example; // String | 

try {
    api.supportControllerGetAllTickets(page, limit, cursor, status, priority, assignedTo);
} on DioException catch (e) {
    print('Exception when calling SupportApi->supportControllerGetAllTickets: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **num**| Page number (1-indexed) | [optional] [default to 1]
 **limit** | **num**| Items per page | [optional] [default to 20]
 **cursor** | **String**| Cursor for cursor-based pagination | [optional] 
 **status** | **String**|  | [optional] 
 **priority** | **String**|  | [optional] 
 **assignedTo** | **String**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **supportControllerGetMyTickets**
> supportControllerGetMyTickets(page, limit, cursor)

Get my support tickets

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSupportApi();
final num page = 8.14; // num | Page number (1-indexed)
final num limit = 8.14; // num | Items per page
final String cursor = cursor_example; // String | Cursor for cursor-based pagination

try {
    api.supportControllerGetMyTickets(page, limit, cursor);
} on DioException catch (e) {
    print('Exception when calling SupportApi->supportControllerGetMyTickets: $e\n');
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

# **supportControllerGetTicketById**
> supportControllerGetTicketById(id)

Get a specific ticket

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSupportApi();
final String id = id_example; // String | 

try {
    api.supportControllerGetTicketById(id);
} on DioException catch (e) {
    print('Exception when calling SupportApi->supportControllerGetTicketById: $e\n');
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

# **supportControllerUpdateTicket**
> supportControllerUpdateTicket(id, updateTicketDto)

Update a ticket

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSupportApi();
final String id = id_example; // String | 
final UpdateTicketDto updateTicketDto = ; // UpdateTicketDto | 

try {
    api.supportControllerUpdateTicket(id, updateTicketDto);
} on DioException catch (e) {
    print('Exception when calling SupportApi->supportControllerUpdateTicket: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateTicketDto** | [**UpdateTicketDto**](UpdateTicketDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

