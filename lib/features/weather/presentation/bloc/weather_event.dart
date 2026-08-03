import 'package:equatable/equatable.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class FetchWeatherForAirports extends WeatherEvent {
  final List<String> airportIds;

  const FetchWeatherForAirports(this.airportIds);

  @override
  List<Object?> get props => [airportIds];
}

class ToggleWeatherRadar extends WeatherEvent {}
