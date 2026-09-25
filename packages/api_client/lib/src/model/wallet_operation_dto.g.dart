// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_operation_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WalletOperationDto extends WalletOperationDto {
  @override
  final num amount;
  @override
  final String description;

  factory _$WalletOperationDto([
    void Function(WalletOperationDtoBuilder)? updates,
  ]) => (WalletOperationDtoBuilder()..update(updates))._build();

  _$WalletOperationDto._({required this.amount, required this.description})
    : super._();
  @override
  WalletOperationDto rebuild(
    void Function(WalletOperationDtoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  WalletOperationDtoBuilder toBuilder() =>
      WalletOperationDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WalletOperationDto &&
        amount == other.amount &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WalletOperationDto')
          ..add('amount', amount)
          ..add('description', description))
        .toString();
  }
}

class WalletOperationDtoBuilder
    implements Builder<WalletOperationDto, WalletOperationDtoBuilder> {
  _$WalletOperationDto? _$v;

  num? _amount;
  num? get amount => _$this._amount;
  set amount(num? amount) => _$this._amount = amount;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  WalletOperationDtoBuilder() {
    WalletOperationDto._defaults(this);
  }

  WalletOperationDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _amount = $v.amount;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WalletOperationDto other) {
    _$v = other as _$WalletOperationDto;
  }

  @override
  void update(void Function(WalletOperationDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WalletOperationDto build() => _build();

  _$WalletOperationDto _build() {
    final _$result =
        _$v ??
        _$WalletOperationDto._(
          amount: BuiltValueNullFieldError.checkNotNull(
            amount,
            r'WalletOperationDto',
            'amount',
          ),
          description: BuiltValueNullFieldError.checkNotNull(
            description,
            r'WalletOperationDto',
            'description',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
