import 'package:equatable/equatable.dart';

enum FlightCategory { vfr, mvfr, ifr, lifr, unknown }

class WeatherReport extends Equatable {
  const WeatherReport({
    required this.airportId,
    required this.rawMetar,
    required this.rawTaf,
    required this.category,
    required this.timestamp,
    this.tempC,
    this.windDir,
    this.windSpeed,
    this.cloudCover,
  });
  final String airportId;
  final String rawMetar;
  final String rawTaf;
  final FlightCategory category;
  final DateTime timestamp;

  final double? tempC;
  final int? windDir;
  final int? windSpeed;
  final String? cloudCover;

  @override
  List<Object?> get props => [
    airportId,
    rawMetar,
    rawTaf,
    category,
    timestamp,
    tempC,
    windDir,
    windSpeed,
    cloudCover,
  ];
}
