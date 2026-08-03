import 'package:equatable/equatable.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class FetchWeatherForAirports extends WeatherEvent {
  const FetchWeatherForAirports(this.airportIds);
  final List<String> airportIds;

  @override
  List<Object?> get props => [airportIds];
}

class ToggleWeatherRadar extends WeatherEvent {}
