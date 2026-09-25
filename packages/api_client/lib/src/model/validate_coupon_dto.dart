//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'validate_coupon_dto.g.dart';

/// ValidateCouponDto
///
/// Properties:
/// * [code] 
/// * [bookingAmount] 
@BuiltValue()
abstract class ValidateCouponDto implements Built<ValidateCouponDto, ValidateCouponDtoBuilder> {
  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'bookingAmount')
  num get bookingAmount;

  ValidateCouponDto._();

  factory ValidateCouponDto([void updates(ValidateCouponDtoBuilder b)]) = _$ValidateCouponDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ValidateCouponDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ValidateCouponDto> get serializer => _$ValidateCouponDtoSerializer();
}

class _$ValidateCouponDtoSerializer implements PrimitiveSerializer<ValidateCouponDto> {
  @override
  final Iterable<Type> types = const [ValidateCouponDto, _$ValidateCouponDto];

  @override
  final String wireName = r'ValidateCouponDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ValidateCouponDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    yield r'bookingAmount';
    yield serializers.serialize(
      object.bookingAmount,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ValidateCouponDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ValidateCouponDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'bookingAmount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.bookingAmount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ValidateCouponDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ValidateCouponDtoBuilder();
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


