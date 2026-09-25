//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'calculate_fare_dto.g.dart';

/// CalculateFareDto
///
/// Properties:
/// * [vehicleTypeId] - Vehicle Type ID (UUID)
/// * [distanceKm] - Distance in kilometers
/// * [durationMin] - Duration in minutes
/// * [city] - City name
/// * [couponCode] - Optional coupon code
@BuiltValue()
abstract class CalculateFareDto implements Built<CalculateFareDto, CalculateFareDtoBuilder> {
  /// Vehicle Type ID (UUID)
  @BuiltValueField(wireName: r'vehicleTypeId')
  String get vehicleTypeId;

  /// Distance in kilometers
  @BuiltValueField(wireName: r'distanceKm')
  num get distanceKm;

  /// Duration in minutes
  @BuiltValueField(wireName: r'durationMin')
  num get durationMin;

  /// City name
  @BuiltValueField(wireName: r'city')
  String? get city;

  /// Optional coupon code
  @BuiltValueField(wireName: r'couponCode')
  String? get couponCode;

  CalculateFareDto._();

  factory CalculateFareDto([void updates(CalculateFareDtoBuilder b)]) = _$CalculateFareDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CalculateFareDtoBuilder b) => b
      ..city = 'default';

  @BuiltValueSerializer(custom: true)
  static Serializer<CalculateFareDto> get serializer => _$CalculateFareDtoSerializer();
}

class _$CalculateFareDtoSerializer implements PrimitiveSerializer<CalculateFareDto> {
  @override
  final Iterable<Type> types = const [CalculateFareDto, _$CalculateFareDto];

  @override
  final String wireName = r'CalculateFareDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CalculateFareDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'vehicleTypeId';
    yield serializers.serialize(
      object.vehicleTypeId,
      specifiedType: const FullType(String),
    );
    yield r'distanceKm';
    yield serializers.serialize(
      object.distanceKm,
      specifiedType: const FullType(num),
    );
    yield r'durationMin';
    yield serializers.serialize(
      object.durationMin,
      specifiedType: const FullType(num),
    );
    if (object.city != null) {
      yield r'city';
      yield serializers.serialize(
        object.city,
        specifiedType: const FullType(String),
      );
    }
    if (object.couponCode != null) {
      yield r'couponCode';
      yield serializers.serialize(
        object.couponCode,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CalculateFareDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CalculateFareDtoBuilder result,
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
        case r'distanceKm':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.distanceKm = valueDes;
          break;
        case r'durationMin':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.durationMin = valueDes;
          break;
        case r'city':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.city = valueDes;
          break;
        case r'couponCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.couponCode = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CalculateFareDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CalculateFareDtoBuilder();
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


