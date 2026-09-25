# api_client.api.CouponsApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**couponsControllerCreateCoupon**](CouponsApi.md#couponscontrollercreatecoupon) | **POST** /api/v1/coupons | Create a new coupon
[**couponsControllerDeactivateCoupon**](CouponsApi.md#couponscontrollerdeactivatecoupon) | **DELETE** /api/v1/coupons/{id} | Deactivate a coupon
[**couponsControllerGetActiveCoupons**](CouponsApi.md#couponscontrollergetactivecoupons) | **GET** /api/v1/coupons/active | List active coupons
[**couponsControllerGetCoupons**](CouponsApi.md#couponscontrollergetcoupons) | **GET** /api/v1/coupons | List all coupons
[**couponsControllerUpdateCoupon**](CouponsApi.md#couponscontrollerupdatecoupon) | **PATCH** /api/v1/coupons/{id} | Update a coupon
[**couponsControllerValidateCoupon**](CouponsApi.md#couponscontrollervalidatecoupon) | **POST** /api/v1/coupons/validate | Validate a coupon


# **couponsControllerCreateCoupon**
> couponsControllerCreateCoupon(createCouponDto)

Create a new coupon

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getCouponsApi();
final CreateCouponDto createCouponDto = ; // CreateCouponDto | 

try {
    api.couponsControllerCreateCoupon(createCouponDto);
} on DioException catch (e) {
    print('Exception when calling CouponsApi->couponsControllerCreateCoupon: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createCouponDto** | [**CreateCouponDto**](CreateCouponDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **couponsControllerDeactivateCoupon**
> couponsControllerDeactivateCoupon(id)

Deactivate a coupon

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getCouponsApi();
final String id = id_example; // String | 

try {
    api.couponsControllerDeactivateCoupon(id);
} on DioException catch (e) {
    print('Exception when calling CouponsApi->couponsControllerDeactivateCoupon: $e\n');
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

# **couponsControllerGetActiveCoupons**
> couponsControllerGetActiveCoupons()

List active coupons

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getCouponsApi();

try {
    api.couponsControllerGetActiveCoupons();
} on DioException catch (e) {
    print('Exception when calling CouponsApi->couponsControllerGetActiveCoupons: $e\n');
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

# **couponsControllerGetCoupons**
> couponsControllerGetCoupons(page, limit, cursor)

List all coupons

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getCouponsApi();
final num page = 8.14; // num | Page number (1-indexed)
final num limit = 8.14; // num | Items per page
final String cursor = cursor_example; // String | Cursor for cursor-based pagination

try {
    api.couponsControllerGetCoupons(page, limit, cursor);
} on DioException catch (e) {
    print('Exception when calling CouponsApi->couponsControllerGetCoupons: $e\n');
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

# **couponsControllerUpdateCoupon**
> couponsControllerUpdateCoupon(id, updateCouponDto)

Update a coupon

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getCouponsApi();
final String id = id_example; // String | 
final UpdateCouponDto updateCouponDto = ; // UpdateCouponDto | 

try {
    api.couponsControllerUpdateCoupon(id, updateCouponDto);
} on DioException catch (e) {
    print('Exception when calling CouponsApi->couponsControllerUpdateCoupon: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateCouponDto** | [**UpdateCouponDto**](UpdateCouponDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **couponsControllerValidateCoupon**
> couponsControllerValidateCoupon(validateCouponDto)

Validate a coupon

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getCouponsApi();
final ValidateCouponDto validateCouponDto = ; // ValidateCouponDto | 

try {
    api.couponsControllerValidateCoupon(validateCouponDto);
} on DioException catch (e) {
    print('Exception when calling CouponsApi->couponsControllerValidateCoupon: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **validateCouponDto** | [**ValidateCouponDto**](ValidateCouponDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

