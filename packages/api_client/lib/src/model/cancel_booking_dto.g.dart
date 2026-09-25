// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_booking_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CancelBookingDto extends CancelBookingDto {
  @override
  final String? reason;

  factory _$CancelBookingDto([
    void Function(CancelBookingDtoBuilder)? updates,
  ]) => (CancelBookingDtoBuilder()..update(updates))._build();

  _$CancelBookingDto._({this.reason}) : super._();
  @override
  CancelBookingDto rebuild(void Function(CancelBookingDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CancelBookingDtoBuilder toBuilder() =>
      CancelBookingDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CancelBookingDto && reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'CancelBookingDto',
    )..add('reason', reason)).toString();
  }
}

class CancelBookingDtoBuilder
    implements Builder<CancelBookingDto, CancelBookingDtoBuilder> {
  _$CancelBookingDto? _$v;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  CancelBookingDtoBuilder() {
    CancelBookingDto._defaults(this);
  }

  CancelBookingDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CancelBookingDto other) {
    _$v = other as _$CancelBookingDto;
  }

  @override
  void update(void Function(CancelBookingDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CancelBookingDto build() => _build();

  _$CancelBookingDto _build() {
    final _$result = _$v ?? _$CancelBookingDto._(reason: reason);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
