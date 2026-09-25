//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'cancel_booking_dto.g.dart';

/// CancelBookingDto
///
/// Properties:
/// * [reason] - Reason for cancellation
@BuiltValue()
abstract class CancelBookingDto implements Built<CancelBookingDto, CancelBookingDtoBuilder> {
  /// Reason for cancellation
  @BuiltValueField(wireName: r'reason')
  String? get reason;

  CancelBookingDto._();

  factory CancelBookingDto([void updates(CancelBookingDtoBuilder b)]) = _$CancelBookingDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CancelBookingDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CancelBookingDto> get serializer => _$CancelBookingDtoSerializer();
}

class _$CancelBookingDtoSerializer implements PrimitiveSerializer<CancelBookingDto> {
  @override
  final Iterable<Type> types = const [CancelBookingDto, _$CancelBookingDto];

  @override
  final String wireName = r'CancelBookingDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CancelBookingDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.reason != null) {
      yield r'reason';
      yield serializers.serialize(
        object.reason,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CancelBookingDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CancelBookingDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CancelBookingDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CancelBookingDtoBuilder();
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


