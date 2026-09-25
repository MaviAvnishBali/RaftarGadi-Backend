//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'send_otp_dto.g.dart';

/// SendOtpDto
///
/// Properties:
/// * [phone] - The phone number to send OTP to
@BuiltValue()
abstract class SendOtpDto implements Built<SendOtpDto, SendOtpDtoBuilder> {
  /// The phone number to send OTP to
  @BuiltValueField(wireName: r'phone')
  String get phone;

  SendOtpDto._();

  factory SendOtpDto([void updates(SendOtpDtoBuilder b)]) = _$SendOtpDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SendOtpDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SendOtpDto> get serializer => _$SendOtpDtoSerializer();
}

class _$SendOtpDtoSerializer implements PrimitiveSerializer<SendOtpDto> {
  @override
  final Iterable<Type> types = const [SendOtpDto, _$SendOtpDto];

  @override
  final String wireName = r'SendOtpDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SendOtpDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'phone';
    yield serializers.serialize(
      object.phone,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SendOtpDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SendOtpDtoBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SendOtpDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SendOtpDtoBuilder();
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


