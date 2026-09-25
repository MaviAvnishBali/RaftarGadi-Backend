// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Booking {

 String get id; String get customerId; VehicleType get vehicleType; Address get pickup; Address get drop; FareEstimate get fare; DateTime get createdAt; BookingStatus get status; String? get driverId; String? get tripId; String? get couponCode; String? get note; DateTime? get scheduledAt;
/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingCopyWith<Booking> get copyWith => _$BookingCopyWithImpl<Booking>(this as Booking, _$identity);

  /// Serializes this Booking to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Booking&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.vehicleType, vehicleType) || other.vehicleType == vehicleType)&&(identical(other.pickup, pickup) || other.pickup == pickup)&&(identical(other.drop, drop) || other.drop == drop)&&(identical(other.fare, fare) || other.fare == fare)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.couponCode, couponCode) || other.couponCode == couponCode)&&(identical(other.note, note) || other.note == note)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,customerId,vehicleType,pickup,drop,fare,createdAt,status,driverId,tripId,couponCode,note,scheduledAt);

@override
String toString() {
  return 'Booking(id: $id, customerId: $customerId, vehicleType: $vehicleType, pickup: $pickup, drop: $drop, fare: $fare, createdAt: $createdAt, status: $status, driverId: $driverId, tripId: $tripId, couponCode: $couponCode, note: $note, scheduledAt: $scheduledAt)';
}


}

/// @nodoc
abstract mixin class $BookingCopyWith<$Res>  {
  factory $BookingCopyWith(Booking value, $Res Function(Booking) _then) = _$BookingCopyWithImpl;
@useResult
$Res call({
 String id, String customerId, VehicleType vehicleType, Address pickup, Address drop, FareEstimate fare, DateTime createdAt, BookingStatus status, String? driverId, String? tripId, String? couponCode, String? note, DateTime? scheduledAt
});


$AddressCopyWith<$Res> get pickup;$AddressCopyWith<$Res> get drop;$FareEstimateCopyWith<$Res> get fare;

}
/// @nodoc
class _$BookingCopyWithImpl<$Res>
    implements $BookingCopyWith<$Res> {
  _$BookingCopyWithImpl(this._self, this._then);

  final Booking _self;
  final $Res Function(Booking) _then;

/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? customerId = null,Object? vehicleType = null,Object? pickup = null,Object? drop = null,Object? fare = null,Object? createdAt = null,Object? status = null,Object? driverId = freezed,Object? tripId = freezed,Object? couponCode = freezed,Object? note = freezed,Object? scheduledAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,vehicleType: null == vehicleType ? _self.vehicleType : vehicleType // ignore: cast_nullable_to_non_nullable
as VehicleType,pickup: null == pickup ? _self.pickup : pickup // ignore: cast_nullable_to_non_nullable
as Address,drop: null == drop ? _self.drop : drop // ignore: cast_nullable_to_non_nullable
as Address,fare: null == fare ? _self.fare : fare // ignore: cast_nullable_to_non_nullable
as FareEstimate,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BookingStatus,driverId: freezed == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String?,tripId: freezed == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String?,couponCode: freezed == couponCode ? _self.couponCode : couponCode // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res> get pickup {
  
  return $AddressCopyWith<$Res>(_self.pickup, (value) {
    return _then(_self.copyWith(pickup: value));
  });
}/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res> get drop {
  
  return $AddressCopyWith<$Res>(_self.drop, (value) {
    return _then(_self.copyWith(drop: value));
  });
}/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FareEstimateCopyWith<$Res> get fare {
  
  return $FareEstimateCopyWith<$Res>(_self.fare, (value) {
    return _then(_self.copyWith(fare: value));
  });
}
}


