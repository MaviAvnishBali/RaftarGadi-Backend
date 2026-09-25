// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_coupon_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UpdateCouponDtoDiscountTypeEnum
_$updateCouponDtoDiscountTypeEnum_PERCENTAGE =
    const UpdateCouponDtoDiscountTypeEnum._('PERCENTAGE');
const UpdateCouponDtoDiscountTypeEnum _$updateCouponDtoDiscountTypeEnum_FLAT =
    const UpdateCouponDtoDiscountTypeEnum._('FLAT');

UpdateCouponDtoDiscountTypeEnum _$updateCouponDtoDiscountTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'PERCENTAGE':
      return _$updateCouponDtoDiscountTypeEnum_PERCENTAGE;
    case 'FLAT':
      return _$updateCouponDtoDiscountTypeEnum_FLAT;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UpdateCouponDtoDiscountTypeEnum>
_$updateCouponDtoDiscountTypeEnumValues =
    BuiltSet<UpdateCouponDtoDiscountTypeEnum>(
      const <UpdateCouponDtoDiscountTypeEnum>[
        _$updateCouponDtoDiscountTypeEnum_PERCENTAGE,
        _$updateCouponDtoDiscountTypeEnum_FLAT,
      ],
    );

Serializer<UpdateCouponDtoDiscountTypeEnum>
_$updateCouponDtoDiscountTypeEnumSerializer =
    _$UpdateCouponDtoDiscountTypeEnumSerializer();

class _$UpdateCouponDtoDiscountTypeEnumSerializer
    implements PrimitiveSerializer<UpdateCouponDtoDiscountTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PERCENTAGE': 'PERCENTAGE',
    'FLAT': 'FLAT',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PERCENTAGE': 'PERCENTAGE',
    'FLAT': 'FLAT',
  };

  @override
  final Iterable<Type> types = const <Type>[UpdateCouponDtoDiscountTypeEnum];
  @override
  final String wireName = 'UpdateCouponDtoDiscountTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    UpdateCouponDtoDiscountTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  UpdateCouponDtoDiscountTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => UpdateCouponDtoDiscountTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$UpdateCouponDto extends UpdateCouponDto {
  @override
  final String? code;
  @override
  final String? description;
  @override
  final UpdateCouponDtoDiscountTypeEnum? discountType;
  @override
  final num? discountValue;
  @override
  final num? maxDiscount;
  @override
  final num? minBookingAmount;
  @override
  final num? maxUses;
  @override
  final DateTime? validFrom;
  @override
  final DateTime? validTo;

  factory _$UpdateCouponDto([void Function(UpdateCouponDtoBuilder)? updates]) =>
      (UpdateCouponDtoBuilder()..update(updates))._build();

  _$UpdateCouponDto._({
    this.code,
    this.description,
    this.discountType,
    this.discountValue,
    this.maxDiscount,
    this.minBookingAmount,
    this.maxUses,
    this.validFrom,
    this.validTo,
  }) : super._();
  @override
  UpdateCouponDto rebuild(void Function(UpdateCouponDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateCouponDtoBuilder toBuilder() => UpdateCouponDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateCouponDto &&
        code == other.code &&
        description == other.description &&
        discountType == other.discountType &&
        discountValue == other.discountValue &&
        maxDiscount == other.maxDiscount &&
        minBookingAmount == other.minBookingAmount &&
        maxUses == other.maxUses &&
        validFrom == other.validFrom &&
        validTo == other.validTo;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, discountType.hashCode);
    _$hash = $jc(_$hash, discountValue.hashCode);
    _$hash = $jc(_$hash, maxDiscount.hashCode);
    _$hash = $jc(_$hash, minBookingAmount.hashCode);
    _$hash = $jc(_$hash, maxUses.hashCode);
    _$hash = $jc(_$hash, validFrom.hashCode);
    _$hash = $jc(_$hash, validTo.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateCouponDto')
          ..add('code', code)
          ..add('description', description)
          ..add('discountType', discountType)
          ..add('discountValue', discountValue)
          ..add('maxDiscount', maxDiscount)
          ..add('minBookingAmount', minBookingAmount)
          ..add('maxUses', maxUses)
          ..add('validFrom', validFrom)
          ..add('validTo', validTo))
        .toString();
  }
}

class UpdateCouponDtoBuilder
    implements Builder<UpdateCouponDto, UpdateCouponDtoBuilder> {
  _$UpdateCouponDto? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  UpdateCouponDtoDiscountTypeEnum? _discountType;
  UpdateCouponDtoDiscountTypeEnum? get discountType => _$this._discountType;
  set discountType(UpdateCouponDtoDiscountTypeEnum? discountType) =>
      _$this._discountType = discountType;

  num? _discountValue;
  num? get discountValue => _$this._discountValue;
  set discountValue(num? discountValue) =>
      _$this._discountValue = discountValue;

  num? _maxDiscount;
  num? get maxDiscount => _$this._maxDiscount;
  set maxDiscount(num? maxDiscount) => _$this._maxDiscount = maxDiscount;

  num? _minBookingAmount;
  num? get minBookingAmount => _$this._minBookingAmount;
  set minBookingAmount(num? minBookingAmount) =>
      _$this._minBookingAmount = minBookingAmount;

  num? _maxUses;
  num? get maxUses => _$this._maxUses;
  set maxUses(num? maxUses) => _$this._maxUses = maxUses;

  DateTime? _validFrom;
  DateTime? get validFrom => _$this._validFrom;
  set validFrom(DateTime? validFrom) => _$this._validFrom = validFrom;

  DateTime? _validTo;
  DateTime? get validTo => _$this._validTo;
  set validTo(DateTime? validTo) => _$this._validTo = validTo;

  UpdateCouponDtoBuilder() {
    UpdateCouponDto._defaults(this);
  }

  UpdateCouponDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _description = $v.description;
      _discountType = $v.discountType;
      _discountValue = $v.discountValue;
      _maxDiscount = $v.maxDiscount;
      _minBookingAmount = $v.minBookingAmount;
      _maxUses = $v.maxUses;
      _validFrom = $v.validFrom;
      _validTo = $v.validTo;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateCouponDto other) {
    _$v = other as _$UpdateCouponDto;
  }

  @override
  void update(void Function(UpdateCouponDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateCouponDto build() => _build();

  _$UpdateCouponDto _build() {
    final _$result =
        _$v ??
        _$UpdateCouponDto._(
          code: code,
          description: description,
          discountType: discountType,
          discountValue: discountValue,
          maxDiscount: maxDiscount,
          minBookingAmount: minBookingAmount,
          maxUses: maxUses,
          validFrom: validFrom,
          validTo: validTo,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
