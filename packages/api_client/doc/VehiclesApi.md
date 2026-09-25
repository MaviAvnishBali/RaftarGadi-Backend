# api_client.api.VehiclesApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**vehiclesControllerCreateVehicleType**](VehiclesApi.md#vehiclescontrollercreatevehicletype) | **POST** /api/v1/vehicles/types | Create vehicle type
[**vehiclesControllerGetDriverVehicle**](VehiclesApi.md#vehiclescontrollergetdrivervehicle) | **GET** /api/v1/vehicles/my-vehicle | Get own vehicle
[**vehiclesControllerGetVehicleTypes**](VehiclesApi.md#vehiclescontrollergetvehicletypes) | **GET** /api/v1/vehicles/types | List vehicle types
[**vehiclesControllerRegisterVehicle**](VehiclesApi.md#vehiclescontrollerregistervehicle) | **POST** /api/v1/vehicles/register | Register vehicle
[**vehiclesControllerUpdateVehicle**](VehiclesApi.md#vehiclescontrollerupdatevehicle) | **PATCH** /api/v1/vehicles/{id} | Update vehicle


# **vehiclesControllerCreateVehicleType**
> vehiclesControllerCreateVehicleType(createVehicleTypeDto)

Create vehicle type

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getVehiclesApi();
final CreateVehicleTypeDto createVehicleTypeDto = ; // CreateVehicleTypeDto | 

try {
    api.vehiclesControllerCreateVehicleType(createVehicleTypeDto);
} on DioException catch (e) {
    print('Exception when calling VehiclesApi->vehiclesControllerCreateVehicleType: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createVehicleTypeDto** | [**CreateVehicleTypeDto**](CreateVehicleTypeDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **vehiclesControllerGetDriverVehicle**
> JsonObject vehiclesControllerGetDriverVehicle()

Get own vehicle

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getVehiclesApi();

try {
    final response = api.vehiclesControllerGetDriverVehicle();
    print(response);
} on DioException catch (e) {
    print('Exception when calling VehiclesApi->vehiclesControllerGetDriverVehicle: $e\n');
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

# **vehiclesControllerGetVehicleTypes**
> vehiclesControllerGetVehicleTypes()

List vehicle types

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getVehiclesApi();

try {
    api.vehiclesControllerGetVehicleTypes();
} on DioException catch (e) {
    print('Exception when calling VehiclesApi->vehiclesControllerGetVehicleTypes: $e\n');
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

# **vehiclesControllerRegisterVehicle**
> vehiclesControllerRegisterVehicle(registerVehicleDto)

Register vehicle

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getVehiclesApi();
final RegisterVehicleDto registerVehicleDto = ; // RegisterVehicleDto | 

try {
    api.vehiclesControllerRegisterVehicle(registerVehicleDto);
} on DioException catch (e) {
    print('Exception when calling VehiclesApi->vehiclesControllerRegisterVehicle: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **registerVehicleDto** | [**RegisterVehicleDto**](RegisterVehicleDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **vehiclesControllerUpdateVehicle**
> vehiclesControllerUpdateVehicle(id, updateVehicleDto)

Update vehicle

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getVehiclesApi();
final String id = id_example; // String | 
final UpdateVehicleDto updateVehicleDto = ; // UpdateVehicleDto | 

try {
    api.vehiclesControllerUpdateVehicle(id, updateVehicleDto);
} on DioException catch (e) {
    print('Exception when calling VehiclesApi->vehiclesControllerUpdateVehicle: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateVehicleDto** | [**UpdateVehicleDto**](UpdateVehicleDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[access-token](../README.md#access-token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

