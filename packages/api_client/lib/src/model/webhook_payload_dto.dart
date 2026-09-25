//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'webhook_payload_dto.g.dart';

/// WebhookPayloadDto
///
/// Properties:
/// * [orderId] 
/// * [status] 
/// * [transactionId] 
/// * [signature] 
@BuiltValue()
abstract class WebhookPayloadDto implements Built<WebhookPayloadDto, WebhookPayloadDtoBuilder> {
  @BuiltValueField(wireName: r'orderId')
  String get orderId;

  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'transactionId')
  String get transactionId;

  @BuiltValueField(wireName: r'signature')
  String get signature;

  WebhookPayloadDto._();

  factory WebhookPayloadDto([void updates(WebhookPayloadDtoBuilder b)]) = _$WebhookPayloadDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WebhookPayloadDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WebhookPayloadDto> get serializer => _$WebhookPayloadDtoSerializer();
}

class _$WebhookPayloadDtoSerializer implements PrimitiveSerializer<WebhookPayloadDto> {
  @override
  final Iterable<Type> types = const [WebhookPayloadDto, _$WebhookPayloadDto];

  @override
  final String wireName = r'WebhookPayloadDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WebhookPayloadDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'orderId';
    yield serializers.serialize(
      object.orderId,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(String),
    );
    yield r'transactionId';
    yield serializers.serialize(
      object.transactionId,
      specifiedType: const FullType(String),
    );
    yield r'signature';
    yield serializers.serialize(
      object.signature,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    WebhookPayloadDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WebhookPayloadDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'orderId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.orderId = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'transactionId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.transactionId = valueDes;
          break;
        case r'signature':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.signature = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WebhookPayloadDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WebhookPayloadDtoBuilder();
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


