//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'initiate_payment_dto.g.dart';

/// InitiatePaymentDto
///
/// Properties:
/// * [bookingId] 
/// * [method] 
@BuiltValue()
abstract class InitiatePaymentDto implements Built<InitiatePaymentDto, InitiatePaymentDtoBuilder> {
  @BuiltValueField(wireName: r'bookingId')
  String get bookingId;

  @BuiltValueField(wireName: r'method')
  InitiatePaymentDtoMethodEnum get method;
  // enum methodEnum {  CASH,  UPI,  CARD,  WALLET,  };

  InitiatePaymentDto._();

  factory InitiatePaymentDto([void updates(InitiatePaymentDtoBuilder b)]) = _$InitiatePaymentDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(InitiatePaymentDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<InitiatePaymentDto> get serializer => _$InitiatePaymentDtoSerializer();
}

class _$InitiatePaymentDtoSerializer implements PrimitiveSerializer<InitiatePaymentDto> {
  @override
  final Iterable<Type> types = const [InitiatePaymentDto, _$InitiatePaymentDto];

  @override
  final String wireName = r'InitiatePaymentDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    InitiatePaymentDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'bookingId';
    yield serializers.serialize(
      object.bookingId,
      specifiedType: const FullType(String),
    );
    yield r'method';
    yield serializers.serialize(
      object.method,
      specifiedType: const FullType(InitiatePaymentDtoMethodEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    InitiatePaymentDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required InitiatePaymentDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'bookingId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.bookingId = valueDes;
          break;
        case r'method':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(InitiatePaymentDtoMethodEnum),
          ) as InitiatePaymentDtoMethodEnum;
          result.method = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  InitiatePaymentDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = InitiatePaymentDtoBuilder();
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


class InitiatePaymentDtoMethodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'CASH')
  static const InitiatePaymentDtoMethodEnum CASH = _$initiatePaymentDtoMethodEnum_CASH;
  @BuiltValueEnumConst(wireName: r'UPI')
  static const InitiatePaymentDtoMethodEnum UPI = _$initiatePaymentDtoMethodEnum_UPI;
  @BuiltValueEnumConst(wireName: r'CARD')
  static const InitiatePaymentDtoMethodEnum CARD = _$initiatePaymentDtoMethodEnum_CARD;
  @BuiltValueEnumConst(wireName: r'WALLET')
  static const InitiatePaymentDtoMethodEnum WALLET = _$initiatePaymentDtoMethodEnum_WALLET;

  static Serializer<InitiatePaymentDtoMethodEnum> get serializer => _$initiatePaymentDtoMethodEnumSerializer;

  const InitiatePaymentDtoMethodEnum._(String name): super(name);

  static BuiltSet<InitiatePaymentDtoMethodEnum> get values => _$initiatePaymentDtoMethodEnumValues;
  static InitiatePaymentDtoMethodEnum valueOf(String name) => _$initiatePaymentDtoMethodEnumValueOf(name);
}