/// Adds pattern-matching-related methods to [Booking].
extension BookingPatterns on Booking {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Booking value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Booking() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Booking value)  $default,){
final _that = this;
switch (_that) {
case _Booking():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Booking value)?  $default,){
final _that = this;
switch (_that) {
case _Booking() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String customerId,  VehicleType vehicleType,  Address pickup,  Address drop,  FareEstimate fare,  DateTime createdAt,  BookingStatus status,  String? driverId,  String? tripId,  String? couponCode,  String? note,  DateTime? scheduledAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Booking() when $default != null:
return $default(_that.id,_that.customerId,_that.vehicleType,_that.pickup,_that.drop,_that.fare,_that.createdAt,_that.status,_that.driverId,_that.tripId,_that.couponCode,_that.note,_that.scheduledAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String customerId,  VehicleType vehicleType,  Address pickup,  Address drop,  FareEstimate fare,  DateTime createdAt,  BookingStatus status,  String? driverId,  String? tripId,  String? couponCode,  String? note,  DateTime? scheduledAt)  $default,) {final _that = this;
switch (_that) {
case _Booking():
return $default(_that.id,_that.customerId,_that.vehicleType,_that.pickup,_that.drop,_that.fare,_that.createdAt,_that.status,_that.driverId,_that.tripId,_that.couponCode,_that.note,_that.scheduledAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String customerId,  VehicleType vehicleType,  Address pickup,  Address drop,  FareEstimate fare,  DateTime createdAt,  BookingStatus status,  String? driverId,  String? tripId,  String? couponCode,  String? note,  DateTime? scheduledAt)?  $default,) {final _that = this;
switch (_that) {
case _Booking() when $default != null:
return $default(_that.id,_that.customerId,_that.vehicleType,_that.pickup,_that.drop,_that.fare,_that.createdAt,_that.status,_that.driverId,_that.tripId,_that.couponCode,_that.note,_that.scheduledAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Booking extends Booking {
  const _Booking({required this.id, required this.customerId, required this.vehicleType, required this.pickup, required this.drop, required this.fare, required this.createdAt, this.status = BookingStatus.draft, this.driverId, this.tripId, this.couponCode, this.note, this.scheduledAt}): super._();
  factory _Booking.fromJson(Map<String, dynamic> json) => _$BookingFromJson(json);

@override final  String id;
@override final  String customerId;
@override final  VehicleType vehicleType;
@override final  Address pickup;
@override final  Address drop;
@override final  FareEstimate fare;
@override final  DateTime createdAt;
@override@JsonKey() final  BookingStatus status;
@override final  String? driverId;
@override final  String? tripId;
@override final  String? couponCode;
@override final  String? note;
@override final  DateTime? scheduledAt;

/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingCopyWith<_Booking> get copyWith => __$BookingCopyWithImpl<_Booking>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Booking&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.vehicleType, vehicleType) || other.vehicleType == vehicleType)&&(identical(other.pickup, pickup) || other.pickup == pickup)&&(identical(other.drop, drop) || other.drop == drop)&&(identical(other.fare, fare) || other.fare == fare)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.couponCode, couponCode) || other.couponCode == couponCode)&&(identical(other.note, note) || other.note == note)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,customerId,vehicleType,pickup,drop,fare,createdAt,status,driverId,tripId,couponCode,note,scheduledAt);

@override
String toString() {
  return 'Booking(id: $id, customerId: $customerId, vehicleType: $vehicleType, pickup: $pickup, drop: $drop, fare: $fare, createdAt: $createdAt, status: $status, driverId: $driverId, tripId: $tripId, couponCode: $couponCode, note: $note, scheduledAt: $scheduledAt)';
}


}

/// @nodoc
abstract mixin class _$BookingCopyWith<$Res> implements $BookingCopyWith<$Res> {
  factory _$BookingCopyWith(_Booking value, $Res Function(_Booking) _then) = __$BookingCopyWithImpl;
@override @useResult
$Res call({
 String id, String customerId, VehicleType vehicleType, Address pickup, Address drop, FareEstimate fare, DateTime createdAt, BookingStatus status, String? driverId, String? tripId, String? couponCode, String? note, DateTime? scheduledAt
});


@override $AddressCopyWith<$Res> get pickup;@override $AddressCopyWith<$Res> get drop;@override $FareEstimateCopyWith<$Res> get fare;

}
/// @nodoc
class __$BookingCopyWithImpl<$Res>
    implements _$BookingCopyWith<$Res> {
  __$BookingCopyWithImpl(this._self, this._then);

  final _Booking _self;
  final $Res Function(_Booking) _then;

/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? customerId = null,Object? vehicleType = null,Object? pickup = null,Object? drop = null,Object? fare = null,Object? createdAt = null,Object? status = null,Object? driverId = freezed,Object? tripId = freezed,Object? couponCode = freezed,Object? note = freezed,Object? scheduledAt = freezed,}) {
  return _then(_Booking(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,vehicleType: null == vehicleType ? _self.vehicleType : vehicleType // ignore: cast_nullable_to_non_nullable
as VehicleType,pickup: null == pickup ? _self.pickup : pickup // ignore: cast_nullable_to_non_nullable
as Address,drop: null == drop ? _self.drop : drop // ignore: cast_nullable_to_non_nullable
as Address,fare: null == fare ? _self.fare : fare // ignore: cast_nullable_to_non_nullable
as FareEstimate,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BookingStatus,driverId: freezed == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String?,tripId: freezed == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String?,couponCode: freezed == couponCode ? _self.couponCode : couponCode // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res> get pickup {
  
  return $AddressCopyWith<$Res>(_self.pickup, (value) {
    return _then(_self.copyWith(pickup: value));
  });
}/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res> get drop {
  
  return $AddressCopyWith<$Res>(_self.drop, (value) {
    return _then(_self.copyWith(drop: value));
  });
}/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FareEstimateCopyWith<$Res> get fare {
  
  return $FareEstimateCopyWith<$Res>(_self.fare, (value) {
    return _then(_self.copyWith(fare: value));
  });
}
}

// dart format on
