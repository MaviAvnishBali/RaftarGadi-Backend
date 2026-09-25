// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fare_estimate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FareEstimate {

 double get baseFare; double get distanceFare; double get timeFare; double get distanceKm; int get durationMinutes; double get surgeMultiplier; double get discount; String get currency;
/// Create a copy of FareEstimate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FareEstimateCopyWith<FareEstimate> get copyWith => _$FareEstimateCopyWithImpl<FareEstimate>(this as FareEstimate, _$identity);

  /// Serializes this FareEstimate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FareEstimate&&(identical(other.baseFare, baseFare) || other.baseFare == baseFare)&&(identical(other.distanceFare, distanceFare) || other.distanceFare == distanceFare)&&(identical(other.timeFare, timeFare) || other.timeFare == timeFare)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.surgeMultiplier, surgeMultiplier) || other.surgeMultiplier == surgeMultiplier)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,baseFare,distanceFare,timeFare,distanceKm,durationMinutes,surgeMultiplier,discount,currency);

@override
String toString() {
  return 'FareEstimate(baseFare: $baseFare, distanceFare: $distanceFare, timeFare: $timeFare, distanceKm: $distanceKm, durationMinutes: $durationMinutes, surgeMultiplier: $surgeMultiplier, discount: $discount, currency: $currency)';
}


}

/// @nodoc
abstract mixin class $FareEstimateCopyWith<$Res>  {
  factory $FareEstimateCopyWith(FareEstimate value, $Res Function(FareEstimate) _then) = _$FareEstimateCopyWithImpl;
@useResult
$Res call({
 double baseFare, double distanceFare, double timeFare, double distanceKm, int durationMinutes, double surgeMultiplier, double discount, String currency
});




}
/// @nodoc
class _$FareEstimateCopyWithImpl<$Res>
    implements $FareEstimateCopyWith<$Res> {
  _$FareEstimateCopyWithImpl(this._self, this._then);

  final FareEstimate _self;
  final $Res Function(FareEstimate) _then;

/// Create a copy of FareEstimate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? baseFare = null,Object? distanceFare = null,Object? timeFare = null,Object? distanceKm = null,Object? durationMinutes = null,Object? surgeMultiplier = null,Object? discount = null,Object? currency = null,}) {
  return _then(_self.copyWith(
baseFare: null == baseFare ? _self.baseFare : baseFare // ignore: cast_nullable_to_non_nullable
as double,distanceFare: null == distanceFare ? _self.distanceFare : distanceFare // ignore: cast_nullable_to_non_nullable
as double,timeFare: null == timeFare ? _self.timeFare : timeFare // ignore: cast_nullable_to_non_nullable
as double,distanceKm: null == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,surgeMultiplier: null == surgeMultiplier ? _self.surgeMultiplier : surgeMultiplier // ignore: cast_nullable_to_non_nullable
as double,discount: null == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FareEstimate].
extension FareEstimatePatterns on FareEstimate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FareEstimate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FareEstimate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FareEstimate value)  $default,){
final _that = this;
switch (_that) {
case _FareEstimate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FareEstimate value)?  $default,){
final _that = this;
switch (_that) {
case _FareEstimate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double baseFare,  double distanceFare,  double timeFare,  double distanceKm,  int durationMinutes,  double surgeMultiplier,  double discount,  String currency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FareEstimate() when $default != null:
return $default(_that.baseFare,_that.distanceFare,_that.timeFare,_that.distanceKm,_that.durationMinutes,_that.surgeMultiplier,_that.discount,_that.currency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double baseFare,  double distanceFare,  double timeFare,  double distanceKm,  int durationMinutes,  double surgeMultiplier,  double discount,  String currency)  $default,) {final _that = this;
switch (_that) {
case _FareEstimate():
return $default(_that.baseFare,_that.distanceFare,_that.timeFare,_that.distanceKm,_that.durationMinutes,_that.surgeMultiplier,_that.discount,_that.currency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double baseFare,  double distanceFare,  double timeFare,  double distanceKm,  int durationMinutes,  double surgeMultiplier,  double discount,  String currency)?  $default,) {final _that = this;
switch (_that) {
case _FareEstimate() when $default != null:
return $default(_that.baseFare,_that.distanceFare,_that.timeFare,_that.distanceKm,_that.durationMinutes,_that.surgeMultiplier,_that.discount,_that.currency);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FareEstimate extends FareEstimate {
  const _FareEstimate({required this.baseFare, required this.distanceFare, required this.timeFare, required this.distanceKm, required this.durationMinutes, this.surgeMultiplier = 1, this.discount = 0, this.currency = 'INR'}): super._();
  factory _FareEstimate.fromJson(Map<String, dynamic> json) => _$FareEstimateFromJson(json);

@override final  double baseFare;
@override final  double distanceFare;
@override final  double timeFare;
@override final  double distanceKm;
@override final  int durationMinutes;
@override@JsonKey() final  double surgeMultiplier;
@override@JsonKey() final  double discount;
@override@JsonKey() final  String currency;

/// Create a copy of FareEstimate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FareEstimateCopyWith<_FareEstimate> get copyWith => __$FareEstimateCopyWithImpl<_FareEstimate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FareEstimateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FareEstimate&&(identical(other.baseFare, baseFare) || other.baseFare == baseFare)&&(identical(other.distanceFare, distanceFare) || other.distanceFare == distanceFare)&&(identical(other.timeFare, timeFare) || other.timeFare == timeFare)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.surgeMultiplier, surgeMultiplier) || other.surgeMultiplier == surgeMultiplier)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,baseFare,distanceFare,timeFare,distanceKm,durationMinutes,surgeMultiplier,discount,currency);

@override
String toString() {
  return 'FareEstimate(baseFare: $baseFare, distanceFare: $distanceFare, timeFare: $timeFare, distanceKm: $distanceKm, durationMinutes: $durationMinutes, surgeMultiplier: $surgeMultiplier, discount: $discount, currency: $currency)';
}


}

/// @nodoc
abstract mixin class _$FareEstimateCopyWith<$Res> implements $FareEstimateCopyWith<$Res> {
  factory _$FareEstimateCopyWith(_FareEstimate value, $Res Function(_FareEstimate) _then) = __$FareEstimateCopyWithImpl;
@override @useResult
$Res call({
 double baseFare, double distanceFare, double timeFare, double distanceKm, int durationMinutes, double surgeMultiplier, double discount, String currency
});




}
/// @nodoc
class __$FareEstimateCopyWithImpl<$Res>
    implements _$FareEstimateCopyWith<$Res> {
  __$FareEstimateCopyWithImpl(this._self, this._then);

  final _FareEstimate _self;
  final $Res Function(_FareEstimate) _then;

/// Create a copy of FareEstimate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? baseFare = null,Object? distanceFare = null,Object? timeFare = null,Object? distanceKm = null,Object? durationMinutes = null,Object? surgeMultiplier = null,Object? discount = null,Object? currency = null,}) {
  return _then(_FareEstimate(
baseFare: null == baseFare ? _self.baseFare : baseFare // ignore: cast_nullable_to_non_nullable
as double,distanceFare: null == distanceFare ? _self.distanceFare : distanceFare // ignore: cast_nullable_to_non_nullable
as double,timeFare: null == timeFare ? _self.timeFare : timeFare // ignore: cast_nullable_to_non_nullable
as double,distanceKm: null == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,surgeMultiplier: null == surgeMultiplier ? _self.surgeMultiplier : surgeMultiplier // ignore: cast_nullable_to_non_nullable
as double,discount: null == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
