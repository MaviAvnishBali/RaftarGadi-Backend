// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webhook_payload_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WebhookPayloadDto extends WebhookPayloadDto {
  @override
  final String orderId;
  @override
  final String status;
  @override
  final String transactionId;
  @override
  final String signature;

  factory _$WebhookPayloadDto([
    void Function(WebhookPayloadDtoBuilder)? updates,
  ]) => (WebhookPayloadDtoBuilder()..update(updates))._build();

  _$WebhookPayloadDto._({
    required this.orderId,
    required this.status,
    required this.transactionId,
    required this.signature,
  }) : super._();
  @override
  WebhookPayloadDto rebuild(void Function(WebhookPayloadDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WebhookPayloadDtoBuilder toBuilder() =>
      WebhookPayloadDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WebhookPayloadDto &&
        orderId == other.orderId &&
        status == other.status &&
        transactionId == other.transactionId &&
        signature == other.signature;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, orderId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, transactionId.hashCode);
    _$hash = $jc(_$hash, signature.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WebhookPayloadDto')
          ..add('orderId', orderId)
          ..add('status', status)
          ..add('transactionId', transactionId)
          ..add('signature', signature))
        .toString();
  }
}

class WebhookPayloadDtoBuilder
    implements Builder<WebhookPayloadDto, WebhookPayloadDtoBuilder> {
  _$WebhookPayloadDto? _$v;

  String? _orderId;
  String? get orderId => _$this._orderId;
  set orderId(String? orderId) => _$this._orderId = orderId;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _transactionId;
  String? get transactionId => _$this._transactionId;
  set transactionId(String? transactionId) =>
      _$this._transactionId = transactionId;

  String? _signature;
  String? get signature => _$this._signature;
  set signature(String? signature) => _$this._signature = signature;

  WebhookPayloadDtoBuilder() {
    WebhookPayloadDto._defaults(this);
  }

  WebhookPayloadDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _orderId = $v.orderId;
      _status = $v.status;
      _transactionId = $v.transactionId;
      _signature = $v.signature;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WebhookPayloadDto other) {
    _$v = other as _$WebhookPayloadDto;
  }

  @override
  void update(void Function(WebhookPayloadDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WebhookPayloadDto build() => _build();

  _$WebhookPayloadDto _build() {
    final _$result =
        _$v ??
        _$WebhookPayloadDto._(
          orderId: BuiltValueNullFieldError.checkNotNull(
            orderId,
            r'WebhookPayloadDto',
            'orderId',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'WebhookPayloadDto',
            'status',
          ),
          transactionId: BuiltValueNullFieldError.checkNotNull(
            transactionId,
            r'WebhookPayloadDto',
            'transactionId',
          ),
          signature: BuiltValueNullFieldError.checkNotNull(
            signature,
            r'WebhookPayloadDto',
            'signature',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
