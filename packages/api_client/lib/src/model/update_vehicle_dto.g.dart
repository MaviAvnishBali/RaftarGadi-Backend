// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_vehicle_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateVehicleDto extends UpdateVehicleDto {
  @override
  final String? vehicleTypeId;
  @override
  final String? registrationNumber;
  @override
  final String? model;
  @override
  final String? color;
  @override
  final num? manufactureYear;

  factory _$UpdateVehicleDto([
    void Function(UpdateVehicleDtoBuilder)? updates,
  ]) => (UpdateVehicleDtoBuilder()..update(updates))._build();

  _$UpdateVehicleDto._({
    this.vehicleTypeId,
    this.registrationNumber,
    this.model,
    this.color,
    this.manufactureYear,
  }) : super._();
  @override
  UpdateVehicleDto rebuild(void Function(UpdateVehicleDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateVehicleDtoBuilder toBuilder() =>
      UpdateVehicleDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateVehicleDto &&
        vehicleTypeId == other.vehicleTypeId &&
        registrationNumber == other.registrationNumber &&
        model == other.model &&
        color == other.color &&
        manufactureYear == other.manufactureYear;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, vehicleTypeId.hashCode);
    _$hash = $jc(_$hash, registrationNumber.hashCode);
    _$hash = $jc(_$hash, model.hashCode);
    _$hash = $jc(_$hash, color.hashCode);
    _$hash = $jc(_$hash, manufactureYear.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateVehicleDto')
          ..add('vehicleTypeId', vehicleTypeId)
          ..add('registrationNumber', registrationNumber)
          ..add('model', model)
          ..add('color', color)
          ..add('manufactureYear', manufactureYear))
        .toString();
  }
}

class UpdateVehicleDtoBuilder
    implements Builder<UpdateVehicleDto, UpdateVehicleDtoBuilder> {
  _$UpdateVehicleDto? _$v;

  String? _vehicleTypeId;
  String? get vehicleTypeId => _$this._vehicleTypeId;
  set vehicleTypeId(String? vehicleTypeId) =>
      _$this._vehicleTypeId = vehicleTypeId;

  String? _registrationNumber;
  String? get registrationNumber => _$this._registrationNumber;
  set registrationNumber(String? registrationNumber) =>
      _$this._registrationNumber = registrationNumber;

  String? _model;
  String? get model => _$this._model;
  set model(String? model) => _$this._model = model;

  String? _color;
  String? get color => _$this._color;
  set color(String? color) => _$this._color = color;

  num? _manufactureYear;
  num? get manufactureYear => _$this._manufactureYear;
  set manufactureYear(num? manufactureYear) =>
      _$this._manufactureYear = manufactureYear;

  UpdateVehicleDtoBuilder() {
    UpdateVehicleDto._defaults(this);
  }

  UpdateVehicleDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vehicleTypeId = $v.vehicleTypeId;
      _registrationNumber = $v.registrationNumber;
      _model = $v.model;
      _color = $v.color;
      _manufactureYear = $v.manufactureYear;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateVehicleDto other) {
    _$v = other as _$UpdateVehicleDto;
  }

  @override
  void update(void Function(UpdateVehicleDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateVehicleDto build() => _build();

  _$UpdateVehicleDto _build() {
    final _$result =
        _$v ??
        _$UpdateVehicleDto._(
          vehicleTypeId: vehicleTypeId,
          registrationNumber: registrationNumber,
          model: model,
          color: color,
          manufactureYear: manufactureYear,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
