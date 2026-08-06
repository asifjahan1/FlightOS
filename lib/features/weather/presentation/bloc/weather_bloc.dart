import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skynav/features/weather/data/weather_service.dart';
import 'package:skynav/features/weather/domain/entities/weather_data.dart';
import 'package:skynav/features/weather/presentation/bloc/weather_event.dart';
import 'package:skynav/features/weather/presentation/bloc/weather_state.dart';

@injectable
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  WeatherBloc(this._service) : super(WeatherInitial()) {
    on<FetchWeatherForAirports>(_onFetchWeather);
    on<ToggleWeatherRadar>(_onToggleRadar);
  }
  final WeatherService _service;

  Future<void> _onFetchWeather(FetchWeatherForAirports event, Emitter<WeatherState> emit) async {
    final currentState = state;
    var currentReports = <String, WeatherReport>{};
    var radarVisible = false;

    if (currentState is WeatherLoaded) {
      currentReports = Map.from(currentState.reports);
      radarVisible = currentState.isRadarVisible;
    }

    final newIds = event.airportIds.where((id) => !currentReports.containsKey(id)).toList();
    
    if (newIds.isNotEmpty) {
      final newReports = await _service.getWeatherForAirports(newIds);
      for (final report in newReports) {
        currentReports[report.airportId] = report;
      }
    }

    emit(WeatherLoaded(reports: currentReports, isRadarVisible: radarVisible));
  }

  void _onToggleRadar(ToggleWeatherRadar event, Emitter<WeatherState> emit) {
    if (state is WeatherLoaded) {
      final currentState = state as WeatherLoaded;
      emit(currentState.copyWith(isRadarVisible: !currentState.isRadarVisible));
    } else {
      emit(const WeatherLoaded(reports: {}, isRadarVisible: true));
    }
  }
}
