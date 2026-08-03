import 'package:equatable/equatable.dart';

enum FlightCategory {
  vfr,
  mvfr,
  ifr,
  lifr,
  unknown
}

class WeatherReport extends Equatable {
  final String airportId;
  final String rawMetar;
  final String rawTaf;
  final FlightCategory category;
  final DateTime timestamp;

  const WeatherReport({
    required this.airportId,
    required this.rawMetar,
    required this.rawTaf,
    required this.category,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [airportId, rawMetar, rawTaf, category, timestamp];
}
