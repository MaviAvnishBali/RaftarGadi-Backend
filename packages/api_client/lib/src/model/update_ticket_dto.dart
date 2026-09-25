//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_ticket_dto.g.dart';

/// UpdateTicketDto
///
/// Properties:
/// * [status] 
/// * [assignedTo] 
@BuiltValue()
abstract class UpdateTicketDto implements Built<UpdateTicketDto, UpdateTicketDtoBuilder> {
  @BuiltValueField(wireName: r'status')
  UpdateTicketDtoStatusEnum get status;
  // enum statusEnum {  OPEN,  IN_PROGRESS,  RESOLVED,  CLOSED,  };

  @BuiltValueField(wireName: r'assignedTo')
  String? get assignedTo;

  UpdateTicketDto._();

  factory UpdateTicketDto([void updates(UpdateTicketDtoBuilder b)]) = _$UpdateTicketDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateTicketDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateTicketDto> get serializer => _$UpdateTicketDtoSerializer();
}

class _$UpdateTicketDtoSerializer implements PrimitiveSerializer<UpdateTicketDto> {
  @override
  final Iterable<Type> types = const [UpdateTicketDto, _$UpdateTicketDto];

  @override
  final String wireName = r'UpdateTicketDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateTicketDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(UpdateTicketDtoStatusEnum),
    );
    if (object.assignedTo != null) {
      yield r'assignedTo';
      yield serializers.serialize(
        object.assignedTo,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateTicketDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateTicketDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UpdateTicketDtoStatusEnum),
          ) as UpdateTicketDtoStatusEnum;
          result.status = valueDes;
          break;
        case r'assignedTo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.assignedTo = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateTicketDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateTicketDtoBuilder();
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


class UpdateTicketDtoStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'OPEN')
  static const UpdateTicketDtoStatusEnum OPEN = _$updateTicketDtoStatusEnum_OPEN;
  @BuiltValueEnumConst(wireName: r'IN_PROGRESS')
  static const UpdateTicketDtoStatusEnum IN_PROGRESS = _$updateTicketDtoStatusEnum_IN_PROGRESS;
  @BuiltValueEnumConst(wireName: r'RESOLVED')
  static const UpdateTicketDtoStatusEnum RESOLVED = _$updateTicketDtoStatusEnum_RESOLVED;
  @BuiltValueEnumConst(wireName: r'CLOSED')
  static const UpdateTicketDtoStatusEnum CLOSED = _$updateTicketDtoStatusEnum_CLOSED;

  static Serializer<UpdateTicketDtoStatusEnum> get serializer => _$updateTicketDtoStatusEnumSerializer;

  const UpdateTicketDtoStatusEnum._(String name): super(name);

  static BuiltSet<UpdateTicketDtoStatusEnum> get values => _$updateTicketDtoStatusEnumValues;
  static UpdateTicketDtoStatusEnum valueOf(String name) => _$updateTicketDtoStatusEnumValueOf(name);
}

