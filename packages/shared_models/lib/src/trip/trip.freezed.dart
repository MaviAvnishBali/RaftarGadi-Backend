// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TripEvent {

 TripStatus get status; DateTime get timestamp; String? get note;
/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripEventCopyWith<TripEvent> get copyWith => _$TripEventCopyWithImpl<TripEvent>(this as TripEvent, _$identity);

  /// Serializes this TripEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripEvent&&(identical(other.status, status) || other.status == status)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,timestamp,note);

@override
String toString() {
  return 'TripEvent(status: $status, timestamp: $timestamp, note: $note)';
}


}

/// @nodoc
abstract mixin class $TripEventCopyWith<$Res>  {
  factory $TripEventCopyWith(TripEvent value, $Res Function(TripEvent) _then) = _$TripEventCopyWithImpl;
@useResult
$Res call({
 TripStatus status, DateTime timestamp, String? note
});




}
/// @nodoc
class _$TripEventCopyWithImpl<$Res>
    implements $TripEventCopyWith<$Res> {
  _$TripEventCopyWithImpl(this._self, this._then);

  final TripEvent _self;
  final $Res Function(TripEvent) _then;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? timestamp = null,Object? note = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TripStatus,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TripEvent].
extension TripEventPatterns on TripEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripEvent value)  $default,){
final _that = this;
switch (_that) {
case _TripEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripEvent value)?  $default,){
final _that = this;
switch (_that) {
case _TripEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TripStatus status,  DateTime timestamp,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripEvent() when $default != null:
return $default(_that.status,_that.timestamp,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TripStatus status,  DateTime timestamp,  String? note)  $default,) {final _that = this;
switch (_that) {
case _TripEvent():
return $default(_that.status,_that.timestamp,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TripStatus status,  DateTime timestamp,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _TripEvent() when $default != null:
return $default(_that.status,_that.timestamp,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripEvent implements TripEvent {
  const _TripEvent({required this.status, required this.timestamp, this.note});
  factory _TripEvent.fromJson(Map<String, dynamic> json) => _$TripEventFromJson(json);

@override final  TripStatus status;
@override final  DateTime timestamp;
@override final  String? note;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripEventCopyWith<_TripEvent> get copyWith => __$TripEventCopyWithImpl<_TripEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripEvent&&(identical(other.status, status) || other.status == status)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,timestamp,note);

@override
String toString() {
  return 'TripEvent(status: $status, timestamp: $timestamp, note: $note)';
}


}

/// @nodoc
abstract mixin class _$TripEventCopyWith<$Res> implements $TripEventCopyWith<$Res> {
  factory _$TripEventCopyWith(_TripEvent value, $Res Function(_TripEvent) _then) = __$TripEventCopyWithImpl;
@override @useResult
$Res call({
 TripStatus status, DateTime timestamp, String? note
});




}
/// @nodoc
class __$TripEventCopyWithImpl<$Res>
    implements _$TripEventCopyWith<$Res> {
  __$TripEventCopyWithImpl(this._self, this._then);

  final _TripEvent _self;
  final $Res Function(_TripEvent) _then;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? timestamp = null,Object? note = freezed,}) {
  return _then(_TripEvent(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TripStatus,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Trip {

 String get id; String get bookingId; String get driverId; TripStatus get status; GeoPoint? get driverLocation; List<TripEvent> get events; DateTime? get startedAt; DateTime? get completedAt;
/// Create a copy of Trip
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripCopyWith<Trip> get copyWith => _$TripCopyWithImpl<Trip>(this as Trip, _$identity);

  /// Serializes this Trip to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Trip&&(identical(other.id, id) || other.id == id)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.status, status) || other.status == status)&&(identical(other.driverLocation, driverLocation) || other.driverLocation == driverLocation)&&const DeepCollectionEquality().equals(other.events, events)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,bookingId,driverId,status,driverLocation,const DeepCollectionEquality().hash(events),startedAt,completedAt);

@override
String toString() {
  return 'Trip(id: $id, bookingId: $bookingId, driverId: $driverId, status: $status, driverLocation: $driverLocation, events: $events, startedAt: $startedAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class $TripCopyWith<$Res>  {
  factory $TripCopyWith(Trip value, $Res Function(Trip) _then) = _$TripCopyWithImpl;
@useResult
$Res call({
 String id, String bookingId, String driverId, TripStatus status, GeoPoint? driverLocation, List<TripEvent> events, DateTime? startedAt, DateTime? completedAt
});


$GeoPointCopyWith<$Res>? get driverLocation;

}
/// @nodoc
class _$TripCopyWithImpl<$Res>
    implements $TripCopyWith<$Res> {
  _$TripCopyWithImpl(this._self, this._then);

  final Trip _self;
  final $Res Function(Trip) _then;

/// Create a copy of Trip
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? bookingId = null,Object? driverId = null,Object? status = null,Object? driverLocation = freezed,Object? events = null,Object? startedAt = freezed,Object? completedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String,driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TripStatus,driverLocation: freezed == driverLocation ? _self.driverLocation : driverLocation // ignore: cast_nullable_to_non_nullable
as GeoPoint?,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<TripEvent>,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of Trip
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res>? get driverLocation {
    if (_self.driverLocation == null) {
    return null;
  }

  return $GeoPointCopyWith<$Res>(_self.driverLocation!, (value) {
    return _then(_self.copyWith(driverLocation: value));
  });
}
}


/// Adds pattern-matching-related methods to [Trip].
extension TripPatterns on Trip {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Trip value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Trip() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Trip value)  $default,){
final _that = this;
switch (_that) {
case _Trip():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Trip value)?  $default,){
final _that = this;
switch (_that) {
case _Trip() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String bookingId,  String driverId,  TripStatus status,  GeoPoint? driverLocation,  List<TripEvent> events,  DateTime? startedAt,  DateTime? completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Trip() when $default != null:
return $default(_that.id,_that.bookingId,_that.driverId,_that.status,_that.driverLocation,_that.events,_that.startedAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String bookingId,  String driverId,  TripStatus status,  GeoPoint? driverLocation,  List<TripEvent> events,  DateTime? startedAt,  DateTime? completedAt)  $default,) {final _that = this;
switch (_that) {
case _Trip():
return $default(_that.id,_that.bookingId,_that.driverId,_that.status,_that.driverLocation,_that.events,_that.startedAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String bookingId,  String driverId,  TripStatus status,  GeoPoint? driverLocation,  List<TripEvent> events,  DateTime? startedAt,  DateTime? completedAt)?  $default,) {final _that = this;
switch (_that) {
case _Trip() when $default != null:
return $default(_that.id,_that.bookingId,_that.driverId,_that.status,_that.driverLocation,_that.events,_that.startedAt,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Trip implements Trip {
  const _Trip({required this.id, required this.bookingId, required this.driverId, this.status = TripStatus.assigned, this.driverLocation, final  List<TripEvent> events = const <TripEvent>[], this.startedAt, this.completedAt}): _events = events;
  factory _Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);

@override final  String id;
@override final  String bookingId;
@override final  String driverId;
@override@JsonKey() final  TripStatus status;
@override final  GeoPoint? driverLocation;
 final  List<TripEvent> _events;
@override@JsonKey() List<TripEvent> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}

@override final  DateTime? startedAt;
@override final  DateTime? completedAt;

/// Create a copy of Trip
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripCopyWith<_Trip> get copyWith => __$TripCopyWithImpl<_Trip>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Trip&&(identical(other.id, id) || other.id == id)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.status, status) || other.status == status)&&(identical(other.driverLocation, driverLocation) || other.driverLocation == driverLocation)&&const DeepCollectionEquality().equals(other._events, _events)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,bookingId,driverId,status,driverLocation,const DeepCollectionEquality().hash(_events),startedAt,completedAt);

@override
String toString() {
  return 'Trip(id: $id, bookingId: $bookingId, driverId: $driverId, status: $status, driverLocation: $driverLocation, events: $events, startedAt: $startedAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$TripCopyWith<$Res> implements $TripCopyWith<$Res> {
  factory _$TripCopyWith(_Trip value, $Res Function(_Trip) _then) = __$TripCopyWithImpl;
@override @useResult
$Res call({
 String id, String bookingId, String driverId, TripStatus status, GeoPoint? driverLocation, List<TripEvent> events, DateTime? startedAt, DateTime? completedAt
});


@override $GeoPointCopyWith<$Res>? get driverLocation;

}
/// @nodoc
class __$TripCopyWithImpl<$Res>
    implements _$TripCopyWith<$Res> {
  __$TripCopyWithImpl(this._self, this._then);

  final _Trip _self;
  final $Res Function(_Trip) _then;

/// Create a copy of Trip
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? bookingId = null,Object? driverId = null,Object? status = null,Object? driverLocation = freezed,Object? events = null,Object? startedAt = freezed,Object? completedAt = freezed,}) {
  return _then(_Trip(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String,driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TripStatus,driverLocation: freezed == driverLocation ? _self.driverLocation : driverLocation // ignore: cast_nullable_to_non_nullable
as GeoPoint?,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<TripEvent>,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of Trip
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res>? get driverLocation {
    if (_self.driverLocation == null) {
    return null;
  }

  return $GeoPointCopyWith<$Res>(_self.driverLocation!, (value) {
    return _then(_self.copyWith(driverLocation: value));
  });
}
}

// dart format on
