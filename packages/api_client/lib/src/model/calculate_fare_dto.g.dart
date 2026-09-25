// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculate_fare_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CalculateFareDto extends CalculateFareDto {
  @override
  final String vehicleTypeId;
  @override
  final num distanceKm;
  @override
  final num durationMin;
  @override
  final String? city;
  @override
  final String? couponCode;

  factory _$CalculateFareDto([
    void Function(CalculateFareDtoBuilder)? updates,
  ]) => (CalculateFareDtoBuilder()..update(updates))._build();

  _$CalculateFareDto._({
    required this.vehicleTypeId,
    required this.distanceKm,
    required this.durationMin,
    this.city,
    this.couponCode,
  }) : super._();
  @override
  CalculateFareDto rebuild(void Function(CalculateFareDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CalculateFareDtoBuilder toBuilder() =>
      CalculateFareDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CalculateFareDto &&
        vehicleTypeId == other.vehicleTypeId &&
        distanceKm == other.distanceKm &&
        durationMin == other.durationMin &&
        city == other.city &&
        couponCode == other.couponCode;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, vehicleTypeId.hashCode);
    _$hash = $jc(_$hash, distanceKm.hashCode);
    _$hash = $jc(_$hash, durationMin.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, couponCode.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CalculateFareDto')
          ..add('vehicleTypeId', vehicleTypeId)
          ..add('distanceKm', distanceKm)
          ..add('durationMin', durationMin)
          ..add('city', city)
          ..add('couponCode', couponCode))
        .toString();
  }
}

class CalculateFareDtoBuilder
    implements Builder<CalculateFareDto, CalculateFareDtoBuilder> {
  _$CalculateFareDto? _$v;

  String? _vehicleTypeId;
  String? get vehicleTypeId => _$this._vehicleTypeId;
  set vehicleTypeId(String? vehicleTypeId) =>
      _$this._vehicleTypeId = vehicleTypeId;

  num? _distanceKm;
  num? get distanceKm => _$this._distanceKm;
  set distanceKm(num? distanceKm) => _$this._distanceKm = distanceKm;

  num? _durationMin;
  num? get durationMin => _$this._durationMin;
  set durationMin(num? durationMin) => _$this._durationMin = durationMin;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  String? _couponCode;
  String? get couponCode => _$this._couponCode;
  set couponCode(String? couponCode) => _$this._couponCode = couponCode;

  CalculateFareDtoBuilder() {
    CalculateFareDto._defaults(this);
  }

  CalculateFareDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vehicleTypeId = $v.vehicleTypeId;
      _distanceKm = $v.distanceKm;
      _durationMin = $v.durationMin;
      _city = $v.city;
      _couponCode = $v.couponCode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CalculateFareDto other) {
    _$v = other as _$CalculateFareDto;
  }

  @override
  void update(void Function(CalculateFareDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CalculateFareDto build() => _build();

  _$CalculateFareDto _build() {
    final _$result =
        _$v ??
        _$CalculateFareDto._(
          vehicleTypeId: BuiltValueNullFieldError.checkNotNull(
            vehicleTypeId,
            r'CalculateFareDto',
            'vehicleTypeId',
          ),
          distanceKm: BuiltValueNullFieldError.checkNotNull(
            distanceKm,
            r'CalculateFareDto',
            'distanceKm',
          ),
          durationMin: BuiltValueNullFieldError.checkNotNull(
            durationMin,
            r'CalculateFareDto',
            'durationMin',
          ),
          city: city,
          couponCode: couponCode,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
