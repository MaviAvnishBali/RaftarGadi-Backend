# api_client.api.AuthApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**authControllerGetMe**](AuthApi.md#authcontrollergetme) | **GET** /api/v1/auth/me | Get current user profile
[**authControllerLogout**](AuthApi.md#authcontrollerlogout) | **POST** /api/v1/auth/logout | Logout user from current device
[**authControllerLogoutAll**](AuthApi.md#authcontrollerlogoutall) | **POST** /api/v1/auth/logout-all | Logout user from all devices
[**authControllerRefreshTokens**](AuthApi.md#authcontrollerrefreshtokens) | **POST** /api/v1/auth/refresh | Refresh access token
[**authControllerSendOtp**](AuthApi.md#authcontrollersendotp) | **POST** /api/v1/auth/send-otp | Send OTP to phone
[**authControllerVerifyOtp**](AuthApi.md#authcontrollerverifyotp) | **POST** /api/v1/auth/verify-otp | Verify OTP and login


# **authControllerGetMe**
> authControllerGetMe()

Get current user profile

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAuthApi();

try {
    api.authControllerGetMe();
} on DioException catch (e) {
    print('Exception when calling AuthApi->authControllerGetMe: $e\n');
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

# **authControllerLogout**
> authControllerLogout(refreshTokenDto)

Logout user from current device

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAuthApi();
final RefreshTokenDto refreshTokenDto = ; // RefreshTokenDto | 

try {
    api.authControllerLogout(refreshTokenDto);
} on DioException catch (e) {
    print('Exception when calling AuthApi->authControllerLogout: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **refreshTokenDto** | [**RefreshTokenDto**](RefreshTokenDto.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authControllerLogoutAll**
> authControllerLogoutAll()

Logout user from all devices

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAuthApi();

try {
    api.authControllerLogoutAll();
} on DioException catch (e) {
    print('Exception when calling AuthApi->authControllerLogoutAll: $e\n');
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

# **authControllerRefreshTokens**
> authControllerRefreshTokens(refreshTokenDto)

Refresh access token

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAuthApi();
final RefreshTokenDto refreshTokenDto = ; // RefreshTokenDto | 

try {
    api.authControllerRefreshTokens(refreshTokenDto);
} on DioException catch (e) {
    print('Exception when calling AuthApi->authControllerRefreshTokens: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **refreshTokenDto** | [**RefreshTokenDto**](RefreshTokenDto.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authControllerSendOtp**
> authControllerSendOtp(sendOtpDto)

Send OTP to phone

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAuthApi();
final SendOtpDto sendOtpDto = ; // SendOtpDto | 

try {
    api.authControllerSendOtp(sendOtpDto);
} on DioException catch (e) {
    print('Exception when calling AuthApi->authControllerSendOtp: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sendOtpDto** | [**SendOtpDto**](SendOtpDto.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authControllerVerifyOtp**
> authControllerVerifyOtp(verifyOtpDto)

Verify OTP and login

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAuthApi();
final VerifyOtpDto verifyOtpDto = ; // VerifyOtpDto | 

try {
    api.authControllerVerifyOtp(verifyOtpDto);
} on DioException catch (e) {
    print('Exception when calling AuthApi->authControllerVerifyOtp: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **verifyOtpDto** | [**VerifyOtpDto**](VerifyOtpDto.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

