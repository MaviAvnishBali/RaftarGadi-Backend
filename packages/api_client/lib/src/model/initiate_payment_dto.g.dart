// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initiate_payment_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const InitiatePaymentDtoMethodEnum _$initiatePaymentDtoMethodEnum_CASH =
    const InitiatePaymentDtoMethodEnum._('CASH');
const InitiatePaymentDtoMethodEnum _$initiatePaymentDtoMethodEnum_UPI =
    const InitiatePaymentDtoMethodEnum._('UPI');
const InitiatePaymentDtoMethodEnum _$initiatePaymentDtoMethodEnum_CARD =
    const InitiatePaymentDtoMethodEnum._('CARD');
const InitiatePaymentDtoMethodEnum _$initiatePaymentDtoMethodEnum_WALLET =
    const InitiatePaymentDtoMethodEnum._('WALLET');

InitiatePaymentDtoMethodEnum _$initiatePaymentDtoMethodEnumValueOf(
  String name,
) {
  switch (name) {
    case 'CASH':
      return _$initiatePaymentDtoMethodEnum_CASH;
    case 'UPI':
      return _$initiatePaymentDtoMethodEnum_UPI;
    case 'CARD':
      return _$initiatePaymentDtoMethodEnum_CARD;
    case 'WALLET':
      return _$initiatePaymentDtoMethodEnum_WALLET;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<InitiatePaymentDtoMethodEnum>
_$initiatePaymentDtoMethodEnumValues =
    BuiltSet<InitiatePaymentDtoMethodEnum>(const <InitiatePaymentDtoMethodEnum>[
      _$initiatePaymentDtoMethodEnum_CASH,
      _$initiatePaymentDtoMethodEnum_UPI,
      _$initiatePaymentDtoMethodEnum_CARD,
      _$initiatePaymentDtoMethodEnum_WALLET,
    ]);

Serializer<InitiatePaymentDtoMethodEnum>
_$initiatePaymentDtoMethodEnumSerializer =
    _$InitiatePaymentDtoMethodEnumSerializer();

class _$InitiatePaymentDtoMethodEnumSerializer
    implements PrimitiveSerializer<InitiatePaymentDtoMethodEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'CASH': 'CASH',
    'UPI': 'UPI',
    'CARD': 'CARD',
    'WALLET': 'WALLET',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'CASH': 'CASH',
    'UPI': 'UPI',
    'CARD': 'CARD',
    'WALLET': 'WALLET',
  };

  @override
  final Iterable<Type> types = const <Type>[InitiatePaymentDtoMethodEnum];
  @override
  final String wireName = 'InitiatePaymentDtoMethodEnum';

  @override
  Object serialize(
    Serializers serializers,
    InitiatePaymentDtoMethodEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  InitiatePaymentDtoMethodEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => InitiatePaymentDtoMethodEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$InitiatePaymentDto extends InitiatePaymentDto {
  @override
  final String bookingId;
  @override
  final InitiatePaymentDtoMethodEnum method;

  factory _$InitiatePaymentDto([
    void Function(InitiatePaymentDtoBuilder)? updates,
  ]) => (InitiatePaymentDtoBuilder()..update(updates))._build();

  _$InitiatePaymentDto._({required this.bookingId, required this.method})
    : super._();
  @override
  InitiatePaymentDto rebuild(
    void Function(InitiatePaymentDtoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  InitiatePaymentDtoBuilder toBuilder() =>
      InitiatePaymentDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InitiatePaymentDto &&
        bookingId == other.bookingId &&
        method == other.method;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, bookingId.hashCode);
    _$hash = $jc(_$hash, method.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InitiatePaymentDto')
          ..add('bookingId', bookingId)
          ..add('method', method))
        .toString();
  }
}

class InitiatePaymentDtoBuilder
    implements Builder<InitiatePaymentDto, InitiatePaymentDtoBuilder> {
  _$InitiatePaymentDto? _$v;

  String? _bookingId;
  String? get bookingId => _$this._bookingId;
  set bookingId(String? bookingId) => _$this._bookingId = bookingId;

  InitiatePaymentDtoMethodEnum? _method;
  InitiatePaymentDtoMethodEnum? get method => _$this._method;
  set method(InitiatePaymentDtoMethodEnum? method) => _$this._method = method;

  InitiatePaymentDtoBuilder() {
    InitiatePaymentDto._defaults(this);
  }

  InitiatePaymentDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _bookingId = $v.bookingId;
      _method = $v.method;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InitiatePaymentDto other) {
    _$v = other as _$InitiatePaymentDto;
  }

  @override
  void update(void Function(InitiatePaymentDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InitiatePaymentDto build() => _build();

  _$InitiatePaymentDto _build() {
    final _$result =
        _$v ??
        _$InitiatePaymentDto._(
          bookingId: BuiltValueNullFieldError.checkNotNull(
            bookingId,
            r'InitiatePaymentDto',
            'bookingId',
          ),
          method: BuiltValueNullFieldError.checkNotNull(
            method,
            r'InitiatePaymentDto',
            'method',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
