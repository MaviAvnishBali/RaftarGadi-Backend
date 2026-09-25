//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'verify_otp_dto.g.dart';

/// VerifyOtpDto
///
/// Properties:
/// * [phone] - The phone number the OTP was sent to
/// * [otp] - The 6-digit OTP
/// * [role] 
/// * [deviceInfo] - Device information
@BuiltValue()
abstract class VerifyOtpDto implements Built<VerifyOtpDto, VerifyOtpDtoBuilder> {
  /// The phone number the OTP was sent to
  @BuiltValueField(wireName: r'phone')
  String get phone;

  /// The 6-digit OTP
  @BuiltValueField(wireName: r'otp')
  String get otp;

  @BuiltValueField(wireName: r'role')
  VerifyOtpDtoRoleEnum? get role;
  // enum roleEnum {  CUSTOMER,  DRIVER,  ADMIN,  SUPER_ADMIN,  };

  /// Device information
  @BuiltValueField(wireName: r'deviceInfo')
  String? get deviceInfo;

  VerifyOtpDto._();

  factory VerifyOtpDto([void updates(VerifyOtpDtoBuilder b)]) = _$VerifyOtpDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(VerifyOtpDtoBuilder b) => b
      ..role = VerifyOtpDtoRoleEnum.valueOf('CUSTOMER');

  @BuiltValueSerializer(custom: true)
  static Serializer<VerifyOtpDto> get serializer => _$VerifyOtpDtoSerializer();
}

class _$VerifyOtpDtoSerializer implements PrimitiveSerializer<VerifyOtpDto> {
  @override
  final Iterable<Type> types = const [VerifyOtpDto, _$VerifyOtpDto];

  @override
  final String wireName = r'VerifyOtpDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    VerifyOtpDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'phone';
    yield serializers.serialize(
      object.phone,
      specifiedType: const FullType(String),
    );
    yield r'otp';
    yield serializers.serialize(
      object.otp,
      specifiedType: const FullType(String),
    );
    if (object.role != null) {
      yield r'role';
      yield serializers.serialize(
        object.role,
        specifiedType: const FullType(VerifyOtpDtoRoleEnum),
      );
    }
    if (object.deviceInfo != null) {
      yield r'deviceInfo';
      yield serializers.serialize(
        object.deviceInfo,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    VerifyOtpDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required VerifyOtpDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'phone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.phone = valueDes;
          break;
        case r'otp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.otp = valueDes;
          break;
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(VerifyOtpDtoRoleEnum),
          ) as VerifyOtpDtoRoleEnum?;
          if (valueDes == null) continue;
          result.role = valueDes;
          break;
        case r'deviceInfo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.deviceInfo = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  VerifyOtpDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = VerifyOtpDtoBuilder();
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


class VerifyOtpDtoRoleEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'CUSTOMER')
  static const VerifyOtpDtoRoleEnum CUSTOMER = _$verifyOtpDtoRoleEnum_CUSTOMER;
  @BuiltValueEnumConst(wireName: r'DRIVER')
  static const VerifyOtpDtoRoleEnum DRIVER = _$verifyOtpDtoRoleEnum_DRIVER;
  @BuiltValueEnumConst(wireName: r'ADMIN')
  static const VerifyOtpDtoRoleEnum ADMIN = _$verifyOtpDtoRoleEnum_ADMIN;
  @BuiltValueEnumConst(wireName: r'SUPER_ADMIN')
  static const VerifyOtpDtoRoleEnum SUPER_ADMIN = _$verifyOtpDtoRoleEnum_SUPER_ADMIN;

  static Serializer<VerifyOtpDtoRoleEnum> get serializer => _$verifyOtpDtoRoleEnumSerializer;

  const VerifyOtpDtoRoleEnum._(String name): super(name);

  static BuiltSet<VerifyOtpDtoRoleEnum> get values => _$verifyOtpDtoRoleEnumValues;
  static VerifyOtpDtoRoleEnum valueOf(String name) => _$verifyOtpDtoRoleEnumValueOf(name);
}

