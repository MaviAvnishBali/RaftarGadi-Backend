//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_ticket_dto.g.dart';

/// CreateTicketDto
///
/// Properties:
/// * [bookingId] 
/// * [subject] 
/// * [description] 
/// * [priority] 
@BuiltValue()
abstract class CreateTicketDto implements Built<CreateTicketDto, CreateTicketDtoBuilder> {
  @BuiltValueField(wireName: r'bookingId')
  String? get bookingId;

  @BuiltValueField(wireName: r'subject')
  String get subject;

  @BuiltValueField(wireName: r'description')
  String get description;

  @BuiltValueField(wireName: r'priority')
  CreateTicketDtoPriorityEnum? get priority;
  // enum priorityEnum {  LOW,  MEDIUM,  HIGH,  URGENT,  };

  CreateTicketDto._();

  factory CreateTicketDto([void updates(CreateTicketDtoBuilder b)]) = _$CreateTicketDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateTicketDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateTicketDto> get serializer => _$CreateTicketDtoSerializer();
}

class _$CreateTicketDtoSerializer implements PrimitiveSerializer<CreateTicketDto> {
  @override
  final Iterable<Type> types = const [CreateTicketDto, _$CreateTicketDto];

  @override
  final String wireName = r'CreateTicketDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateTicketDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.bookingId != null) {
      yield r'bookingId';
      yield serializers.serialize(
        object.bookingId,
        specifiedType: const FullType(String),
      );
    }
    yield r'subject';
    yield serializers.serialize(
      object.subject,
      specifiedType: const FullType(String),
    );
    yield r'description';
    yield serializers.serialize(
      object.description,
      specifiedType: const FullType(String),
    );
    if (object.priority != null) {
      yield r'priority';
      yield serializers.serialize(
        object.priority,
        specifiedType: const FullType(CreateTicketDtoPriorityEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateTicketDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateTicketDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'bookingId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.bookingId = valueDes;
          break;
        case r'subject':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.subject = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'priority':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(CreateTicketDtoPriorityEnum),
          ) as CreateTicketDtoPriorityEnum?;
          if (valueDes == null) continue;
          result.priority = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateTicketDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateTicketDtoBuilder();
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


class CreateTicketDtoPriorityEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'LOW')
  static const CreateTicketDtoPriorityEnum LOW = _$createTicketDtoPriorityEnum_LOW;
  @BuiltValueEnumConst(wireName: r'MEDIUM')
  static const CreateTicketDtoPriorityEnum MEDIUM = _$createTicketDtoPriorityEnum_MEDIUM;
  @BuiltValueEnumConst(wireName: r'HIGH')
  static const CreateTicketDtoPriorityEnum HIGH = _$createTicketDtoPriorityEnum_HIGH;
  @BuiltValueEnumConst(wireName: r'URGENT')
  static const CreateTicketDtoPriorityEnum URGENT = _$createTicketDtoPriorityEnum_URGENT;

  static Serializer<CreateTicketDtoPriorityEnum> get serializer => _$createTicketDtoPriorityEnumSerializer;

  const CreateTicketDtoPriorityEnum._(String name): super(name);

  static BuiltSet<CreateTicketDtoPriorityEnum> get values => _$createTicketDtoPriorityEnumValues;
  static CreateTicketDtoPriorityEnum valueOf(String name) => _$createTicketDtoPriorityEnumValueOf(name);
}

