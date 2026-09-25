// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validate_coupon_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ValidateCouponDto extends ValidateCouponDto {
  @override
  final String code;
  @override
  final num bookingAmount;

  factory _$ValidateCouponDto([
    void Function(ValidateCouponDtoBuilder)? updates,
  ]) => (ValidateCouponDtoBuilder()..update(updates))._build();

  _$ValidateCouponDto._({required this.code, required this.bookingAmount})
    : super._();
  @override
  ValidateCouponDto rebuild(void Function(ValidateCouponDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ValidateCouponDtoBuilder toBuilder() =>
      ValidateCouponDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ValidateCouponDto &&
        code == other.code &&
        bookingAmount == other.bookingAmount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, bookingAmount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ValidateCouponDto')
          ..add('code', code)
          ..add('bookingAmount', bookingAmount))
        .toString();
  }
}

class ValidateCouponDtoBuilder
    implements Builder<ValidateCouponDto, ValidateCouponDtoBuilder> {
  _$ValidateCouponDto? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  num? _bookingAmount;
  num? get bookingAmount => _$this._bookingAmount;
  set bookingAmount(num? bookingAmount) =>
      _$this._bookingAmount = bookingAmount;

  ValidateCouponDtoBuilder() {
    ValidateCouponDto._defaults(this);
  }

  ValidateCouponDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _bookingAmount = $v.bookingAmount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ValidateCouponDto other) {
    _$v = other as _$ValidateCouponDto;
  }

  @override
  void update(void Function(ValidateCouponDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ValidateCouponDto build() => _build();

  _$ValidateCouponDto _build() {
    final _$result =
        _$v ??
        _$ValidateCouponDto._(
          code: BuiltValueNullFieldError.checkNotNull(
            code,
            r'ValidateCouponDto',
            'code',
          ),
          bookingAmount: BuiltValueNullFieldError.checkNotNull(
            bookingAmount,
            r'ValidateCouponDto',
            'bookingAmount',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
