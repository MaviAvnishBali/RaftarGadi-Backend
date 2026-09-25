// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_controller_check503_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HealthControllerCheck503Response
    extends HealthControllerCheck503Response {
  @override
  final String? status;
  @override
  final BuiltMap<String, HealthControllerCheck200ResponseInfoValue>? info;
  @override
  final BuiltMap<String, HealthControllerCheck200ResponseInfoValue>? error;
  @override
  final BuiltMap<String, HealthControllerCheck200ResponseInfoValue>? details;

  factory _$HealthControllerCheck503Response([
    void Function(HealthControllerCheck503ResponseBuilder)? updates,
  ]) => (HealthControllerCheck503ResponseBuilder()..update(updates))._build();

  _$HealthControllerCheck503Response._({
    this.status,
    this.info,
    this.error,
    this.details,
  }) : super._();
  @override
  HealthControllerCheck503Response rebuild(
    void Function(HealthControllerCheck503ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HealthControllerCheck503ResponseBuilder toBuilder() =>
      HealthControllerCheck503ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HealthControllerCheck503Response &&
        status == other.status &&
        info == other.info &&
        error == other.error &&
        details == other.details;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, info.hashCode);
    _$hash = $jc(_$hash, error.hashCode);
    _$hash = $jc(_$hash, details.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HealthControllerCheck503Response')
          ..add('status', status)
          ..add('info', info)
          ..add('error', error)
          ..add('details', details))
        .toString();
  }
}

class HealthControllerCheck503ResponseBuilder
    implements
        Builder<
          HealthControllerCheck503Response,
          HealthControllerCheck503ResponseBuilder
        > {
  _$HealthControllerCheck503Response? _$v;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  MapBuilder<String, HealthControllerCheck200ResponseInfoValue>? _info;
  MapBuilder<String, HealthControllerCheck200ResponseInfoValue> get info =>
      _$this._info ??=
          MapBuilder<String, HealthControllerCheck200ResponseInfoValue>();
  set info(
    MapBuilder<String, HealthControllerCheck200ResponseInfoValue>? info,
  ) => _$this._info = info;

  MapBuilder<String, HealthControllerCheck200ResponseInfoValue>? _error;
  MapBuilder<String, HealthControllerCheck200ResponseInfoValue> get error =>
      _$this._error ??=
          MapBuilder<String, HealthControllerCheck200ResponseInfoValue>();
  set error(
    MapBuilder<String, HealthControllerCheck200ResponseInfoValue>? error,
  ) => _$this._error = error;

  MapBuilder<String, HealthControllerCheck200ResponseInfoValue>? _details;
  MapBuilder<String, HealthControllerCheck200ResponseInfoValue> get details =>
      _$this._details ??=
          MapBuilder<String, HealthControllerCheck200ResponseInfoValue>();
  set details(
    MapBuilder<String, HealthControllerCheck200ResponseInfoValue>? details,
  ) => _$this._details = details;

  HealthControllerCheck503ResponseBuilder() {
    HealthControllerCheck503Response._defaults(this);
  }

  HealthControllerCheck503ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _info = $v.info?.toBuilder();
      _error = $v.error?.toBuilder();
      _details = $v.details?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HealthControllerCheck503Response other) {
    _$v = other as _$HealthControllerCheck503Response;
  }

  @override
  void update(void Function(HealthControllerCheck503ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HealthControllerCheck503Response build() => _build();

  _$HealthControllerCheck503Response _build() {
    _$HealthControllerCheck503Response _$result;
    try {
      _$result =
          _$v ??
          _$HealthControllerCheck503Response._(
            status: status,
            info: _info?.build(),
            error: _error?.build(),
            details: _details?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'info';
        _info?.build();
        _$failedField = 'error';
        _error?.build();
        _$failedField = 'details';
        _details?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'HealthControllerCheck503Response',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
