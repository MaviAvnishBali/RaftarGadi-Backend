// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_driver_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RegisterDriverDto extends RegisterDriverDto {
  @override
  final String licenseNumber;

  factory _$RegisterDriverDto([
    void Function(RegisterDriverDtoBuilder)? updates,
  ]) => (RegisterDriverDtoBuilder()..update(updates))._build();

  _$RegisterDriverDto._({required this.licenseNumber}) : super._();
  @override
  RegisterDriverDto rebuild(void Function(RegisterDriverDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RegisterDriverDtoBuilder toBuilder() =>
      RegisterDriverDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RegisterDriverDto && licenseNumber == other.licenseNumber;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, licenseNumber.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'RegisterDriverDto',
    )..add('licenseNumber', licenseNumber)).toString();
  }
}

class RegisterDriverDtoBuilder
    implements Builder<RegisterDriverDto, RegisterDriverDtoBuilder> {
  _$RegisterDriverDto? _$v;

  String? _licenseNumber;
  String? get licenseNumber => _$this._licenseNumber;
  set licenseNumber(String? licenseNumber) =>
      _$this._licenseNumber = licenseNumber;

  RegisterDriverDtoBuilder() {
    RegisterDriverDto._defaults(this);
  }

  RegisterDriverDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _licenseNumber = $v.licenseNumber;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RegisterDriverDto other) {
    _$v = other as _$RegisterDriverDto;
  }

  @override
  void update(void Function(RegisterDriverDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RegisterDriverDto build() => _build();

  _$RegisterDriverDto _build() {
    final _$result =
        _$v ??
        _$RegisterDriverDto._(
          licenseNumber: BuiltValueNullFieldError.checkNotNull(
            licenseNumber,
            r'RegisterDriverDto',
            'licenseNumber',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
