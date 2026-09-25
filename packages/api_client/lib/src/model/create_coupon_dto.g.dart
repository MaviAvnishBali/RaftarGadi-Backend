// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_coupon_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateCouponDtoDiscountTypeEnum
_$createCouponDtoDiscountTypeEnum_PERCENTAGE =
    const CreateCouponDtoDiscountTypeEnum._('PERCENTAGE');
const CreateCouponDtoDiscountTypeEnum _$createCouponDtoDiscountTypeEnum_FLAT =
    const CreateCouponDtoDiscountTypeEnum._('FLAT');

CreateCouponDtoDiscountTypeEnum _$createCouponDtoDiscountTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'PERCENTAGE':
      return _$createCouponDtoDiscountTypeEnum_PERCENTAGE;
    case 'FLAT':
      return _$createCouponDtoDiscountTypeEnum_FLAT;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreateCouponDtoDiscountTypeEnum>
_$createCouponDtoDiscountTypeEnumValues =
    BuiltSet<CreateCouponDtoDiscountTypeEnum>(
      const <CreateCouponDtoDiscountTypeEnum>[
        _$createCouponDtoDiscountTypeEnum_PERCENTAGE,
        _$createCouponDtoDiscountTypeEnum_FLAT,
      ],
    );

Serializer<CreateCouponDtoDiscountTypeEnum>
_$createCouponDtoDiscountTypeEnumSerializer =
    _$CreateCouponDtoDiscountTypeEnumSerializer();

class _$CreateCouponDtoDiscountTypeEnumSerializer
    implements PrimitiveSerializer<CreateCouponDtoDiscountTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PERCENTAGE': 'PERCENTAGE',
    'FLAT': 'FLAT',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PERCENTAGE': 'PERCENTAGE',
    'FLAT': 'FLAT',
  };

  @override
  final Iterable<Type> types = const <Type>[CreateCouponDtoDiscountTypeEnum];
  @override
  final String wireName = 'CreateCouponDtoDiscountTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    CreateCouponDtoDiscountTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  CreateCouponDtoDiscountTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => CreateCouponDtoDiscountTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$CreateCouponDto extends CreateCouponDto {
  @override
  final String code;
  @override
  final String? description;
  @override
  final CreateCouponDtoDiscountTypeEnum discountType;
  @override
  final num discountValue;
  @override
  final num? maxDiscount;
  @override
  final num? minBookingAmount;
  @override
  final num? maxUses;
  @override
  final DateTime validFrom;
  @override
  final DateTime validTo;

  factory _$CreateCouponDto([void Function(CreateCouponDtoBuilder)? updates]) =>
      (CreateCouponDtoBuilder()..update(updates))._build();

  _$CreateCouponDto._({
    required this.code,
    this.description,
    required this.discountType,
    required this.discountValue,
    this.maxDiscount,
    this.minBookingAmount,
    this.maxUses,
    required this.validFrom,
    required this.validTo,
  }) : super._();
  @override
  CreateCouponDto rebuild(void Function(CreateCouponDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateCouponDtoBuilder toBuilder() => CreateCouponDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateCouponDto &&
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
    return (newBuiltValueToStringHelper(r'CreateCouponDto')
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

class CreateCouponDtoBuilder
    implements Builder<CreateCouponDto, CreateCouponDtoBuilder> {
  _$CreateCouponDto? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  CreateCouponDtoDiscountTypeEnum? _discountType;
  CreateCouponDtoDiscountTypeEnum? get discountType => _$this._discountType;
  set discountType(CreateCouponDtoDiscountTypeEnum? discountType) =>
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

  CreateCouponDtoBuilder() {
    CreateCouponDto._defaults(this);
  }

  CreateCouponDtoBuilder get _$this {
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
  void replace(CreateCouponDto other) {
    _$v = other as _$CreateCouponDto;
  }

  @override
  void update(void Function(CreateCouponDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateCouponDto build() => _build();

  _$CreateCouponDto _build() {
    final _$result =
        _$v ??
        _$CreateCouponDto._(
          code: BuiltValueNullFieldError.checkNotNull(
            code,
            r'CreateCouponDto',
            'code',
          ),
          description: description,
          discountType: BuiltValueNullFieldError.checkNotNull(
            discountType,
            r'CreateCouponDto',
            'discountType',
          ),
          discountValue: BuiltValueNullFieldError.checkNotNull(
            discountValue,
            r'CreateCouponDto',
            'discountValue',
          ),
          maxDiscount: maxDiscount,
          minBookingAmount: minBookingAmount,
          maxUses: maxUses,
          validFrom: BuiltValueNullFieldError.checkNotNull(
            validFrom,
            r'CreateCouponDto',
            'validFrom',
          ),
          validTo: BuiltValueNullFieldError.checkNotNull(
            validTo,
            r'CreateCouponDto',
            'validTo',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
