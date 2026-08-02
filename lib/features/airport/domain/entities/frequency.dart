import 'package:freezed_annotation/freezed_annotation.dart';

part 'frequency.freezed.dart';

@freezed
abstract class Frequency with _$Frequency {
  const factory Frequency({
    required int id,
    required String airportIcao,
    required String type, // e.g., TWR, APP, GND, ATIS
    required double frequency, // e.g., 118.1
    String? description,
  }) = _Frequency;
}
