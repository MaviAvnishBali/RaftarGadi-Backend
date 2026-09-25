# api_client.api.PaymentsApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**paymentsControllerGetAllPayments**](PaymentsApi.md#paymentscontrollergetallpayments) | **GET** /api/v1/payments | List all payments
[**paymentsControllerGetPaymentByBooking**](PaymentsApi.md#paymentscontrollergetpaymentbybooking) | **GET** /api/v1/payments/booking/{bookingId} | Get payments for a booking
[**paymentsControllerInitiatePayment**](PaymentsApi.md#paymentscontrollerinitiatepayment) | **POST** /api/v1/payments/initiate | Initiate payment
[**paymentsControllerProcessWebhook**](PaymentsApi.md#paymentscontrollerprocesswebhook) | **POST** /api/v1/payments/webhook | Process payment webhook
[**paymentsControllerRefundPayment**](PaymentsApi.md#paymentscontrollerrefundpayment) | **POST** /api/v1/payments/{id}/refund | Refund a payment


# **paymentsControllerGetAllPayments**
> paymentsControllerGetAllPayments(page, limit, cursor, status, method, from, to)

List all payments

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getPaymentsApi();
final num page = 8.14; // num | Page number (1-indexed)
final num limit = 8.14; // num | Items per page
final String cursor = cursor_example; // String | Cursor for cursor-based pagination
final String status = status_example; // String | 
final String method = method_example; // String | 
final String from = from_example; // String | 
final String to = to_example; // String | 

try {
    api.paymentsControllerGetAllPayments(page, limit, cursor, status, method, from, to);
} on DioException catch (e) {
    print('Exception when calling PaymentsApi->paymentsControllerGetAllPayments: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **num**| Page number (1-indexed) | [optional] [default to 1]
 **limit** | **num**| Items per page | [optional] [default to 20]
 **cursor** | **String**| Cursor for cursor-based pagination | [optional] 
 **status** | **String**|  | [optional] 
 **method** | **String**|  | [optional] 
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

# **paymentsControllerGetPaymentByBooking**
> paymentsControllerGetPaymentByBooking(bookingId)

Get payments for a booking

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getPaymentsApi();
final String bookingId = bookingId_example; // String | 

try {
    api.paymentsControllerGetPaymentByBooking(bookingId);
} on DioException catch (e) {
    print('Exception when calling PaymentsApi->paymentsControllerGetPaymentByBooking: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookingId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **paymentsControllerInitiatePayment**
> paymentsControllerInitiatePayment(initiatePaymentDto, idempotencyKey)

Initiate payment

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getPaymentsApi();
final InitiatePaymentDto initiatePaymentDto = ; // InitiatePaymentDto | 
final String idempotencyKey = idempotencyKey_example; // String | 

try {
    api.paymentsControllerInitiatePayment(initiatePaymentDto, idempotencyKey);
} on DioException catch (e) {
    print('Exception when calling PaymentsApi->paymentsControllerInitiatePayment: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **initiatePaymentDto** | [**InitiatePaymentDto**](InitiatePaymentDto.md)|  | 
 **idempotencyKey** | **String**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **paymentsControllerProcessWebhook**
> paymentsControllerProcessWebhook(webhookPayloadDto)

Process payment webhook

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getPaymentsApi();
final WebhookPayloadDto webhookPayloadDto = ; // WebhookPayloadDto | 

try {
    api.paymentsControllerProcessWebhook(webhookPayloadDto);
} on DioException catch (e) {
    print('Exception when calling PaymentsApi->paymentsControllerProcessWebhook: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **webhookPayloadDto** | [**WebhookPayloadDto**](WebhookPayloadDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **paymentsControllerRefundPayment**
> paymentsControllerRefundPayment(id)

Refund a payment

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getPaymentsApi();
final String id = id_example; // String | 

try {
    api.paymentsControllerRefundPayment(id);
} on DioException catch (e) {
    print('Exception when calling PaymentsApi->paymentsControllerRefundPayment: $e\n');
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

