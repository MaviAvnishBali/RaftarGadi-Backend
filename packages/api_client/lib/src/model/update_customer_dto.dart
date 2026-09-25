//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_customer_dto.g.dart';

/// UpdateCustomerDto
///
/// Properties:
/// * [address] 
/// * [savedLat] 
/// * [savedLng] 
@BuiltValue()
abstract class UpdateCustomerDto implements Built<UpdateCustomerDto, UpdateCustomerDtoBuilder> {
  @BuiltValueField(wireName: r'address')
  String? get address;

  @BuiltValueField(wireName: r'savedLat')
  num? get savedLat;

  @BuiltValueField(wireName: r'savedLng')
  num? get savedLng;

  UpdateCustomerDto._();

  factory UpdateCustomerDto([void updates(UpdateCustomerDtoBuilder b)]) = _$UpdateCustomerDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateCustomerDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateCustomerDto> get serializer => _$UpdateCustomerDtoSerializer();
}

class _$UpdateCustomerDtoSerializer implements PrimitiveSerializer<UpdateCustomerDto> {
  @override
  final Iterable<Type> types = const [UpdateCustomerDto, _$UpdateCustomerDto];

  @override
  final String wireName = r'UpdateCustomerDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateCustomerDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.address != null) {
      yield r'address';
      yield serializers.serialize(
        object.address,
        specifiedType: const FullType(String),
      );
    }
    if (object.savedLat != null) {
      yield r'savedLat';
      yield serializers.serialize(
        object.savedLat,
        specifiedType: const FullType(num),
      );
    }
    if (object.savedLng != null) {
      yield r'savedLng';
      yield serializers.serialize(
        object.savedLng,
        specifiedType: const FullType(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateCustomerDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateCustomerDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.address = valueDes;
          break;
        case r'savedLat':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.savedLat = valueDes;
          break;
        case r'savedLng':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.savedLng = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateCustomerDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateCustomerDtoBuilder();
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


