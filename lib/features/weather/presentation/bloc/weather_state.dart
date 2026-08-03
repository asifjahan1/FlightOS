import 'package:equatable/equatable.dart';
import 'package:skynav/features/weather/domain/entities/weather_data.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Map<String, WeatherReport> reports;
  final bool isRadarVisible;

  const WeatherLoaded({
    required this.reports,
    this.isRadarVisible = false,
  });

  WeatherLoaded copyWith({
    Map<String, WeatherReport>? reports,
    bool? isRadarVisible,
  }) {
    return WeatherLoaded(
      reports: reports ?? this.reports,
      isRadarVisible: isRadarVisible ?? this.isRadarVisible,
    );
  }

  @override
  List<Object?> get props => [reports, isRadarVisible];
}
