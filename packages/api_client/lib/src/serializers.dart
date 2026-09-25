//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:api_client/src/date_serializer.dart';
import 'package:api_client/src/model/date.dart';

import 'package:api_client/src/model/calculate_fare_dto.dart';
import 'package:api_client/src/model/cancel_booking_dto.dart';
import 'package:api_client/src/model/complete_trip_dto.dart';
import 'package:api_client/src/model/create_booking_dto.dart';
import 'package:api_client/src/model/create_coupon_dto.dart';
import 'package:api_client/src/model/create_pricing_rule_dto.dart';
import 'package:api_client/src/model/create_rating_dto.dart';
import 'package:api_client/src/model/create_ticket_dto.dart';
import 'package:api_client/src/model/create_vehicle_type_dto.dart';
import 'package:api_client/src/model/health_controller_check200_response.dart';
import 'package:api_client/src/model/health_controller_check200_response_info_value.dart';
import 'package:api_client/src/model/health_controller_check503_response.dart';
import 'package:api_client/src/model/initiate_payment_dto.dart';
import 'package:api_client/src/model/refresh_token_dto.dart';
import 'package:api_client/src/model/register_driver_dto.dart';
import 'package:api_client/src/model/register_vehicle_dto.dart';
import 'package:api_client/src/model/send_notification_dto.dart';
import 'package:api_client/src/model/send_otp_dto.dart';
import 'package:api_client/src/model/update_coupon_dto.dart';
import 'package:api_client/src/model/update_customer_dto.dart';
import 'package:api_client/src/model/update_driver_dto.dart';
import 'package:api_client/src/model/update_pricing_rule_dto.dart';
import 'package:api_client/src/model/update_ticket_dto.dart';
import 'package:api_client/src/model/update_vehicle_dto.dart';
import 'package:api_client/src/model/upload_document_dto.dart';
import 'package:api_client/src/model/validate_coupon_dto.dart';
import 'package:api_client/src/model/verify_otp_dto.dart';
import 'package:api_client/src/model/wallet_operation_dto.dart';
import 'package:api_client/src/model/webhook_payload_dto.dart';

part 'serializers.g.dart';

@SerializersFor([
  CalculateFareDto,
  CancelBookingDto,
  CompleteTripDto,
  CreateBookingDto,
  CreateCouponDto,
  CreatePricingRuleDto,
  CreateRatingDto,
  CreateTicketDto,
  CreateVehicleTypeDto,
  HealthControllerCheck200Response,
  HealthControllerCheck200ResponseInfoValue,
  HealthControllerCheck503Response,
  InitiatePaymentDto,
  RefreshTokenDto,
  RegisterDriverDto,
  RegisterVehicleDto,
  SendNotificationDto,
  SendOtpDto,
  UpdateCouponDto,
  UpdateCustomerDto,
  UpdateDriverDto,
  UpdatePricingRuleDto,
  UpdateTicketDto,
  UpdateVehicleDto,
  UploadDocumentDto,
  ValidateCouponDto,
  VerifyOtpDto,
  WalletOperationDto,
  WebhookPayloadDto,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltMap, [FullType(String), FullType(HealthControllerCheck200ResponseInfoValue)]),
        () => MapBuilder<String, HealthControllerCheck200ResponseInfoValue>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(JsonObject)]),
        () => ListBuilder<JsonObject>(),
      )
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer())
    ).build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
