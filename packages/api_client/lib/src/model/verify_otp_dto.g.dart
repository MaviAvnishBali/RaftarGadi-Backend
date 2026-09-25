// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const VerifyOtpDtoRoleEnum _$verifyOtpDtoRoleEnum_CUSTOMER =
    const VerifyOtpDtoRoleEnum._('CUSTOMER');
const VerifyOtpDtoRoleEnum _$verifyOtpDtoRoleEnum_DRIVER =
    const VerifyOtpDtoRoleEnum._('DRIVER');
const VerifyOtpDtoRoleEnum _$verifyOtpDtoRoleEnum_ADMIN =
    const VerifyOtpDtoRoleEnum._('ADMIN');
const VerifyOtpDtoRoleEnum _$verifyOtpDtoRoleEnum_SUPER_ADMIN =
    const VerifyOtpDtoRoleEnum._('SUPER_ADMIN');

VerifyOtpDtoRoleEnum _$verifyOtpDtoRoleEnumValueOf(String name) {
  switch (name) {
    case 'CUSTOMER':
      return _$verifyOtpDtoRoleEnum_CUSTOMER;
    case 'DRIVER':
      return _$verifyOtpDtoRoleEnum_DRIVER;
    case 'ADMIN':
      return _$verifyOtpDtoRoleEnum_ADMIN;
    case 'SUPER_ADMIN':
      return _$verifyOtpDtoRoleEnum_SUPER_ADMIN;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<VerifyOtpDtoRoleEnum> _$verifyOtpDtoRoleEnumValues =
    BuiltSet<VerifyOtpDtoRoleEnum>(const <VerifyOtpDtoRoleEnum>[
      _$verifyOtpDtoRoleEnum_CUSTOMER,
      _$verifyOtpDtoRoleEnum_DRIVER,
      _$verifyOtpDtoRoleEnum_ADMIN,
      _$verifyOtpDtoRoleEnum_SUPER_ADMIN,
    ]);

Serializer<VerifyOtpDtoRoleEnum> _$verifyOtpDtoRoleEnumSerializer =
    _$VerifyOtpDtoRoleEnumSerializer();

class _$VerifyOtpDtoRoleEnumSerializer
    implements PrimitiveSerializer<VerifyOtpDtoRoleEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'CUSTOMER': 'CUSTOMER',
    'DRIVER': 'DRIVER',
    'ADMIN': 'ADMIN',
    'SUPER_ADMIN': 'SUPER_ADMIN',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'CUSTOMER': 'CUSTOMER',
    'DRIVER': 'DRIVER',
    'ADMIN': 'ADMIN',
    'SUPER_ADMIN': 'SUPER_ADMIN',
  };

  @override
  final Iterable<Type> types = const <Type>[VerifyOtpDtoRoleEnum];
  @override
  final String wireName = 'VerifyOtpDtoRoleEnum';

  @override
  Object serialize(
    Serializers serializers,
    VerifyOtpDtoRoleEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  VerifyOtpDtoRoleEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => VerifyOtpDtoRoleEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$VerifyOtpDto extends VerifyOtpDto {
  @override
  final String phone;
  @override
  final String otp;
  @override
  final VerifyOtpDtoRoleEnum? role;
  @override
  final String? deviceInfo;

  factory _$VerifyOtpDto([void Function(VerifyOtpDtoBuilder)? updates]) =>
      (VerifyOtpDtoBuilder()..update(updates))._build();

  _$VerifyOtpDto._({
    required this.phone,
    required this.otp,
    this.role,
    this.deviceInfo,
  }) : super._();
  @override
  VerifyOtpDto rebuild(void Function(VerifyOtpDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VerifyOtpDtoBuilder toBuilder() => VerifyOtpDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VerifyOtpDto &&
        phone == other.phone &&
        otp == other.otp &&
        role == other.role &&
        deviceInfo == other.deviceInfo;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, otp.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, deviceInfo.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'VerifyOtpDto')
          ..add('phone', phone)
          ..add('otp', otp)
          ..add('role', role)
          ..add('deviceInfo', deviceInfo))
        .toString();
  }
}

class VerifyOtpDtoBuilder
    implements Builder<VerifyOtpDto, VerifyOtpDtoBuilder> {
  _$VerifyOtpDto? _$v;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  String? _otp;
  String? get otp => _$this._otp;
  set otp(String? otp) => _$this._otp = otp;

  VerifyOtpDtoRoleEnum? _role;
  VerifyOtpDtoRoleEnum? get role => _$this._role;
  set role(VerifyOtpDtoRoleEnum? role) => _$this._role = role;

  String? _deviceInfo;
  String? get deviceInfo => _$this._deviceInfo;
  set deviceInfo(String? deviceInfo) => _$this._deviceInfo = deviceInfo;

  VerifyOtpDtoBuilder() {
    VerifyOtpDto._defaults(this);
  }

  VerifyOtpDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _phone = $v.phone;
      _otp = $v.otp;
      _role = $v.role;
      _deviceInfo = $v.deviceInfo;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VerifyOtpDto other) {
    _$v = other as _$VerifyOtpDto;
  }

  @override
  void update(void Function(VerifyOtpDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VerifyOtpDto build() => _build();

  _$VerifyOtpDto _build() {
    final _$result =
        _$v ??
        _$VerifyOtpDto._(
          phone: BuiltValueNullFieldError.checkNotNull(
            phone,
            r'VerifyOtpDto',
            'phone',
          ),
          otp: BuiltValueNullFieldError.checkNotNull(
            otp,
            r'VerifyOtpDto',
            'otp',
          ),
          role: role,
          deviceInfo: deviceInfo,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
