// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_otp_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SendOtpDto extends SendOtpDto {
  @override
  final String phone;

  factory _$SendOtpDto([void Function(SendOtpDtoBuilder)? updates]) =>
      (SendOtpDtoBuilder()..update(updates))._build();

  _$SendOtpDto._({required this.phone}) : super._();
  @override
  SendOtpDto rebuild(void Function(SendOtpDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SendOtpDtoBuilder toBuilder() => SendOtpDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SendOtpDto && phone == other.phone;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'SendOtpDto',
    )..add('phone', phone)).toString();
  }
}

class SendOtpDtoBuilder implements Builder<SendOtpDto, SendOtpDtoBuilder> {
  _$SendOtpDto? _$v;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  SendOtpDtoBuilder() {
    SendOtpDto._defaults(this);
  }

  SendOtpDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _phone = $v.phone;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SendOtpDto other) {
    _$v = other as _$SendOtpDto;
  }

  @override
  void update(void Function(SendOtpDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SendOtpDto build() => _build();

  _$SendOtpDto _build() {
    final _$result =
        _$v ??
        _$SendOtpDto._(
          phone: BuiltValueNullFieldError.checkNotNull(
            phone,
            r'SendOtpDto',
            'phone',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
