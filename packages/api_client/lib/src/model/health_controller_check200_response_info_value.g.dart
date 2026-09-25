// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_controller_check200_response_info_value.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HealthControllerCheck200ResponseInfoValue
    extends HealthControllerCheck200ResponseInfoValue {
  @override
  final String status;

  factory _$HealthControllerCheck200ResponseInfoValue([
    void Function(HealthControllerCheck200ResponseInfoValueBuilder)? updates,
  ]) => (HealthControllerCheck200ResponseInfoValueBuilder()..update(updates))
      ._build();

  _$HealthControllerCheck200ResponseInfoValue._({required this.status})
    : super._();
  @override
  HealthControllerCheck200ResponseInfoValue rebuild(
    void Function(HealthControllerCheck200ResponseInfoValueBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HealthControllerCheck200ResponseInfoValueBuilder toBuilder() =>
      HealthControllerCheck200ResponseInfoValueBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HealthControllerCheck200ResponseInfoValue &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'HealthControllerCheck200ResponseInfoValue',
    )..add('status', status)).toString();
  }
}

class HealthControllerCheck200ResponseInfoValueBuilder
    implements
        Builder<
          HealthControllerCheck200ResponseInfoValue,
          HealthControllerCheck200ResponseInfoValueBuilder
        > {
  _$HealthControllerCheck200ResponseInfoValue? _$v;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  HealthControllerCheck200ResponseInfoValueBuilder() {
    HealthControllerCheck200ResponseInfoValue._defaults(this);
  }

  HealthControllerCheck200ResponseInfoValueBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HealthControllerCheck200ResponseInfoValue other) {
    _$v = other as _$HealthControllerCheck200ResponseInfoValue;
  }

  @override
  void update(
    void Function(HealthControllerCheck200ResponseInfoValueBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  HealthControllerCheck200ResponseInfoValue build() => _build();

  _$HealthControllerCheck200ResponseInfoValue _build() {
    final _$result =
        _$v ??
        _$HealthControllerCheck200ResponseInfoValue._(
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'HealthControllerCheck200ResponseInfoValue',
            'status',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
