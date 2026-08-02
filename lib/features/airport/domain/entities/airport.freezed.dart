// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'airport.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Airport {

 String get icao; String? get iata; String get name; double get latitude; double get longitude; double get elevation;// in feet
 String get type;
/// Create a copy of Airport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AirportCopyWith<Airport> get copyWith => _$AirportCopyWithImpl<Airport>(this as Airport, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Airport&&(identical(other.icao, icao) || other.icao == icao)&&(identical(other.iata, iata) || other.iata == iata)&&(identical(other.name, name) || other.name == name)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.elevation, elevation) || other.elevation == elevation)&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,icao,iata,name,latitude,longitude,elevation,type);

@override
String toString() {
  return 'Airport(icao: $icao, iata: $iata, name: $name, latitude: $latitude, longitude: $longitude, elevation: $elevation, type: $type)';
}


}

/// @nodoc
abstract mixin class $AirportCopyWith<$Res>  {
  factory $AirportCopyWith(Airport value, $Res Function(Airport) _then) = _$AirportCopyWithImpl;
@useResult
$Res call({
 String icao, String? iata, String name, double latitude, double longitude, double elevation, String type
});




}
/// @nodoc
class _$AirportCopyWithImpl<$Res>
    implements $AirportCopyWith<$Res> {
  _$AirportCopyWithImpl(this._self, this._then);

  final Airport _self;
  final $Res Function(Airport) _then;

/// Create a copy of Airport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? icao = null,Object? iata = freezed,Object? name = null,Object? latitude = null,Object? longitude = null,Object? elevation = null,Object? type = null,}) {
  return _then(_self.copyWith(
icao: null == icao ? _self.icao : icao // ignore: cast_nullable_to_non_nullable
as String,iata: freezed == iata ? _self.iata : iata // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,elevation: null == elevation ? _self.elevation : elevation // ignore: cast_nullable_to_non_nullable
as double,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Airport].
extension AirportPatterns on Airport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Airport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Airport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Airport value)  $default,){
final _that = this;
switch (_that) {
case _Airport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Airport value)?  $default,){
final _that = this;
switch (_that) {
case _Airport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String icao,  String? iata,  String name,  double latitude,  double longitude,  double elevation,  String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Airport() when $default != null:
return $default(_that.icao,_that.iata,_that.name,_that.latitude,_that.longitude,_that.elevation,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String icao,  String? iata,  String name,  double latitude,  double longitude,  double elevation,  String type)  $default,) {final _that = this;
switch (_that) {
case _Airport():
return $default(_that.icao,_that.iata,_that.name,_that.latitude,_that.longitude,_that.elevation,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String icao,  String? iata,  String name,  double latitude,  double longitude,  double elevation,  String type)?  $default,) {final _that = this;
switch (_that) {
case _Airport() when $default != null:
return $default(_that.icao,_that.iata,_that.name,_that.latitude,_that.longitude,_that.elevation,_that.type);case _:
  return null;

}
}

}

/// @nodoc


class _Airport implements Airport {
  const _Airport({required this.icao, this.iata, required this.name, required this.latitude, required this.longitude, required this.elevation, required this.type});
  

@override final  String icao;
@override final  String? iata;
@override final  String name;
@override final  double latitude;
@override final  double longitude;
@override final  double elevation;
// in feet
@override final  String type;

/// Create a copy of Airport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AirportCopyWith<_Airport> get copyWith => __$AirportCopyWithImpl<_Airport>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Airport&&(identical(other.icao, icao) || other.icao == icao)&&(identical(other.iata, iata) || other.iata == iata)&&(identical(other.name, name) || other.name == name)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.elevation, elevation) || other.elevation == elevation)&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,icao,iata,name,latitude,longitude,elevation,type);

@override
String toString() {
  return 'Airport(icao: $icao, iata: $iata, name: $name, latitude: $latitude, longitude: $longitude, elevation: $elevation, type: $type)';
}


}

/// @nodoc
abstract mixin class _$AirportCopyWith<$Res> implements $AirportCopyWith<$Res> {
  factory _$AirportCopyWith(_Airport value, $Res Function(_Airport) _then) = __$AirportCopyWithImpl;
@override @useResult
$Res call({
 String icao, String? iata, String name, double latitude, double longitude, double elevation, String type
});




}
/// @nodoc
class __$AirportCopyWithImpl<$Res>
    implements _$AirportCopyWith<$Res> {
  __$AirportCopyWithImpl(this._self, this._then);

  final _Airport _self;
  final $Res Function(_Airport) _then;

/// Create a copy of Airport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? icao = null,Object? iata = freezed,Object? name = null,Object? latitude = null,Object? longitude = null,Object? elevation = null,Object? type = null,}) {
  return _then(_Airport(
icao: null == icao ? _self.icao : icao // ignore: cast_nullable_to_non_nullable
as String,iata: freezed == iata ? _self.iata : iata // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,elevation: null == elevation ? _self.elevation : elevation // ignore: cast_nullable_to_non_nullable
as double,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
