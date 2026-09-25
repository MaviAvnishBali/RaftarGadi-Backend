//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'send_notification_dto.g.dart';

/// SendNotificationDto
///
/// Properties:
/// * [userId] 
/// * [title] 
/// * [body] 
/// * [channel] 
/// * [metadata] 
@BuiltValue()
abstract class SendNotificationDto implements Built<SendNotificationDto, SendNotificationDtoBuilder> {
  @BuiltValueField(wireName: r'userId')
  String get userId;

  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'body')
  String get body;

  @BuiltValueField(wireName: r'channel')
  SendNotificationDtoChannelEnum get channel;
  // enum channelEnum {  PUSH,  SMS,  EMAIL,  };

  @BuiltValueField(wireName: r'metadata')
  JsonObject? get metadata;

  SendNotificationDto._();

  factory SendNotificationDto([void updates(SendNotificationDtoBuilder b)]) = _$SendNotificationDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SendNotificationDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SendNotificationDto> get serializer => _$SendNotificationDtoSerializer();
}

class _$SendNotificationDtoSerializer implements PrimitiveSerializer<SendNotificationDto> {
  @override
  final Iterable<Type> types = const [SendNotificationDto, _$SendNotificationDto];

  @override
  final String wireName = r'SendNotificationDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SendNotificationDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'userId';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(String),
    );
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    yield r'body';
    yield serializers.serialize(
      object.body,
      specifiedType: const FullType(String),
    );
    yield r'channel';
    yield serializers.serialize(
      object.channel,
      specifiedType: const FullType(SendNotificationDtoChannelEnum),
    );
    if (object.metadata != null) {
      yield r'metadata';
      yield serializers.serialize(
        object.metadata,
        specifiedType: const FullType(JsonObject),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SendNotificationDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SendNotificationDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userId = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'body':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.body = valueDes;
          break;
        case r'channel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SendNotificationDtoChannelEnum),
          ) as SendNotificationDtoChannelEnum;
          result.channel = valueDes;
          break;
        case r'metadata':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.metadata = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SendNotificationDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SendNotificationDtoBuilder();
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


class SendNotificationDtoChannelEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PUSH')
  static const SendNotificationDtoChannelEnum PUSH = _$sendNotificationDtoChannelEnum_PUSH;
  @BuiltValueEnumConst(wireName: r'SMS')
  static const SendNotificationDtoChannelEnum SMS = _$sendNotificationDtoChannelEnum_SMS;
  @BuiltValueEnumConst(wireName: r'EMAIL')
  static const SendNotificationDtoChannelEnum EMAIL = _$sendNotificationDtoChannelEnum_EMAIL;

  static Serializer<SendNotificationDtoChannelEnum> get serializer => _$sendNotificationDtoChannelEnumSerializer;

  const SendNotificationDtoChannelEnum._(String name): super(name);

  static BuiltSet<SendNotificationDtoChannelEnum> get values => _$sendNotificationDtoChannelEnumValues;
  static SendNotificationDtoChannelEnum valueOf(String name) => _$sendNotificationDtoChannelEnumValueOf(name);
}

