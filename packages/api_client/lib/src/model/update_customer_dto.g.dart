// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_customer_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateCustomerDto extends UpdateCustomerDto {
  @override
  final String? address;
  @override
  final num? savedLat;
  @override
  final num? savedLng;

  factory _$UpdateCustomerDto([
    void Function(UpdateCustomerDtoBuilder)? updates,
  ]) => (UpdateCustomerDtoBuilder()..update(updates))._build();

  _$UpdateCustomerDto._({this.address, this.savedLat, this.savedLng})
    : super._();
  @override
  UpdateCustomerDto rebuild(void Function(UpdateCustomerDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateCustomerDtoBuilder toBuilder() =>
      UpdateCustomerDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateCustomerDto &&
        address == other.address &&
        savedLat == other.savedLat &&
        savedLng == other.savedLng;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, savedLat.hashCode);
    _$hash = $jc(_$hash, savedLng.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateCustomerDto')
          ..add('address', address)
          ..add('savedLat', savedLat)
          ..add('savedLng', savedLng))
        .toString();
  }
}

class UpdateCustomerDtoBuilder
    implements Builder<UpdateCustomerDto, UpdateCustomerDtoBuilder> {
  _$UpdateCustomerDto? _$v;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  num? _savedLat;
  num? get savedLat => _$this._savedLat;
  set savedLat(num? savedLat) => _$this._savedLat = savedLat;

  num? _savedLng;
  num? get savedLng => _$this._savedLng;
  set savedLng(num? savedLng) => _$this._savedLng = savedLng;

  UpdateCustomerDtoBuilder() {
    UpdateCustomerDto._defaults(this);
  }

  UpdateCustomerDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _address = $v.address;
      _savedLat = $v.savedLat;
      _savedLng = $v.savedLng;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateCustomerDto other) {
    _$v = other as _$UpdateCustomerDto;
  }

  @override
  void update(void Function(UpdateCustomerDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateCustomerDto build() => _build();

  _$UpdateCustomerDto _build() {
    final _$result =
        _$v ??
        _$UpdateCustomerDto._(
          address: address,
          savedLat: savedLat,
          savedLng: savedLng,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
