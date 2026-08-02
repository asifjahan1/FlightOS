import 'package:freezed_annotation/freezed_annotation.dart';

part 'airport.freezed.dart';

@freezed
abstract class Airport with _$Airport {
  const factory Airport({
    required String icao,
    String? iata,
    required String name,
    required double latitude,
    required double longitude,
    required double elevation, // in feet
    required String type, // e.g., large_airport, medium_airport, small_airport
  }) = _Airport;
}
