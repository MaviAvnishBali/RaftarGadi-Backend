// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_vehicle_type_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateVehicleTypeDto extends CreateVehicleTypeDto {
  @override
  final String name;
  @override
  final String? description;
  @override
  final num? maxWeightKg;
  @override
  final String? dimensions;
  @override
  final String? iconUrl;
  @override
  final num? sortOrder;

  factory _$CreateVehicleTypeDto([
    void Function(CreateVehicleTypeDtoBuilder)? updates,
  ]) => (CreateVehicleTypeDtoBuilder()..update(updates))._build();

  _$CreateVehicleTypeDto._({
    required this.name,
    this.description,
    this.maxWeightKg,
    this.dimensions,
    this.iconUrl,
    this.sortOrder,
  }) : super._();
  @override
  CreateVehicleTypeDto rebuild(
    void Function(CreateVehicleTypeDtoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateVehicleTypeDtoBuilder toBuilder() =>
      CreateVehicleTypeDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateVehicleTypeDto &&
        name == other.name &&
        description == other.description &&
        maxWeightKg == other.maxWeightKg &&
        dimensions == other.dimensions &&
        iconUrl == other.iconUrl &&
        sortOrder == other.sortOrder;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, maxWeightKg.hashCode);
    _$hash = $jc(_$hash, dimensions.hashCode);
    _$hash = $jc(_$hash, iconUrl.hashCode);
    _$hash = $jc(_$hash, sortOrder.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateVehicleTypeDto')
          ..add('name', name)
          ..add('description', description)
          ..add('maxWeightKg', maxWeightKg)
          ..add('dimensions', dimensions)
          ..add('iconUrl', iconUrl)
          ..add('sortOrder', sortOrder))
        .toString();
  }
}

class CreateVehicleTypeDtoBuilder
    implements Builder<CreateVehicleTypeDto, CreateVehicleTypeDtoBuilder> {
  _$CreateVehicleTypeDto? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  num? _maxWeightKg;
  num? get maxWeightKg => _$this._maxWeightKg;
  set maxWeightKg(num? maxWeightKg) => _$this._maxWeightKg = maxWeightKg;

  String? _dimensions;
  String? get dimensions => _$this._dimensions;
  set dimensions(String? dimensions) => _$this._dimensions = dimensions;

  String? _iconUrl;
  String? get iconUrl => _$this._iconUrl;
  set iconUrl(String? iconUrl) => _$this._iconUrl = iconUrl;

  num? _sortOrder;
  num? get sortOrder => _$this._sortOrder;
  set sortOrder(num? sortOrder) => _$this._sortOrder = sortOrder;

  CreateVehicleTypeDtoBuilder() {
    CreateVehicleTypeDto._defaults(this);
  }

  CreateVehicleTypeDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _description = $v.description;
      _maxWeightKg = $v.maxWeightKg;
      _dimensions = $v.dimensions;
      _iconUrl = $v.iconUrl;
      _sortOrder = $v.sortOrder;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateVehicleTypeDto other) {
    _$v = other as _$CreateVehicleTypeDto;
  }

  @override
  void update(void Function(CreateVehicleTypeDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateVehicleTypeDto build() => _build();

  _$CreateVehicleTypeDto _build() {
    final _$result =
        _$v ??
        _$CreateVehicleTypeDto._(
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'CreateVehicleTypeDto',
            'name',
          ),
          description: description,
          maxWeightKg: maxWeightKg,
          dimensions: dimensions,
          iconUrl: iconUrl,
          sortOrder: sortOrder,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
