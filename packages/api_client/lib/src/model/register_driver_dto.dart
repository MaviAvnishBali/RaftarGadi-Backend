//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'register_driver_dto.g.dart';

/// RegisterDriverDto
///
/// Properties:
/// * [licenseNumber] 
@BuiltValue()
abstract class RegisterDriverDto implements Built<RegisterDriverDto, RegisterDriverDtoBuilder> {
  @BuiltValueField(wireName: r'licenseNumber')
  String get licenseNumber;

  RegisterDriverDto._();

  factory RegisterDriverDto([void updates(RegisterDriverDtoBuilder b)]) = _$RegisterDriverDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RegisterDriverDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RegisterDriverDto> get serializer => _$RegisterDriverDtoSerializer();
}

class _$RegisterDriverDtoSerializer implements PrimitiveSerializer<RegisterDriverDto> {
  @override
  final Iterable<Type> types = const [RegisterDriverDto, _$RegisterDriverDto];

  @override
  final String wireName = r'RegisterDriverDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RegisterDriverDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'licenseNumber';
    yield serializers.serialize(
      object.licenseNumber,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RegisterDriverDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RegisterDriverDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'licenseNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
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
  RegisterDriverDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RegisterDriverDtoBuilder();
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


