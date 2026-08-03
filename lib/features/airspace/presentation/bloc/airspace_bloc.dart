import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skynav/features/airspace/data/airspace_service.dart';
import 'package:skynav/features/airspace/domain/entities/airspace.dart';
import 'package:skynav/features/airspace/presentation/bloc/airspace_event.dart';
import 'package:skynav/features/airspace/presentation/bloc/airspace_state.dart';

@injectable
class AirspaceBloc extends Bloc<AirspaceEvent, AirspaceState> {
  final AirspaceService _service;

  AirspaceBloc(this._service) : super(AirspaceInitial()) {
    on<AirspacesLoaded>(_onAirspacesLoaded);
    on<AirspaceLocationUpdated>(_onLocationUpdated);
  }

  Future<void> _onAirspacesLoaded(AirspacesLoaded event, Emitter<AirspaceState> emit) async {
    emit(AirspaceLoading());
    try {
      final airspaces = await _service.getAirspaces();
      emit(AirspaceLoaded(airspaces: airspaces));
    } catch (e) {
      emit(AirspaceError(e.toString()));
    }
  }

  void _onLocationUpdated(AirspaceLocationUpdated event, Emitter<AirspaceState> emit) {
    if (state is! AirspaceLoaded) return;
    final currentState = state as AirspaceLoaded;

    Airspace? activeAlert;
    
    // Check if the current location is inside any airspace polygon and within its vertical bounds
    for (final airspace in currentState.airspaces) {
      if (event.altitude >= airspace.floorAltitude && event.altitude <= airspace.ceilingAltitude) {
        if (airspace.contains(event.latitude, event.longitude)) {
          activeAlert = airspace;
          break; // Stop at the first airspace we are inside for simplicity
        }
      }
    }

    if (currentState.currentAlert != activeAlert) {
      if (activeAlert == null) {
        emit(currentState.copyWith(clearAlert: true));
      } else {
        emit(currentState.copyWith(currentAlert: activeAlert));
      }
    }
  }
}
