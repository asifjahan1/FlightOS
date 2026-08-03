import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skynav/features/terrain/data/terrain_service.dart';
import 'package:skynav/features/terrain/presentation/bloc/terrain_event.dart';
import 'package:skynav/features/terrain/presentation/bloc/terrain_state.dart';

@injectable
class TerrainBloc extends Bloc<TerrainEvent, TerrainState> {
  TerrainBloc(this._service) : super(TerrainInitial()) {
    on<TerrainLocationUpdated>(_onLocationUpdated);
  }
  final TerrainService _service;

  double? _lastAltitude;
  DateTime? _lastUpdate;

  void _onLocationUpdated(
    TerrainLocationUpdated event,
    Emitter<TerrainState> emit,
  ) {
    final terrainElevation = _service.getElevationAt(
      event.latitude,
      event.longitude,
    );
    final agl = event.altitudeMsl - terrainElevation;

    var isDescending = false;
    final now = DateTime.now();
    if (_lastAltitude != null && _lastUpdate != null) {
      final dt = now.difference(_lastUpdate!).inSeconds;
      if (dt > 0) {
        final fpm = (event.altitudeMsl - _lastAltitude!) / (dt / 60.0);
        if (fpm < -500) {
          isDescending = true;
        }
      }
    }

    _lastAltitude = event.altitudeMsl;
    _lastUpdate = now;

    final alert = (agl < 500 && isDescending) || (agl < 200);

    emit(
      TerrainUpdated(
        currentElevation: terrainElevation,
        agl: agl,
        isTawsAlertActive: alert,
      ),
    );
  }
}
