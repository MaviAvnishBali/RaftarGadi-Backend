# api_client.api.WalletsApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**walletsControllerGetDriverTransactions**](WalletsApi.md#walletscontrollergetdrivertransactions) | **GET** /api/v1/wallets/driver/{driverId}/transactions | Admin view driver wallet transactions
[**walletsControllerGetDriverWallet**](WalletsApi.md#walletscontrollergetdriverwallet) | **GET** /api/v1/wallets/driver/{driverId} | Admin view driver wallet
[**walletsControllerGetMyTransactions**](WalletsApi.md#walletscontrollergetmytransactions) | **GET** /api/v1/wallets/my-wallet/transactions | Get current driver wallet transactions
[**walletsControllerGetMyWallet**](WalletsApi.md#walletscontrollergetmywallet) | **GET** /api/v1/wallets/my-wallet | Get current driver wallet
[**walletsControllerRequestWithdrawal**](WalletsApi.md#walletscontrollerrequestwithdrawal) | **POST** /api/v1/wallets/withdraw | Request withdrawal


# **walletsControllerGetDriverTransactions**
> walletsControllerGetDriverTransactions(driverId, page, limit, cursor, type, from, to)

Admin view driver wallet transactions

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getWalletsApi();
final String driverId = driverId_example; // String | 
final num page = 8.14; // num | Page number (1-indexed)
final num limit = 8.14; // num | Items per page
final String cursor = cursor_example; // String | Cursor for cursor-based pagination
final String type = type_example; // String | 
final String from = from_example; // String | 
final String to = to_example; // String | 

try {
    api.walletsControllerGetDriverTransactions(driverId, page, limit, cursor, type, from, to);
} on DioException catch (e) {
    print('Exception when calling WalletsApi->walletsControllerGetDriverTransactions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **driverId** | **String**|  | 
 **page** | **num**| Page number (1-indexed) | [optional] [default to 1]
 **limit** | **num**| Items per page | [optional] [default to 20]
 **cursor** | **String**| Cursor for cursor-based pagination | [optional] 
 **type** | **String**|  | [optional] 
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

# **walletsControllerGetDriverWallet**
> walletsControllerGetDriverWallet(driverId)

Admin view driver wallet

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getWalletsApi();
final String driverId = driverId_example; // String | 

try {
    api.walletsControllerGetDriverWallet(driverId);
} on DioException catch (e) {
    print('Exception when calling WalletsApi->walletsControllerGetDriverWallet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **driverId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **walletsControllerGetMyTransactions**
> walletsControllerGetMyTransactions(page, limit, cursor, type, from, to)

Get current driver wallet transactions

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getWalletsApi();
final num page = 8.14; // num | Page number (1-indexed)
final num limit = 8.14; // num | Items per page
final String cursor = cursor_example; // String | Cursor for cursor-based pagination
final String type = type_example; // String | 
final String from = from_example; // String | 
final String to = to_example; // String | 

try {
    api.walletsControllerGetMyTransactions(page, limit, cursor, type, from, to);
} on DioException catch (e) {
    print('Exception when calling WalletsApi->walletsControllerGetMyTransactions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **num**| Page number (1-indexed) | [optional] [default to 1]
 **limit** | **num**| Items per page | [optional] [default to 20]
 **cursor** | **String**| Cursor for cursor-based pagination | [optional] 
 **type** | **String**|  | [optional] 
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

# **walletsControllerGetMyWallet**
> walletsControllerGetMyWallet()

Get current driver wallet

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getWalletsApi();

try {
    api.walletsControllerGetMyWallet();
} on DioException catch (e) {
    print('Exception when calling WalletsApi->walletsControllerGetMyWallet: $e\n');
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

# **walletsControllerRequestWithdrawal**
> walletsControllerRequestWithdrawal(walletOperationDto)

Request withdrawal

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getWalletsApi();
final WalletOperationDto walletOperationDto = ; // WalletOperationDto | 

try {
    api.walletsControllerRequestWithdrawal(walletOperationDto);
} on DioException catch (e) {
    print('Exception when calling WalletsApi->walletsControllerRequestWithdrawal: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **walletOperationDto** | [**WalletOperationDto**](WalletOperationDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

