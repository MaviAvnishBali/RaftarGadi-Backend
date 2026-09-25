// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_pricing_rule_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreatePricingRuleDto extends CreatePricingRuleDto {
  @override
  final String vehicleTypeId;
  @override
  final String? city;
  @override
  final num baseFare;
  @override
  final num perKmCharge;
  @override
  final num perMinCharge;
  @override
  final num minimumFare;
  @override
  final num platformFeePercent;
  @override
  final num taxPercent;
  @override
  final num? surgeMultiplier;
  @override
  final DateTime effectiveFrom;
  @override
  final DateTime? effectiveTo;

  factory _$CreatePricingRuleDto([
    void Function(CreatePricingRuleDtoBuilder)? updates,
  ]) => (CreatePricingRuleDtoBuilder()..update(updates))._build();

  _$CreatePricingRuleDto._({
    required this.vehicleTypeId,
    this.city,
    required this.baseFare,
    required this.perKmCharge,
    required this.perMinCharge,
    required this.minimumFare,
    required this.platformFeePercent,
    required this.taxPercent,
    this.surgeMultiplier,
    required this.effectiveFrom,
    this.effectiveTo,
  }) : super._();
  @override
  CreatePricingRuleDto rebuild(
    void Function(CreatePricingRuleDtoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreatePricingRuleDtoBuilder toBuilder() =>
      CreatePricingRuleDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreatePricingRuleDto &&
        vehicleTypeId == other.vehicleTypeId &&
        city == other.city &&
        baseFare == other.baseFare &&
        perKmCharge == other.perKmCharge &&
        perMinCharge == other.perMinCharge &&
        minimumFare == other.minimumFare &&
        platformFeePercent == other.platformFeePercent &&
        taxPercent == other.taxPercent &&
        surgeMultiplier == other.surgeMultiplier &&
        effectiveFrom == other.effectiveFrom &&
        effectiveTo == other.effectiveTo;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, vehicleTypeId.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, baseFare.hashCode);
    _$hash = $jc(_$hash, perKmCharge.hashCode);
    _$hash = $jc(_$hash, perMinCharge.hashCode);
    _$hash = $jc(_$hash, minimumFare.hashCode);
    _$hash = $jc(_$hash, platformFeePercent.hashCode);
    _$hash = $jc(_$hash, taxPercent.hashCode);
    _$hash = $jc(_$hash, surgeMultiplier.hashCode);
    _$hash = $jc(_$hash, effectiveFrom.hashCode);
    _$hash = $jc(_$hash, effectiveTo.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreatePricingRuleDto')
          ..add('vehicleTypeId', vehicleTypeId)
          ..add('city', city)
          ..add('baseFare', baseFare)
          ..add('perKmCharge', perKmCharge)
          ..add('perMinCharge', perMinCharge)
          ..add('minimumFare', minimumFare)
          ..add('platformFeePercent', platformFeePercent)
          ..add('taxPercent', taxPercent)
          ..add('surgeMultiplier', surgeMultiplier)
          ..add('effectiveFrom', effectiveFrom)
          ..add('effectiveTo', effectiveTo))
        .toString();
  }
}

