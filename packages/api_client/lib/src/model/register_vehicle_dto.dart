//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'register_vehicle_dto.g.dart';

/// RegisterVehicleDto
///
/// Properties:
/// * [vehicleTypeId] 
/// * [registrationNumber] 
/// * [model] 
/// * [color] 
/// * [manufactureYear] 
@BuiltValue()
abstract class RegisterVehicleDto implements Built<RegisterVehicleDto, RegisterVehicleDtoBuilder> {
  @BuiltValueField(wireName: r'vehicleTypeId')
  String get vehicleTypeId;

  @BuiltValueField(wireName: r'registrationNumber')
  String get registrationNumber;

  @BuiltValueField(wireName: r'model')
  String? get model;

  @BuiltValueField(wireName: r'color')
  String? get color;

  @BuiltValueField(wireName: r'manufactureYear')
  num? get manufactureYear;

  RegisterVehicleDto._();

  factory RegisterVehicleDto([void updates(RegisterVehicleDtoBuilder b)]) = _$RegisterVehicleDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RegisterVehicleDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RegisterVehicleDto> get serializer => _$RegisterVehicleDtoSerializer();
}

class _$RegisterVehicleDtoSerializer implements PrimitiveSerializer<RegisterVehicleDto> {
  @override
  final Iterable<Type> types = const [RegisterVehicleDto, _$RegisterVehicleDto];

  @override
  final String wireName = r'RegisterVehicleDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RegisterVehicleDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'vehicleTypeId';
    yield serializers.serialize(
      object.vehicleTypeId,
      specifiedType: const FullType(String),
    );
    yield r'registrationNumber';
    yield serializers.serialize(
      object.registrationNumber,
      specifiedType: const FullType(String),
    );
    if (object.model != null) {
      yield r'model';
      yield serializers.serialize(
        object.model,
        specifiedType: const FullType(String),
      );
    }
    if (object.color != null) {
      yield r'color';
      yield serializers.serialize(
        object.color,
        specifiedType: const FullType(String),
      );
    }
    if (object.manufactureYear != null) {
      yield r'manufactureYear';
      yield serializers.serialize(
        object.manufactureYear,
        specifiedType: const FullType(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    RegisterVehicleDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RegisterVehicleDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'vehicleTypeId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.vehicleTypeId = valueDes;
          break;
        case r'registrationNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.registrationNumber = valueDes;
          break;
        case r'model':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.model = valueDes;
          break;
        case r'color':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.color = valueDes;
          break;
        case r'manufactureYear':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.manufactureYear = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RegisterVehicleDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RegisterVehicleDtoBuilder();
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


