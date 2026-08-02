// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'frequency.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Frequency {

 int get id; String get airportIcao; String get type;// e.g., TWR, APP, GND, ATIS
 double get frequency;// e.g., 118.1
 String? get description;
/// Create a copy of Frequency
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FrequencyCopyWith<Frequency> get copyWith => _$FrequencyCopyWithImpl<Frequency>(this as Frequency, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Frequency&&(identical(other.id, id) || other.id == id)&&(identical(other.airportIcao, airportIcao) || other.airportIcao == airportIcao)&&(identical(other.type, type) || other.type == type)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,id,airportIcao,type,frequency,description);

@override
String toString() {
  return 'Frequency(id: $id, airportIcao: $airportIcao, type: $type, frequency: $frequency, description: $description)';
}


}

/// @nodoc
abstract mixin class $FrequencyCopyWith<$Res>  {
  factory $FrequencyCopyWith(Frequency value, $Res Function(Frequency) _then) = _$FrequencyCopyWithImpl;
@useResult
$Res call({
 int id, String airportIcao, String type, double frequency, String? description
});




}
/// @nodoc
class _$FrequencyCopyWithImpl<$Res>
    implements $FrequencyCopyWith<$Res> {
  _$FrequencyCopyWithImpl(this._self, this._then);

  final Frequency _self;
  final $Res Function(Frequency) _then;

/// Create a copy of Frequency
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? airportIcao = null,Object? type = null,Object? frequency = null,Object? description = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,airportIcao: null == airportIcao ? _self.airportIcao : airportIcao // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as double,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Frequency].
extension FrequencyPatterns on Frequency {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Frequency value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Frequency() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Frequency value)  $default,){
final _that = this;
switch (_that) {
case _Frequency():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Frequency value)?  $default,){
final _that = this;
switch (_that) {
case _Frequency() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String airportIcao,  String type,  double frequency,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Frequency() when $default != null:
return $default(_that.id,_that.airportIcao,_that.type,_that.frequency,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String airportIcao,  String type,  double frequency,  String? description)  $default,) {final _that = this;
switch (_that) {
case _Frequency():
return $default(_that.id,_that.airportIcao,_that.type,_that.frequency,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String airportIcao,  String type,  double frequency,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _Frequency() when $default != null:
return $default(_that.id,_that.airportIcao,_that.type,_that.frequency,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _Frequency implements Frequency {
  const _Frequency({required this.id, required this.airportIcao, required this.type, required this.frequency, this.description});
  

@override final  int id;
@override final  String airportIcao;
@override final  String type;
// e.g., TWR, APP, GND, ATIS
@override final  double frequency;
// e.g., 118.1
@override final  String? description;

/// Create a copy of Frequency
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FrequencyCopyWith<_Frequency> get copyWith => __$FrequencyCopyWithImpl<_Frequency>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Frequency&&(identical(other.id, id) || other.id == id)&&(identical(other.airportIcao, airportIcao) || other.airportIcao == airportIcao)&&(identical(other.type, type) || other.type == type)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,id,airportIcao,type,frequency,description);

@override
String toString() {
  return 'Frequency(id: $id, airportIcao: $airportIcao, type: $type, frequency: $frequency, description: $description)';
}


}

/// @nodoc
abstract mixin class _$FrequencyCopyWith<$Res> implements $FrequencyCopyWith<$Res> {
  factory _$FrequencyCopyWith(_Frequency value, $Res Function(_Frequency) _then) = __$FrequencyCopyWithImpl;
@override @useResult
$Res call({
 int id, String airportIcao, String type, double frequency, String? description
});




}
/// @nodoc
class __$FrequencyCopyWithImpl<$Res>
    implements _$FrequencyCopyWith<$Res> {
  __$FrequencyCopyWithImpl(this._self, this._then);

  final _Frequency _self;
  final $Res Function(_Frequency) _then;

/// Create a copy of Frequency
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? airportIcao = null,Object? type = null,Object? frequency = null,Object? description = freezed,}) {
  return _then(_Frequency(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,airportIcao: null == airportIcao ? _self.airportIcao : airportIcao // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as double,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
