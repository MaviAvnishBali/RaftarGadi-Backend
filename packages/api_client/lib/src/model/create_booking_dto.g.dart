// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_booking_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateBookingDtoPaymentMethodEnum
_$createBookingDtoPaymentMethodEnum_CASH =
    const CreateBookingDtoPaymentMethodEnum._('CASH');
const CreateBookingDtoPaymentMethodEnum
_$createBookingDtoPaymentMethodEnum_UPI =
    const CreateBookingDtoPaymentMethodEnum._('UPI');
const CreateBookingDtoPaymentMethodEnum
_$createBookingDtoPaymentMethodEnum_CARD =
    const CreateBookingDtoPaymentMethodEnum._('CARD');
const CreateBookingDtoPaymentMethodEnum
_$createBookingDtoPaymentMethodEnum_WALLET =
    const CreateBookingDtoPaymentMethodEnum._('WALLET');

CreateBookingDtoPaymentMethodEnum _$createBookingDtoPaymentMethodEnumValueOf(
  String name,
) {
  switch (name) {
    case 'CASH':
      return _$createBookingDtoPaymentMethodEnum_CASH;
    case 'UPI':
      return _$createBookingDtoPaymentMethodEnum_UPI;
    case 'CARD':
      return _$createBookingDtoPaymentMethodEnum_CARD;
    case 'WALLET':
      return _$createBookingDtoPaymentMethodEnum_WALLET;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreateBookingDtoPaymentMethodEnum>
_$createBookingDtoPaymentMethodEnumValues =
    BuiltSet<CreateBookingDtoPaymentMethodEnum>(
      const <CreateBookingDtoPaymentMethodEnum>[
        _$createBookingDtoPaymentMethodEnum_CASH,
        _$createBookingDtoPaymentMethodEnum_UPI,
        _$createBookingDtoPaymentMethodEnum_CARD,
        _$createBookingDtoPaymentMethodEnum_WALLET,
      ],
    );

Serializer<CreateBookingDtoPaymentMethodEnum>
_$createBookingDtoPaymentMethodEnumSerializer =
    _$CreateBookingDtoPaymentMethodEnumSerializer();

class _$CreateBookingDtoPaymentMethodEnumSerializer
    implements PrimitiveSerializer<CreateBookingDtoPaymentMethodEnum> {
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
  final Iterable<Type> types = const <Type>[CreateBookingDtoPaymentMethodEnum];
  @override
  final String wireName = 'CreateBookingDtoPaymentMethodEnum';

  @override
  Object serialize(
    Serializers serializers,
    CreateBookingDtoPaymentMethodEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  CreateBookingDtoPaymentMethodEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => CreateBookingDtoPaymentMethodEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$CreateBookingDto extends CreateBookingDto {
  @override
  final num pickupLat;
  @override
  final num pickupLng;
  @override
  final String pickupAddress;
  @override
  final num dropLat;
  @override
  final num dropLng;
  @override
  final String dropAddress;
  @override
  final String vehicleTypeId;
  @override
  final String? packageType;
  @override
  final String? packageDescription;
  @override
  final num? packageWeightKg;
  @override
  final CreateBookingDtoPaymentMethodEnum? paymentMethod;
  @override
  final String? couponCode;
  @override
  final DateTime? scheduledAt;

  factory _$CreateBookingDto([
    void Function(CreateBookingDtoBuilder)? updates,
  ]) => (CreateBookingDtoBuilder()..update(updates))._build();

  _$CreateBookingDto._({
    required this.pickupLat,
    required this.pickupLng,
    required this.pickupAddress,
    required this.dropLat,
    required this.dropLng,
    required this.dropAddress,
    required this.vehicleTypeId,
    this.packageType,
    this.packageDescription,
    this.packageWeightKg,
    this.paymentMethod,
    this.couponCode,
    this.scheduledAt,
  }) : super._();
  @override
  CreateBookingDto rebuild(void Function(CreateBookingDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateBookingDtoBuilder toBuilder() =>
      CreateBookingDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateBookingDto &&
        pickupLat == other.pickupLat &&
        pickupLng == other.pickupLng &&
        pickupAddress == other.pickupAddress &&
        dropLat == other.dropLat &&
        dropLng == other.dropLng &&
        dropAddress == other.dropAddress &&
        vehicleTypeId == other.vehicleTypeId &&
        packageType == other.packageType &&
        packageDescription == other.packageDescription &&
        packageWeightKg == other.packageWeightKg &&
        paymentMethod == other.paymentMethod &&
        couponCode == other.couponCode &&
        scheduledAt == other.scheduledAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, pickupLat.hashCode);
    _$hash = $jc(_$hash, pickupLng.hashCode);
    _$hash = $jc(_$hash, pickupAddress.hashCode);
    _$hash = $jc(_$hash, dropLat.hashCode);
    _$hash = $jc(_$hash, dropLng.hashCode);
    _$hash = $jc(_$hash, dropAddress.hashCode);
    _$hash = $jc(_$hash, vehicleTypeId.hashCode);
    _$hash = $jc(_$hash, packageType.hashCode);
    _$hash = $jc(_$hash, packageDescription.hashCode);
    _$hash = $jc(_$hash, packageWeightKg.hashCode);
    _$hash = $jc(_$hash, paymentMethod.hashCode);
    _$hash = $jc(_$hash, couponCode.hashCode);
    _$hash = $jc(_$hash, scheduledAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateBookingDto')
          ..add('pickupLat', pickupLat)
          ..add('pickupLng', pickupLng)
          ..add('pickupAddress', pickupAddress)
          ..add('dropLat', dropLat)
          ..add('dropLng', dropLng)
          ..add('dropAddress', dropAddress)
          ..add('vehicleTypeId', vehicleTypeId)
          ..add('packageType', packageType)
          ..add('packageDescription', packageDescription)
          ..add('packageWeightKg', packageWeightKg)
          ..add('paymentMethod', paymentMethod)
          ..add('couponCode', couponCode)
          ..add('scheduledAt', scheduledAt))
        .toString();
  }
}

class CreateBookingDtoBuilder
    implements Builder<CreateBookingDto, CreateBookingDtoBuilder> {
  _$CreateBookingDto? _$v;

  num? _pickupLat;
  num? get pickupLat => _$this._pickupLat;
  set pickupLat(num? pickupLat) => _$this._pickupLat = pickupLat;

  num? _pickupLng;
  num? get pickupLng => _$this._pickupLng;
  set pickupLng(num? pickupLng) => _$this._pickupLng = pickupLng;

  String? _pickupAddress;
  String? get pickupAddress => _$this._pickupAddress;
  set pickupAddress(String? pickupAddress) =>
      _$this._pickupAddress = pickupAddress;

  num? _dropLat;
  num? get dropLat => _$this._dropLat;
  set dropLat(num? dropLat) => _$this._dropLat = dropLat;

  num? _dropLng;
  num? get dropLng => _$this._dropLng;
  set dropLng(num? dropLng) => _$this._dropLng = dropLng;

  String? _dropAddress;
  String? get dropAddress => _$this._dropAddress;
  set dropAddress(String? dropAddress) => _$this._dropAddress = dropAddress;

  String? _vehicleTypeId;
  String? get vehicleTypeId => _$this._vehicleTypeId;
  set vehicleTypeId(String? vehicleTypeId) =>
      _$this._vehicleTypeId = vehicleTypeId;

  String? _packageType;
  String? get packageType => _$this._packageType;
  set packageType(String? packageType) => _$this._packageType = packageType;

  String? _packageDescription;
  String? get packageDescription => _$this._packageDescription;
  set packageDescription(String? packageDescription) =>
      _$this._packageDescription = packageDescription;

  num? _packageWeightKg;
  num? get packageWeightKg => _$this._packageWeightKg;
  set packageWeightKg(num? packageWeightKg) =>
      _$this._packageWeightKg = packageWeightKg;

  CreateBookingDtoPaymentMethodEnum? _paymentMethod;
  CreateBookingDtoPaymentMethodEnum? get paymentMethod => _$this._paymentMethod;
  set paymentMethod(CreateBookingDtoPaymentMethodEnum? paymentMethod) =>
      _$this._paymentMethod = paymentMethod;

  String? _couponCode;
  String? get couponCode => _$this._couponCode;
  set couponCode(String? couponCode) => _$this._couponCode = couponCode;

  DateTime? _scheduledAt;
  DateTime? get scheduledAt => _$this._scheduledAt;
  set scheduledAt(DateTime? scheduledAt) => _$this._scheduledAt = scheduledAt;

  CreateBookingDtoBuilder() {
    CreateBookingDto._defaults(this);
  }

  CreateBookingDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _pickupLat = $v.pickupLat;
      _pickupLng = $v.pickupLng;
      _pickupAddress = $v.pickupAddress;
      _dropLat = $v.dropLat;
      _dropLng = $v.dropLng;
      _dropAddress = $v.dropAddress;
      _vehicleTypeId = $v.vehicleTypeId;
      _packageType = $v.packageType;
      _packageDescription = $v.packageDescription;
      _packageWeightKg = $v.packageWeightKg;
      _paymentMethod = $v.paymentMethod;
      _couponCode = $v.couponCode;
      _scheduledAt = $v.scheduledAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateBookingDto other) {
    _$v = other as _$CreateBookingDto;
  }

  @override
  void update(void Function(CreateBookingDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateBookingDto build() => _build();

  _$CreateBookingDto _build() {
    final _$result =
        _$v ??
        _$CreateBookingDto._(
          pickupLat: BuiltValueNullFieldError.checkNotNull(
            pickupLat,
            r'CreateBookingDto',
            'pickupLat',
          ),
          pickupLng: BuiltValueNullFieldError.checkNotNull(
            pickupLng,
            r'CreateBookingDto',
            'pickupLng',
          ),
          pickupAddress: BuiltValueNullFieldError.checkNotNull(
            pickupAddress,
            r'CreateBookingDto',
            'pickupAddress',
          ),
          dropLat: BuiltValueNullFieldError.checkNotNull(
            dropLat,
            r'CreateBookingDto',
            'dropLat',
          ),
          dropLng: BuiltValueNullFieldError.checkNotNull(
            dropLng,
            r'CreateBookingDto',
            'dropLng',
          ),
          dropAddress: BuiltValueNullFieldError.checkNotNull(
            dropAddress,
            r'CreateBookingDto',
            'dropAddress',
          ),
          vehicleTypeId: BuiltValueNullFieldError.checkNotNull(
            vehicleTypeId,
            r'CreateBookingDto',
            'vehicleTypeId',
          ),
          packageType: packageType,
          packageDescription: packageDescription,
          packageWeightKg: packageWeightKg,
          paymentMethod: paymentMethod,
          couponCode: couponCode,
          scheduledAt: scheduledAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
