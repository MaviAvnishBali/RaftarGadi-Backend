//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_booking_dto.g.dart';

/// CreateBookingDto
///
/// Properties:
/// * [pickupLat] - Pickup latitude
/// * [pickupLng] - Pickup longitude
/// * [pickupAddress] - Pickup address string
/// * [dropLat] - Drop latitude
/// * [dropLng] - Drop longitude
/// * [dropAddress] - Drop address string
/// * [vehicleTypeId] - Vehicle type ID
/// * [packageType] - Package type
/// * [packageDescription] - Package description
/// * [packageWeightKg] - Package weight in kg
/// * [paymentMethod] - Payment method
/// * [couponCode] - Coupon code
/// * [scheduledAt] - Scheduled date and time
@BuiltValue()
abstract class CreateBookingDto implements Built<CreateBookingDto, CreateBookingDtoBuilder> {
  /// Pickup latitude
  @BuiltValueField(wireName: r'pickupLat')
  num get pickupLat;

  /// Pickup longitude
  @BuiltValueField(wireName: r'pickupLng')
  num get pickupLng;

  /// Pickup address string
  @BuiltValueField(wireName: r'pickupAddress')
  String get pickupAddress;

  /// Drop latitude
  @BuiltValueField(wireName: r'dropLat')
  num get dropLat;

  /// Drop longitude
  @BuiltValueField(wireName: r'dropLng')
  num get dropLng;

  /// Drop address string
  @BuiltValueField(wireName: r'dropAddress')
  String get dropAddress;

  /// Vehicle type ID
  @BuiltValueField(wireName: r'vehicleTypeId')
  String get vehicleTypeId;

  /// Package type
  @BuiltValueField(wireName: r'packageType')
  String? get packageType;

  /// Package description
  @BuiltValueField(wireName: r'packageDescription')
  String? get packageDescription;

  /// Package weight in kg
  @BuiltValueField(wireName: r'packageWeightKg')
  num? get packageWeightKg;

  /// Payment method
  @BuiltValueField(wireName: r'paymentMethod')
  CreateBookingDtoPaymentMethodEnum? get paymentMethod;
  // enum paymentMethodEnum {  CASH,  UPI,  CARD,  WALLET,  };

  /// Coupon code
  @BuiltValueField(wireName: r'couponCode')
  String? get couponCode;

  /// Scheduled date and time
  @BuiltValueField(wireName: r'scheduledAt')
  DateTime? get scheduledAt;

  CreateBookingDto._();

  factory CreateBookingDto([void updates(CreateBookingDtoBuilder b)]) = _$CreateBookingDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateBookingDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateBookingDto> get serializer => _$CreateBookingDtoSerializer();
}

class _$CreateBookingDtoSerializer implements PrimitiveSerializer<CreateBookingDto> {
  @override
  final Iterable<Type> types = const [CreateBookingDto, _$CreateBookingDto];

  @override
  final String wireName = r'CreateBookingDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateBookingDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'pickupLat';
    yield serializers.serialize(
      object.pickupLat,
      specifiedType: const FullType(num),
    );
    yield r'pickupLng';
    yield serializers.serialize(
      object.pickupLng,
      specifiedType: const FullType(num),
    );
    yield r'pickupAddress';
    yield serializers.serialize(
      object.pickupAddress,
      specifiedType: const FullType(String),
    );
    yield r'dropLat';
    yield serializers.serialize(
      object.dropLat,
      specifiedType: const FullType(num),
    );
    yield r'dropLng';
    yield serializers.serialize(
      object.dropLng,
      specifiedType: const FullType(num),
    );
    yield r'dropAddress';
    yield serializers.serialize(
      object.dropAddress,
      specifiedType: const FullType(String),
    );
    yield r'vehicleTypeId';
    yield serializers.serialize(
      object.vehicleTypeId,
      specifiedType: const FullType(String),
    );
    if (object.packageType != null) {
      yield r'packageType';
      yield serializers.serialize(
        object.packageType,
        specifiedType: const FullType(String),
      );
    }
    if (object.packageDescription != null) {
      yield r'packageDescription';
      yield serializers.serialize(
        object.packageDescription,
        specifiedType: const FullType(String),
      );
    }
    if (object.packageWeightKg != null) {
      yield r'packageWeightKg';
      yield serializers.serialize(
        object.packageWeightKg,
        specifiedType: const FullType(num),
      );
    }
    if (object.paymentMethod != null) {
      yield r'paymentMethod';
      yield serializers.serialize(
        object.paymentMethod,
        specifiedType: const FullType(CreateBookingDtoPaymentMethodEnum),
      );
    }
    if (object.couponCode != null) {
      yield r'couponCode';
      yield serializers.serialize(
        object.couponCode,
        specifiedType: const FullType(String),
      );
    }
    if (object.scheduledAt != null) {
      yield r'scheduledAt';
      yield serializers.serialize(
        object.scheduledAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateBookingDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateBookingDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'pickupLat':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.pickupLat = valueDes;
          break;
        case r'pickupLng':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.pickupLng = valueDes;
          break;
        case r'pickupAddress':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.pickupAddress = valueDes;
          break;
        case r'dropLat':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.dropLat = valueDes;
          break;
        case r'dropLng':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.dropLng = valueDes;
          break;
        case r'dropAddress':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.dropAddress = valueDes;
          break;
        case r'vehicleTypeId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.vehicleTypeId = valueDes;
          break;
        case r'packageType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.packageType = valueDes;
          break;
        case r'packageDescription':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.packageDescription = valueDes;
          break;
        case r'packageWeightKg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.packageWeightKg = valueDes;
          break;
        case r'paymentMethod':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(CreateBookingDtoPaymentMethodEnum),
          ) as CreateBookingDtoPaymentMethodEnum?;
          if (valueDes == null) continue;
          result.paymentMethod = valueDes;
          break;
        case r'couponCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.couponCode = valueDes;
          break;
        case r'scheduledAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.scheduledAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateBookingDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateBookingDtoBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}


/// Payment method
class CreateBookingDtoPaymentMethodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'CASH')
  static const CreateBookingDtoPaymentMethodEnum CASH = _$createBookingDtoPaymentMethodEnum_CASH;
  @BuiltValueEnumConst(wireName: r'UPI')
  static const CreateBookingDtoPaymentMethodEnum UPI = _$createBookingDtoPaymentMethodEnum_UPI;
  @BuiltValueEnumConst(wireName: r'CARD')
  static const CreateBookingDtoPaymentMethodEnum CARD = _$createBookingDtoPaymentMethodEnum_CARD;
  @BuiltValueEnumConst(wireName: r'WALLET')
  static const CreateBookingDtoPaymentMethodEnum WALLET = _$createBookingDtoPaymentMethodEnum_WALLET;

  static Serializer<CreateBookingDtoPaymentMethodEnum> get serializer => _$createBookingDtoPaymentMethodEnumSerializer;

  const CreateBookingDtoPaymentMethodEnum._(String name): super(name);

  static BuiltSet<CreateBookingDtoPaymentMethodEnum> get values => _$createBookingDtoPaymentMethodEnumValues;
  static CreateBookingDtoPaymentMethodEnum valueOf(String name) => _$createBookingDtoPaymentMethodEnumValueOf(name);
}

