# api_client.api.PricingApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**pricingControllerCreateRule**](PricingApi.md#pricingcontrollercreaterule) | **POST** /api/v1/pricing/rules | Create pricing rule
[**pricingControllerEstimateFare**](PricingApi.md#pricingcontrollerestimatefare) | **POST** /api/v1/pricing/estimate | Calculate fare estimate
[**pricingControllerGetRules**](PricingApi.md#pricingcontrollergetrules) | **GET** /api/v1/pricing/rules | List pricing rules
[**pricingControllerSetSurge**](PricingApi.md#pricingcontrollersetsurge) | **POST** /api/v1/pricing/surge | Set surge multiplier
[**pricingControllerUpdateRule**](PricingApi.md#pricingcontrollerupdaterule) | **PATCH** /api/v1/pricing/rules/{id} | Update pricing rule


# **pricingControllerCreateRule**
> pricingControllerCreateRule(createPricingRuleDto)

Create pricing rule

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getPricingApi();
final CreatePricingRuleDto createPricingRuleDto = ; // CreatePricingRuleDto | 

try {
    api.pricingControllerCreateRule(createPricingRuleDto);
} on DioException catch (e) {
    print('Exception when calling PricingApi->pricingControllerCreateRule: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createPricingRuleDto** | [**CreatePricingRuleDto**](CreatePricingRuleDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **pricingControllerEstimateFare**
> JsonObject pricingControllerEstimateFare(calculateFareDto)

Calculate fare estimate

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getPricingApi();
final CalculateFareDto calculateFareDto = ; // CalculateFareDto | 

try {
    final response = api.pricingControllerEstimateFare(calculateFareDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PricingApi->pricingControllerEstimateFare: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **calculateFareDto** | [**CalculateFareDto**](CalculateFareDto.md)|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **pricingControllerGetRules**
> pricingControllerGetRules(page, limit, cursor)

List pricing rules

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getPricingApi();
final num page = 8.14; // num | Page number (1-indexed)
final num limit = 8.14; // num | Items per page
final String cursor = cursor_example; // String | Cursor for cursor-based pagination

try {
    api.pricingControllerGetRules(page, limit, cursor);
} on DioException catch (e) {
    print('Exception when calling PricingApi->pricingControllerGetRules: $e\n');
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

# **pricingControllerSetSurge**
> pricingControllerSetSurge()

Set surge multiplier

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getPricingApi();

try {
    api.pricingControllerSetSurge();
} on DioException catch (e) {
    print('Exception when calling PricingApi->pricingControllerSetSurge: $e\n');
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

# **pricingControllerUpdateRule**
> pricingControllerUpdateRule(id, updatePricingRuleDto)

Update pricing rule

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getPricingApi();
final String id = id_example; // String | 
final UpdatePricingRuleDto updatePricingRuleDto = ; // UpdatePricingRuleDto | 

try {
    api.pricingControllerUpdateRule(id, updatePricingRuleDto);
} on DioException catch (e) {
    print('Exception when calling PricingApi->pricingControllerUpdateRule: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updatePricingRuleDto** | [**UpdatePricingRuleDto**](UpdatePricingRuleDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