class CreatePricingRuleDtoBuilder
    implements Builder<CreatePricingRuleDto, CreatePricingRuleDtoBuilder> {
  _$CreatePricingRuleDto? _$v;

  String? _vehicleTypeId;
  String? get vehicleTypeId => _$this._vehicleTypeId;
  set vehicleTypeId(String? vehicleTypeId) =>
      _$this._vehicleTypeId = vehicleTypeId;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  num? _baseFare;
  num? get baseFare => _$this._baseFare;
  set baseFare(num? baseFare) => _$this._baseFare = baseFare;

  num? _perKmCharge;
  num? get perKmCharge => _$this._perKmCharge;
  set perKmCharge(num? perKmCharge) => _$this._perKmCharge = perKmCharge;

  num? _perMinCharge;
  num? get perMinCharge => _$this._perMinCharge;
  set perMinCharge(num? perMinCharge) => _$this._perMinCharge = perMinCharge;

  num? _minimumFare;
  num? get minimumFare => _$this._minimumFare;
  set minimumFare(num? minimumFare) => _$this._minimumFare = minimumFare;

  num? _platformFeePercent;
  num? get platformFeePercent => _$this._platformFeePercent;
  set platformFeePercent(num? platformFeePercent) =>
      _$this._platformFeePercent = platformFeePercent;

  num? _taxPercent;
  num? get taxPercent => _$this._taxPercent;
  set taxPercent(num? taxPercent) => _$this._taxPercent = taxPercent;

  num? _surgeMultiplier;
  num? get surgeMultiplier => _$this._surgeMultiplier;
  set surgeMultiplier(num? surgeMultiplier) =>
      _$this._surgeMultiplier = surgeMultiplier;

  DateTime? _effectiveFrom;
  DateTime? get effectiveFrom => _$this._effectiveFrom;
  set effectiveFrom(DateTime? effectiveFrom) =>
      _$this._effectiveFrom = effectiveFrom;

  DateTime? _effectiveTo;
  DateTime? get effectiveTo => _$this._effectiveTo;
  set effectiveTo(DateTime? effectiveTo) => _$this._effectiveTo = effectiveTo;

  CreatePricingRuleDtoBuilder() {
    CreatePricingRuleDto._defaults(this);
  }

  CreatePricingRuleDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vehicleTypeId = $v.vehicleTypeId;
      _city = $v.city;
      _baseFare = $v.baseFare;
      _perKmCharge = $v.perKmCharge;
      _perMinCharge = $v.perMinCharge;
      _minimumFare = $v.minimumFare;
      _platformFeePercent = $v.platformFeePercent;
      _taxPercent = $v.taxPercent;
      _surgeMultiplier = $v.surgeMultiplier;
      _effectiveFrom = $v.effectiveFrom;
      _effectiveTo = $v.effectiveTo;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreatePricingRuleDto other) {
    _$v = other as _$CreatePricingRuleDto;
  }

  @override
  void update(void Function(CreatePricingRuleDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreatePricingRuleDto build() => _build();

  _$CreatePricingRuleDto _build() {
    final _$result =
        _$v ??
        _$CreatePricingRuleDto._(
          vehicleTypeId: BuiltValueNullFieldError.checkNotNull(
            vehicleTypeId,
            r'CreatePricingRuleDto',
            'vehicleTypeId',
          ),
          city: city,
          baseFare: BuiltValueNullFieldError.checkNotNull(
            baseFare,
            r'CreatePricingRuleDto',
            'baseFare',
          ),
          perKmCharge: BuiltValueNullFieldError.checkNotNull(
            perKmCharge,
            r'CreatePricingRuleDto',
            'perKmCharge',
          ),
          perMinCharge: BuiltValueNullFieldError.checkNotNull(
            perMinCharge,
            r'CreatePricingRuleDto',
            'perMinCharge',
          ),
          minimumFare: BuiltValueNullFieldError.checkNotNull(
            minimumFare,
            r'CreatePricingRuleDto',
            'minimumFare',
          ),
          platformFeePercent: BuiltValueNullFieldError.checkNotNull(
            platformFeePercent,
            r'CreatePricingRuleDto',
            'platformFeePercent',
          ),
          taxPercent: BuiltValueNullFieldError.checkNotNull(
            taxPercent,
            r'CreatePricingRuleDto',
            'taxPercent',
          ),
          surgeMultiplier: surgeMultiplier,
          effectiveFrom: BuiltValueNullFieldError.checkNotNull(
            effectiveFrom,
            r'CreatePricingRuleDto',
            'effectiveFrom',
          ),
          effectiveTo: effectiveTo,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
