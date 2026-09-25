// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driver.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Driver {

 String get id; String get fullName; String get phone; Vehicle get vehicle; DriverAvailability get availability; double get rating; int get totalTrips; String? get photoUrl;
/// Create a copy of Driver
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriverCopyWith<Driver> get copyWith => _$DriverCopyWithImpl<Driver>(this as Driver, _$identity);

  /// Serializes this Driver to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Driver&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.vehicle, vehicle) || other.vehicle == vehicle)&&(identical(other.availability, availability) || other.availability == availability)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.totalTrips, totalTrips) || other.totalTrips == totalTrips)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,phone,vehicle,availability,rating,totalTrips,photoUrl);

@override
String toString() {
  return 'Driver(id: $id, fullName: $fullName, phone: $phone, vehicle: $vehicle, availability: $availability, rating: $rating, totalTrips: $totalTrips, photoUrl: $photoUrl)';
}


}

/// @nodoc
abstract mixin class $DriverCopyWith<$Res>  {
  factory $DriverCopyWith(Driver value, $Res Function(Driver) _then) = _$DriverCopyWithImpl;
@useResult
$Res call({
 String id, String fullName, String phone, Vehicle vehicle, DriverAvailability availability, double rating, int totalTrips, String? photoUrl
});


$VehicleCopyWith<$Res> get vehicle;

}
/// @nodoc
class _$DriverCopyWithImpl<$Res>
    implements $DriverCopyWith<$Res> {
  _$DriverCopyWithImpl(this._self, this._then);

  final Driver _self;
  final $Res Function(Driver) _then;

/// Create a copy of Driver
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fullName = null,Object? phone = null,Object? vehicle = null,Object? availability = null,Object? rating = null,Object? totalTrips = null,Object? photoUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,vehicle: null == vehicle ? _self.vehicle : vehicle // ignore: cast_nullable_to_non_nullable
as Vehicle,availability: null == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as DriverAvailability,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,totalTrips: null == totalTrips ? _self.totalTrips : totalTrips // ignore: cast_nullable_to_non_nullable
as int,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of Driver
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VehicleCopyWith<$Res> get vehicle {
  
  return $VehicleCopyWith<$Res>(_self.vehicle, (value) {
    return _then(_self.copyWith(vehicle: value));
  });
}
}


/// Adds pattern-matching-related methods to [Driver].
extension DriverPatterns on Driver {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Driver value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Driver() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Driver value)  $default,){
final _that = this;
switch (_that) {
case _Driver():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Driver value)?  $default,){
final _that = this;
switch (_that) {
case _Driver() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String fullName,  String phone,  Vehicle vehicle,  DriverAvailability availability,  double rating,  int totalTrips,  String? photoUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Driver() when $default != null:
return $default(_that.id,_that.fullName,_that.phone,_that.vehicle,_that.availability,_that.rating,_that.totalTrips,_that.photoUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String fullName,  String phone,  Vehicle vehicle,  DriverAvailability availability,  double rating,  int totalTrips,  String? photoUrl)  $default,) {final _that = this;
switch (_that) {
case _Driver():
return $default(_that.id,_that.fullName,_that.phone,_that.vehicle,_that.availability,_that.rating,_that.totalTrips,_that.photoUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String fullName,  String phone,  Vehicle vehicle,  DriverAvailability availability,  double rating,  int totalTrips,  String? photoUrl)?  $default,) {final _that = this;
switch (_that) {
case _Driver() when $default != null:
return $default(_that.id,_that.fullName,_that.phone,_that.vehicle,_that.availability,_that.rating,_that.totalTrips,_that.photoUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Driver implements Driver {
  const _Driver({required this.id, required this.fullName, required this.phone, required this.vehicle, this.availability = DriverAvailability.offline, this.rating = 0, this.totalTrips = 0, this.photoUrl});
  factory _Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);

@override final  String id;
@override final  String fullName;
@override final  String phone;
@override final  Vehicle vehicle;
@override@JsonKey() final  DriverAvailability availability;
@override@JsonKey() final  double rating;
@override@JsonKey() final  int totalTrips;
@override final  String? photoUrl;

/// Create a copy of Driver
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriverCopyWith<_Driver> get copyWith => __$DriverCopyWithImpl<_Driver>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DriverToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Driver&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.vehicle, vehicle) || other.vehicle == vehicle)&&(identical(other.availability, availability) || other.availability == availability)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.totalTrips, totalTrips) || other.totalTrips == totalTrips)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,phone,vehicle,availability,rating,totalTrips,photoUrl);

@override
String toString() {
  return 'Driver(id: $id, fullName: $fullName, phone: $phone, vehicle: $vehicle, availability: $availability, rating: $rating, totalTrips: $totalTrips, photoUrl: $photoUrl)';
}


}

/// @nodoc
abstract mixin class _$DriverCopyWith<$Res> implements $DriverCopyWith<$Res> {
  factory _$DriverCopyWith(_Driver value, $Res Function(_Driver) _then) = __$DriverCopyWithImpl;
@override @useResult
$Res call({
 String id, String fullName, String phone, Vehicle vehicle, DriverAvailability availability, double rating, int totalTrips, String? photoUrl
});


@override $VehicleCopyWith<$Res> get vehicle;

}
/// @nodoc
class __$DriverCopyWithImpl<$Res>
    implements _$DriverCopyWith<$Res> {
  __$DriverCopyWithImpl(this._self, this._then);

  final _Driver _self;
  final $Res Function(_Driver) _then;

/// Create a copy of Driver
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fullName = null,Object? phone = null,Object? vehicle = null,Object? availability = null,Object? rating = null,Object? totalTrips = null,Object? photoUrl = freezed,}) {
  return _then(_Driver(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,vehicle: null == vehicle ? _self.vehicle : vehicle // ignore: cast_nullable_to_non_nullable
as Vehicle,availability: null == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as DriverAvailability,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,totalTrips: null == totalTrips ? _self.totalTrips : totalTrips // ignore: cast_nullable_to_non_nullable
as int,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Driver
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VehicleCopyWith<$Res> get vehicle {
  
  return $VehicleCopyWith<$Res>(_self.vehicle, (value) {
    return _then(_self.copyWith(vehicle: value));
  });
}
}

// dart format on
