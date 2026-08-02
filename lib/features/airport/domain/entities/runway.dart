import 'package:freezed_annotation/freezed_annotation.dart';

part 'runway.freezed.dart';

@freezed
abstract class Runway with _$Runway {
  const factory Runway({
    required int id,
    required String airportIcao,
    required double length, // in feet
    required double width, // in feet
    String? surface, // e.g., ASP, CON
    required String ident, // e.g., 09/27
  }) = _Runway;
}
