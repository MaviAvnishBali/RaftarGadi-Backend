//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_coupon_dto.g.dart';

/// CreateCouponDto
///
/// Properties:
/// * [code] 
/// * [description] 
/// * [discountType] 
/// * [discountValue] 
/// * [maxDiscount] 
/// * [minBookingAmount] 
/// * [maxUses] 
/// * [validFrom] 
/// * [validTo] 
@BuiltValue()
abstract class CreateCouponDto implements Built<CreateCouponDto, CreateCouponDtoBuilder> {
  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'discountType')
  CreateCouponDtoDiscountTypeEnum get discountType;
  // enum discountTypeEnum {  PERCENTAGE,  FLAT,  };

  @BuiltValueField(wireName: r'discountValue')
  num get discountValue;

  @BuiltValueField(wireName: r'maxDiscount')
  num? get maxDiscount;

  @BuiltValueField(wireName: r'minBookingAmount')
  num? get minBookingAmount;

  @BuiltValueField(wireName: r'maxUses')
  num? get maxUses;

  @BuiltValueField(wireName: r'validFrom')
  DateTime get validFrom;

  @BuiltValueField(wireName: r'validTo')
  DateTime get validTo;

  CreateCouponDto._();

  factory CreateCouponDto([void updates(CreateCouponDtoBuilder b)]) = _$CreateCouponDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateCouponDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateCouponDto> get serializer => _$CreateCouponDtoSerializer();
}

class _$CreateCouponDtoSerializer implements PrimitiveSerializer<CreateCouponDto> {
  @override
  final Iterable<Type> types = const [CreateCouponDto, _$CreateCouponDto];

  @override
  final String wireName = r'CreateCouponDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateCouponDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
    yield r'discountType';
    yield serializers.serialize(
      object.discountType,
      specifiedType: const FullType(CreateCouponDtoDiscountTypeEnum),
    );
    yield r'discountValue';
    yield serializers.serialize(
      object.discountValue,
      specifiedType: const FullType(num),
    );
    if (object.maxDiscount != null) {
      yield r'maxDiscount';
      yield serializers.serialize(
        object.maxDiscount,
        specifiedType: const FullType(num),
      );
    }
    if (object.minBookingAmount != null) {
      yield r'minBookingAmount';
      yield serializers.serialize(
        object.minBookingAmount,
        specifiedType: const FullType(num),
      );
    }
    if (object.maxUses != null) {
      yield r'maxUses';
      yield serializers.serialize(
        object.maxUses,
        specifiedType: const FullType(num),
      );
    }
    yield r'validFrom';
    yield serializers.serialize(
      object.validFrom,
      specifiedType: const FullType(DateTime),
    );
    yield r'validTo';
    yield serializers.serialize(
      object.validTo,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateCouponDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateCouponDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.description = valueDes;
          break;
        case r'discountType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreateCouponDtoDiscountTypeEnum),
          ) as CreateCouponDtoDiscountTypeEnum;
          result.discountType = valueDes;
          break;
        case r'discountValue':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.discountValue = valueDes;
          break;
        case r'maxDiscount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.maxDiscount = valueDes;
          break;
        case r'minBookingAmount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.minBookingAmount = valueDes;
          break;
        case r'maxUses':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.maxUses = valueDes;
          break;
        case r'validFrom':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.validFrom = valueDes;
          break;
        case r'validTo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.validTo = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateCouponDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateCouponDtoBuilder();
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


class CreateCouponDtoDiscountTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PERCENTAGE')
  static const CreateCouponDtoDiscountTypeEnum PERCENTAGE = _$createCouponDtoDiscountTypeEnum_PERCENTAGE;
  @BuiltValueEnumConst(wireName: r'FLAT')
  static const CreateCouponDtoDiscountTypeEnum FLAT = _$createCouponDtoDiscountTypeEnum_FLAT;

  static Serializer<CreateCouponDtoDiscountTypeEnum> get serializer => _$createCouponDtoDiscountTypeEnumSerializer;

  const CreateCouponDtoDiscountTypeEnum._(String name): super(name);

  static BuiltSet<CreateCouponDtoDiscountTypeEnum> get values => _$createCouponDtoDiscountTypeEnumValues;
  static CreateCouponDtoDiscountTypeEnum valueOf(String name) => _$createCouponDtoDiscountTypeEnumValueOf(name);
}

