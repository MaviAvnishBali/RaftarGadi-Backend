//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'health_controller_check200_response_info_value.g.dart';

/// HealthControllerCheck200ResponseInfoValue
///
/// Properties:
/// * [status] 
@BuiltValue()
abstract class HealthControllerCheck200ResponseInfoValue implements Built<HealthControllerCheck200ResponseInfoValue, HealthControllerCheck200ResponseInfoValueBuilder> {
  @BuiltValueField(wireName: r'status')
  String get status;

  HealthControllerCheck200ResponseInfoValue._();

  factory HealthControllerCheck200ResponseInfoValue([void updates(HealthControllerCheck200ResponseInfoValueBuilder b)]) = _$HealthControllerCheck200ResponseInfoValue;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HealthControllerCheck200ResponseInfoValueBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HealthControllerCheck200ResponseInfoValue> get serializer => _$HealthControllerCheck200ResponseInfoValueSerializer();
}

class _$HealthControllerCheck200ResponseInfoValueSerializer implements PrimitiveSerializer<HealthControllerCheck200ResponseInfoValue> {
  @override
  final Iterable<Type> types = const [HealthControllerCheck200ResponseInfoValue, _$HealthControllerCheck200ResponseInfoValue];

  @override
  final String wireName = r'HealthControllerCheck200ResponseInfoValue';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HealthControllerCheck200ResponseInfoValue object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HealthControllerCheck200ResponseInfoValue object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HealthControllerCheck200ResponseInfoValueBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HealthControllerCheck200ResponseInfoValue deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HealthControllerCheck200ResponseInfoValueBuilder();
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


