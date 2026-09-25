//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'complete_trip_dto.g.dart';

/// CompleteTripDto
///
/// Properties:
/// * [actualDistanceKm] - Actual distance covered in km
/// * [actualDurationMin] - Actual duration taken in minutes
@BuiltValue()
abstract class CompleteTripDto implements Built<CompleteTripDto, CompleteTripDtoBuilder> {
  /// Actual distance covered in km
  @BuiltValueField(wireName: r'actualDistanceKm')
  num get actualDistanceKm;

  /// Actual duration taken in minutes
  @BuiltValueField(wireName: r'actualDurationMin')
  num get actualDurationMin;

  CompleteTripDto._();

  factory CompleteTripDto([void updates(CompleteTripDtoBuilder b)]) = _$CompleteTripDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CompleteTripDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CompleteTripDto> get serializer => _$CompleteTripDtoSerializer();
}

class _$CompleteTripDtoSerializer implements PrimitiveSerializer<CompleteTripDto> {
  @override
  final Iterable<Type> types = const [CompleteTripDto, _$CompleteTripDto];

  @override
  final String wireName = r'CompleteTripDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CompleteTripDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'actualDistanceKm';
    yield serializers.serialize(
      object.actualDistanceKm,
      specifiedType: const FullType(num),
    );
    yield r'actualDurationMin';
    yield serializers.serialize(
      object.actualDurationMin,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CompleteTripDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CompleteTripDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'actualDistanceKm':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.actualDistanceKm = valueDes;
          break;
        case r'actualDurationMin':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.actualDurationMin = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CompleteTripDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CompleteTripDtoBuilder();
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


