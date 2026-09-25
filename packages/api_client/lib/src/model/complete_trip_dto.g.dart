// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_trip_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CompleteTripDto extends CompleteTripDto {
  @override
  final num actualDistanceKm;
  @override
  final num actualDurationMin;

  factory _$CompleteTripDto([void Function(CompleteTripDtoBuilder)? updates]) =>
      (CompleteTripDtoBuilder()..update(updates))._build();

  _$CompleteTripDto._({
    required this.actualDistanceKm,
    required this.actualDurationMin,
  }) : super._();
  @override
  CompleteTripDto rebuild(void Function(CompleteTripDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CompleteTripDtoBuilder toBuilder() => CompleteTripDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CompleteTripDto &&
        actualDistanceKm == other.actualDistanceKm &&
        actualDurationMin == other.actualDurationMin;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, actualDistanceKm.hashCode);
    _$hash = $jc(_$hash, actualDurationMin.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CompleteTripDto')
          ..add('actualDistanceKm', actualDistanceKm)
          ..add('actualDurationMin', actualDurationMin))
        .toString();
  }
}

class CompleteTripDtoBuilder
    implements Builder<CompleteTripDto, CompleteTripDtoBuilder> {
  _$CompleteTripDto? _$v;

  num? _actualDistanceKm;
  num? get actualDistanceKm => _$this._actualDistanceKm;
  set actualDistanceKm(num? actualDistanceKm) =>
      _$this._actualDistanceKm = actualDistanceKm;

  num? _actualDurationMin;
  num? get actualDurationMin => _$this._actualDurationMin;
  set actualDurationMin(num? actualDurationMin) =>
      _$this._actualDurationMin = actualDurationMin;

  CompleteTripDtoBuilder() {
    CompleteTripDto._defaults(this);
  }

  CompleteTripDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _actualDistanceKm = $v.actualDistanceKm;
      _actualDurationMin = $v.actualDurationMin;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CompleteTripDto other) {
    _$v = other as _$CompleteTripDto;
  }

  @override
  void update(void Function(CompleteTripDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CompleteTripDto build() => _build();

  _$CompleteTripDto _build() {
    final _$result =
        _$v ??
        _$CompleteTripDto._(
          actualDistanceKm: BuiltValueNullFieldError.checkNotNull(
            actualDistanceKm,
            r'CompleteTripDto',
            'actualDistanceKm',
          ),
          actualDurationMin: BuiltValueNullFieldError.checkNotNull(
            actualDurationMin,
            r'CompleteTripDto',
            'actualDurationMin',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
