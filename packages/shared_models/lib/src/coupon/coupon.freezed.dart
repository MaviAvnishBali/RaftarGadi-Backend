// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coupon.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Coupon {

 String get code; String get title; String get description; DiscountType get discountType; double get value; DateTime get expiresAt; double get minOrderValue; double? get maxDiscount; bool get isActive;
/// Create a copy of Coupon
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CouponCopyWith<Coupon> get copyWith => _$CouponCopyWithImpl<Coupon>(this as Coupon, _$identity);

  /// Serializes this Coupon to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Coupon&&(identical(other.code, code) || other.code == code)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.discountType, discountType) || other.discountType == discountType)&&(identical(other.value, value) || other.value == value)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.minOrderValue, minOrderValue) || other.minOrderValue == minOrderValue)&&(identical(other.maxDiscount, maxDiscount) || other.maxDiscount == maxDiscount)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,title,description,discountType,value,expiresAt,minOrderValue,maxDiscount,isActive);

@override
String toString() {
  return 'Coupon(code: $code, title: $title, description: $description, discountType: $discountType, value: $value, expiresAt: $expiresAt, minOrderValue: $minOrderValue, maxDiscount: $maxDiscount, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $CouponCopyWith<$Res>  {
  factory $CouponCopyWith(Coupon value, $Res Function(Coupon) _then) = _$CouponCopyWithImpl;
@useResult
$Res call({
 String code, String title, String description, DiscountType discountType, double value, DateTime expiresAt, double minOrderValue, double? maxDiscount, bool isActive
});




}
/// @nodoc
class _$CouponCopyWithImpl<$Res>
    implements $CouponCopyWith<$Res> {
  _$CouponCopyWithImpl(this._self, this._then);

  final Coupon _self;
  final $Res Function(Coupon) _then;

/// Create a copy of Coupon
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? title = null,Object? description = null,Object? discountType = null,Object? value = null,Object? expiresAt = null,Object? minOrderValue = null,Object? maxDiscount = freezed,Object? isActive = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,discountType: null == discountType ? _self.discountType : discountType // ignore: cast_nullable_to_non_nullable
as DiscountType,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,minOrderValue: null == minOrderValue ? _self.minOrderValue : minOrderValue // ignore: cast_nullable_to_non_nullable
as double,maxDiscount: freezed == maxDiscount ? _self.maxDiscount : maxDiscount // ignore: cast_nullable_to_non_nullable
as double?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Coupon].
extension CouponPatterns on Coupon {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Coupon value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Coupon() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Coupon value)  $default,){
final _that = this;
switch (_that) {
case _Coupon():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Coupon value)?  $default,){
final _that = this;
switch (_that) {
case _Coupon() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String title,  String description,  DiscountType discountType,  double value,  DateTime expiresAt,  double minOrderValue,  double? maxDiscount,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Coupon() when $default != null:
return $default(_that.code,_that.title,_that.description,_that.discountType,_that.value,_that.expiresAt,_that.minOrderValue,_that.maxDiscount,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String title,  String description,  DiscountType discountType,  double value,  DateTime expiresAt,  double minOrderValue,  double? maxDiscount,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _Coupon():
return $default(_that.code,_that.title,_that.description,_that.discountType,_that.value,_that.expiresAt,_that.minOrderValue,_that.maxDiscount,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String title,  String description,  DiscountType discountType,  double value,  DateTime expiresAt,  double minOrderValue,  double? maxDiscount,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _Coupon() when $default != null:
return $default(_that.code,_that.title,_that.description,_that.discountType,_that.value,_that.expiresAt,_that.minOrderValue,_that.maxDiscount,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Coupon extends Coupon {
  const _Coupon({required this.code, required this.title, required this.description, required this.discountType, required this.value, required this.expiresAt, this.minOrderValue = 0, this.maxDiscount, this.isActive = true}): super._();
  factory _Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);

@override final  String code;
@override final  String title;
@override final  String description;
@override final  DiscountType discountType;
@override final  double value;
@override final  DateTime expiresAt;
@override@JsonKey() final  double minOrderValue;
@override final  double? maxDiscount;
@override@JsonKey() final  bool isActive;

/// Create a copy of Coupon
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CouponCopyWith<_Coupon> get copyWith => __$CouponCopyWithImpl<_Coupon>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CouponToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Coupon&&(identical(other.code, code) || other.code == code)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.discountType, discountType) || other.discountType == discountType)&&(identical(other.value, value) || other.value == value)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.minOrderValue, minOrderValue) || other.minOrderValue == minOrderValue)&&(identical(other.maxDiscount, maxDiscount) || other.maxDiscount == maxDiscount)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,title,description,discountType,value,expiresAt,minOrderValue,maxDiscount,isActive);

@override
String toString() {
  return 'Coupon(code: $code, title: $title, description: $description, discountType: $discountType, value: $value, expiresAt: $expiresAt, minOrderValue: $minOrderValue, maxDiscount: $maxDiscount, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$CouponCopyWith<$Res> implements $CouponCopyWith<$Res> {
  factory _$CouponCopyWith(_Coupon value, $Res Function(_Coupon) _then) = __$CouponCopyWithImpl;
@override @useResult
$Res call({
 String code, String title, String description, DiscountType discountType, double value, DateTime expiresAt, double minOrderValue, double? maxDiscount, bool isActive
});




}
/// @nodoc
class __$CouponCopyWithImpl<$Res>
    implements _$CouponCopyWith<$Res> {
  __$CouponCopyWithImpl(this._self, this._then);

  final _Coupon _self;
  final $Res Function(_Coupon) _then;

/// Create a copy of Coupon
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? title = null,Object? description = null,Object? discountType = null,Object? value = null,Object? expiresAt = null,Object? minOrderValue = null,Object? maxDiscount = freezed,Object? isActive = null,}) {
  return _then(_Coupon(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,discountType: null == discountType ? _self.discountType : discountType // ignore: cast_nullable_to_non_nullable
as DiscountType,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,minOrderValue: null == minOrderValue ? _self.minOrderValue : minOrderValue // ignore: cast_nullable_to_non_nullable
as double,maxDiscount: freezed == maxDiscount ? _self.maxDiscount : maxDiscount // ignore: cast_nullable_to_non_nullable
as double?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
