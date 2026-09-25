// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_driver_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateDriverDto extends UpdateDriverDto {
  @override
  final String? licenseNumber;

  factory _$UpdateDriverDto([void Function(UpdateDriverDtoBuilder)? updates]) =>
      (UpdateDriverDtoBuilder()..update(updates))._build();

  _$UpdateDriverDto._({this.licenseNumber}) : super._();
  @override
  UpdateDriverDto rebuild(void Function(UpdateDriverDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateDriverDtoBuilder toBuilder() => UpdateDriverDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateDriverDto && licenseNumber == other.licenseNumber;
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
      r'UpdateDriverDto',
    )..add('licenseNumber', licenseNumber)).toString();
  }
}

class UpdateDriverDtoBuilder
    implements Builder<UpdateDriverDto, UpdateDriverDtoBuilder> {
  _$UpdateDriverDto? _$v;

  String? _licenseNumber;
  String? get licenseNumber => _$this._licenseNumber;
  set licenseNumber(String? licenseNumber) =>
      _$this._licenseNumber = licenseNumber;

  UpdateDriverDtoBuilder() {
    UpdateDriverDto._defaults(this);
  }

  UpdateDriverDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _licenseNumber = $v.licenseNumber;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateDriverDto other) {
    _$v = other as _$UpdateDriverDto;
  }

  @override
  void update(void Function(UpdateDriverDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateDriverDto build() => _build();

  _$UpdateDriverDto _build() {
    final _$result = _$v ?? _$UpdateDriverDto._(licenseNumber: licenseNumber);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
