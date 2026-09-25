//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_pricing_rule_dto.g.dart';

/// CreatePricingRuleDto
///
/// Properties:
/// * [vehicleTypeId] 
/// * [city] 
/// * [baseFare] 
/// * [perKmCharge] 
/// * [perMinCharge] 
/// * [minimumFare] 
/// * [platformFeePercent] 
/// * [taxPercent] 
/// * [surgeMultiplier] 
/// * [effectiveFrom] 
/// * [effectiveTo] 
@BuiltValue()
abstract class CreatePricingRuleDto implements Built<CreatePricingRuleDto, CreatePricingRuleDtoBuilder> {
  @BuiltValueField(wireName: r'vehicleTypeId')
  String get vehicleTypeId;

  @BuiltValueField(wireName: r'city')
  String? get city;

  @BuiltValueField(wireName: r'baseFare')
  num get baseFare;

  @BuiltValueField(wireName: r'perKmCharge')
  num get perKmCharge;

  @BuiltValueField(wireName: r'perMinCharge')
  num get perMinCharge;

  @BuiltValueField(wireName: r'minimumFare')
  num get minimumFare;

  @BuiltValueField(wireName: r'platformFeePercent')
  num get platformFeePercent;

  @BuiltValueField(wireName: r'taxPercent')
  num get taxPercent;

  @BuiltValueField(wireName: r'surgeMultiplier')
  num? get surgeMultiplier;

  @BuiltValueField(wireName: r'effectiveFrom')
  DateTime get effectiveFrom;

  @BuiltValueField(wireName: r'effectiveTo')
  DateTime? get effectiveTo;

  CreatePricingRuleDto._();

  factory CreatePricingRuleDto([void updates(CreatePricingRuleDtoBuilder b)]) = _$CreatePricingRuleDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreatePricingRuleDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreatePricingRuleDto> get serializer => _$CreatePricingRuleDtoSerializer();
}

class _$CreatePricingRuleDtoSerializer implements PrimitiveSerializer<CreatePricingRuleDto> {
  @override
  final Iterable<Type> types = const [CreatePricingRuleDto, _$CreatePricingRuleDto];

  @override
  final String wireName = r'CreatePricingRuleDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreatePricingRuleDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'vehicleTypeId';
    yield serializers.serialize(
      object.vehicleTypeId,
      specifiedType: const FullType(String),
    );
    if (object.city != null) {
      yield r'city';
      yield serializers.serialize(
        object.city,
        specifiedType: const FullType(String),
      );
    }
    yield r'baseFare';
    yield serializers.serialize(
      object.baseFare,
      specifiedType: const FullType(num),
    );
    yield r'perKmCharge';
    yield serializers.serialize(
      object.perKmCharge,
      specifiedType: const FullType(num),
    );
    yield r'perMinCharge';
    yield serializers.serialize(
      object.perMinCharge,
      specifiedType: const FullType(num),
    );
    yield r'minimumFare';
    yield serializers.serialize(
      object.minimumFare,
      specifiedType: const FullType(num),
    );
    yield r'platformFeePercent';
    yield serializers.serialize(
      object.platformFeePercent,
      specifiedType: const FullType(num),
    );
    yield r'taxPercent';
    yield serializers.serialize(
      object.taxPercent,
      specifiedType: const FullType(num),
    );
    if (object.surgeMultiplier != null) {
      yield r'surgeMultiplier';
      yield serializers.serialize(
        object.surgeMultiplier,
        specifiedType: const FullType(num),
      );
    }
    yield r'effectiveFrom';
    yield serializers.serialize(
      object.effectiveFrom,
      specifiedType: const FullType(DateTime),
    );
    if (object.effectiveTo != null) {
      yield r'effectiveTo';
      yield serializers.serialize(
        object.effectiveTo,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreatePricingRuleDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreatePricingRuleDtoBuilder result,
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
        case r'city':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.city = valueDes;
          break;
        case r'baseFare':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.baseFare = valueDes;
          break;
        case r'perKmCharge':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.perKmCharge = valueDes;
          break;
        case r'perMinCharge':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.perMinCharge = valueDes;
          break;
        case r'minimumFare':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.minimumFare = valueDes;
          break;
        case r'platformFeePercent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.platformFeePercent = valueDes;
          break;
        case r'taxPercent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.taxPercent = valueDes;
          break;
        case r'surgeMultiplier':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.surgeMultiplier = valueDes;
          break;
        case r'effectiveFrom':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.effectiveFrom = valueDes;
          break;
        case r'effectiveTo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.effectiveTo = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreatePricingRuleDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreatePricingRuleDtoBuilder();
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


