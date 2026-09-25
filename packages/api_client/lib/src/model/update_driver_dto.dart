//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_driver_dto.g.dart';

/// UpdateDriverDto
///
/// Properties:
/// * [licenseNumber] 
@BuiltValue()
abstract class UpdateDriverDto implements Built<UpdateDriverDto, UpdateDriverDtoBuilder> {
  @BuiltValueField(wireName: r'licenseNumber')
  String? get licenseNumber;

  UpdateDriverDto._();

  factory UpdateDriverDto([void updates(UpdateDriverDtoBuilder b)]) = _$UpdateDriverDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateDriverDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateDriverDto> get serializer => _$UpdateDriverDtoSerializer();
}

class _$UpdateDriverDtoSerializer implements PrimitiveSerializer<UpdateDriverDto> {
  @override
  final Iterable<Type> types = const [UpdateDriverDto, _$UpdateDriverDto];

  @override
  final String wireName = r'UpdateDriverDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateDriverDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.licenseNumber != null) {
      yield r'licenseNumber';
      yield serializers.serialize(
        object.licenseNumber,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateDriverDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateDriverDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'licenseNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.licenseNumber = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateDriverDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateDriverDtoBuilder();
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


