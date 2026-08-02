// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'runway.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Runway {

 int get id; String get airportIcao; double get length;// in feet
 double get width;// in feet
 String? get surface;// e.g., ASP, CON
 String get ident;
/// Create a copy of Runway
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RunwayCopyWith<Runway> get copyWith => _$RunwayCopyWithImpl<Runway>(this as Runway, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Runway&&(identical(other.id, id) || other.id == id)&&(identical(other.airportIcao, airportIcao) || other.airportIcao == airportIcao)&&(identical(other.length, length) || other.length == length)&&(identical(other.width, width) || other.width == width)&&(identical(other.surface, surface) || other.surface == surface)&&(identical(other.ident, ident) || other.ident == ident));
}


@override
int get hashCode => Object.hash(runtimeType,id,airportIcao,length,width,surface,ident);

@override
String toString() {
  return 'Runway(id: $id, airportIcao: $airportIcao, length: $length, width: $width, surface: $surface, ident: $ident)';
}


}

/// @nodoc
abstract mixin class $RunwayCopyWith<$Res>  {
  factory $RunwayCopyWith(Runway value, $Res Function(Runway) _then) = _$RunwayCopyWithImpl;
@useResult
$Res call({
 int id, String airportIcao, double length, double width, String? surface, String ident
});




}
/// @nodoc
class _$RunwayCopyWithImpl<$Res>
    implements $RunwayCopyWith<$Res> {
  _$RunwayCopyWithImpl(this._self, this._then);

  final Runway _self;
  final $Res Function(Runway) _then;

/// Create a copy of Runway
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? airportIcao = null,Object? length = null,Object? width = null,Object? surface = freezed,Object? ident = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,airportIcao: null == airportIcao ? _self.airportIcao : airportIcao // ignore: cast_nullable_to_non_nullable
as String,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as double,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,surface: freezed == surface ? _self.surface : surface // ignore: cast_nullable_to_non_nullable
as String?,ident: null == ident ? _self.ident : ident // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Runway].
extension RunwayPatterns on Runway {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Runway value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Runway() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Runway value)  $default,){
final _that = this;
switch (_that) {
case _Runway():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Runway value)?  $default,){
final _that = this;
switch (_that) {
case _Runway() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String airportIcao,  double length,  double width,  String? surface,  String ident)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Runway() when $default != null:
return $default(_that.id,_that.airportIcao,_that.length,_that.width,_that.surface,_that.ident);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String airportIcao,  double length,  double width,  String? surface,  String ident)  $default,) {final _that = this;
switch (_that) {
case _Runway():
return $default(_that.id,_that.airportIcao,_that.length,_that.width,_that.surface,_that.ident);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String airportIcao,  double length,  double width,  String? surface,  String ident)?  $default,) {final _that = this;
switch (_that) {
case _Runway() when $default != null:
return $default(_that.id,_that.airportIcao,_that.length,_that.width,_that.surface,_that.ident);case _:
  return null;

}
}

}

/// @nodoc


class _Runway implements Runway {
  const _Runway({required this.id, required this.airportIcao, required this.length, required this.width, this.surface, required this.ident});
  

@override final  int id;
@override final  String airportIcao;
@override final  double length;
// in feet
@override final  double width;
// in feet
@override final  String? surface;
// e.g., ASP, CON
@override final  String ident;

/// Create a copy of Runway
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RunwayCopyWith<_Runway> get copyWith => __$RunwayCopyWithImpl<_Runway>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Runway&&(identical(other.id, id) || other.id == id)&&(identical(other.airportIcao, airportIcao) || other.airportIcao == airportIcao)&&(identical(other.length, length) || other.length == length)&&(identical(other.width, width) || other.width == width)&&(identical(other.surface, surface) || other.surface == surface)&&(identical(other.ident, ident) || other.ident == ident));
}


@override
int get hashCode => Object.hash(runtimeType,id,airportIcao,length,width,surface,ident);

@override
String toString() {
  return 'Runway(id: $id, airportIcao: $airportIcao, length: $length, width: $width, surface: $surface, ident: $ident)';
}


}

/// @nodoc
abstract mixin class _$RunwayCopyWith<$Res> implements $RunwayCopyWith<$Res> {
  factory _$RunwayCopyWith(_Runway value, $Res Function(_Runway) _then) = __$RunwayCopyWithImpl;
@override @useResult
$Res call({
 int id, String airportIcao, double length, double width, String? surface, String ident
});




}
/// @nodoc
class __$RunwayCopyWithImpl<$Res>
    implements _$RunwayCopyWith<$Res> {
  __$RunwayCopyWithImpl(this._self, this._then);

  final _Runway _self;
  final $Res Function(_Runway) _then;

/// Create a copy of Runway
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? airportIcao = null,Object? length = null,Object? width = null,Object? surface = freezed,Object? ident = null,}) {
  return _then(_Runway(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,airportIcao: null == airportIcao ? _self.airportIcao : airportIcao // ignore: cast_nullable_to_non_nullable
as String,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as double,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,surface: freezed == surface ? _self.surface : surface // ignore: cast_nullable_to_non_nullable
as String?,ident: null == ident ? _self.ident : ident // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
