//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/health_controller_check200_response_info_value.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'health_controller_check503_response.g.dart';

/// HealthControllerCheck503Response
///
/// Properties:
/// * [status] 
/// * [info] 
/// * [error] 
/// * [details] 
@BuiltValue()
abstract class HealthControllerCheck503Response implements Built<HealthControllerCheck503Response, HealthControllerCheck503ResponseBuilder> {
  @BuiltValueField(wireName: r'status')
  String? get status;

  @BuiltValueField(wireName: r'info')
  BuiltMap<String, HealthControllerCheck200ResponseInfoValue>? get info;

  @BuiltValueField(wireName: r'error')
  BuiltMap<String, HealthControllerCheck200ResponseInfoValue>? get error;

  @BuiltValueField(wireName: r'details')
  BuiltMap<String, HealthControllerCheck200ResponseInfoValue>? get details;

  HealthControllerCheck503Response._();

  factory HealthControllerCheck503Response([void updates(HealthControllerCheck503ResponseBuilder b)]) = _$HealthControllerCheck503Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HealthControllerCheck503ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HealthControllerCheck503Response> get serializer => _$HealthControllerCheck503ResponseSerializer();
}

class _$HealthControllerCheck503ResponseSerializer implements PrimitiveSerializer<HealthControllerCheck503Response> {
  @override
  final Iterable<Type> types = const [HealthControllerCheck503Response, _$HealthControllerCheck503Response];

  @override
  final String wireName = r'HealthControllerCheck503Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HealthControllerCheck503Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(String),
      );
    }
    if (object.info != null) {
      yield r'info';
      yield serializers.serialize(
        object.info,
        specifiedType: const FullType.nullable(BuiltMap, [FullType(String), FullType(HealthControllerCheck200ResponseInfoValue)]),
      );
    }
    if (object.error != null) {
      yield r'error';
      yield serializers.serialize(
        object.error,
        specifiedType: const FullType.nullable(BuiltMap, [FullType(String), FullType(HealthControllerCheck200ResponseInfoValue)]),
      );
    }
    if (object.details != null) {
      yield r'details';
      yield serializers.serialize(
        object.details,
        specifiedType: const FullType(BuiltMap, [FullType(String), FullType(HealthControllerCheck200ResponseInfoValue)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HealthControllerCheck503Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HealthControllerCheck503ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'info':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltMap, [FullType(String), FullType(HealthControllerCheck200ResponseInfoValue)]),
          ) as BuiltMap<String, HealthControllerCheck200ResponseInfoValue>?;
          if (valueDes == null) continue;
          result.info.replace(valueDes);
          break;
        case r'error':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltMap, [FullType(String), FullType(HealthControllerCheck200ResponseInfoValue)]),
          ) as BuiltMap<String, HealthControllerCheck200ResponseInfoValue>?;
          if (valueDes == null) continue;
          result.error.replace(valueDes);
          break;
        case r'details':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltMap, [FullType(String), FullType(HealthControllerCheck200ResponseInfoValue)]),
          ) as BuiltMap<String, HealthControllerCheck200ResponseInfoValue>?;
          if (valueDes == null) continue;
          result.details.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HealthControllerCheck503Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HealthControllerCheck503ResponseBuilder();
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


