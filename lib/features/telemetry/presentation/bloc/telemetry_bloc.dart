import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:skynav/core/location/location_service.dart';
import 'package:skynav/features/telemetry/data/services/fleet_tracking_service.dart';
import 'package:skynav/features/telemetry/domain/entities/telemetry_data.dart';

// ── Events ──
sealed class TelemetryEvent extends Equatable {
  const TelemetryEvent();

  @override
  List<Object?> get props => [];
}

class TelemetryStarted extends TelemetryEvent {
  const TelemetryStarted();
}

class _TelemetryUpdated extends TelemetryEvent {
  const _TelemetryUpdated(this.data);
  final TelemetryData data;

  @override
  List<Object?> get props => [data];
}

class TelemetryFollowToggled extends TelemetryEvent {
  const TelemetryFollowToggled();
}

class TelemetryDestinationSet extends TelemetryEvent {
  const TelemetryDestinationSet(this.destination);
  final LatLng destination;

  @override
  List<Object?> get props => [destination];
}

class TelemetryDestinationCleared extends TelemetryEvent {
  const TelemetryDestinationCleared();
}

// ── States ──
sealed class TelemetryState extends Equatable {
  const TelemetryState();

  @override
  List<Object?> get props => [];
}

class TelemetryInitial extends TelemetryState {
  const TelemetryInitial();
}

class TelemetryActive extends TelemetryState {
  const TelemetryActive({
    required this.data,
    this.followModeEnabled = false,
  });

  final TelemetryData data;
  final bool followModeEnabled;

  TelemetryActive copyWith({
    TelemetryData? data,
    bool? followModeEnabled,
  }) {
    return TelemetryActive(
      data: data ?? this.data,
      followModeEnabled: followModeEnabled ?? this.followModeEnabled,
    );
  }

  @override
  List<Object?> get props => [data, followModeEnabled];
}

// ── BLoC ──
@injectable
class TelemetryBloc extends Bloc<TelemetryEvent, TelemetryState> {
  TelemetryBloc(this._locationService, this._fleetTrackingService) : super(const TelemetryInitial()) {
    on<TelemetryStarted>(_onStarted);
    on<_TelemetryUpdated>(_onUpdated);
    on<TelemetryFollowToggled>(_onFollowToggled);
    on<TelemetryDestinationSet>(_onDestinationSet);
    on<TelemetryDestinationCleared>(_onDestinationCleared);
  }

  final LocationService _locationService;
  final FleetTrackingService _fleetTrackingService;
  StreamSubscription<TelemetryData>? _positionSubscription;

  void _onStarted(TelemetryStarted event, Emitter<TelemetryState> emit) {
    _positionSubscription?.cancel();
    _positionSubscription = _locationService.getPositionStream().listen((data) {
      add(_TelemetryUpdated(data));
    });
  }

  void _onUpdated(_TelemetryUpdated event, Emitter<TelemetryState> emit) {
    var newData = event.data;
    
    // Preserve destination if it exists in the current active state
    if (state is TelemetryActive) {
      final activeState = state as TelemetryActive;
      if (activeState.data.destinationLatitude != null && activeState.data.destinationLongitude != null) {
        newData = newData.copyWith(
          destinationLatitude: activeState.data.destinationLatitude,
          destinationLongitude: activeState.data.destinationLongitude,
        );
      }
      emit(activeState.copyWith(data: newData));
    } else {
      emit(TelemetryActive(data: newData));
    }

    // Broadcast location (with destination if any) to fleet
    _fleetTrackingService.broadcastLocation(newData);
  }

  void _onFollowToggled(TelemetryFollowToggled event, Emitter<TelemetryState> emit) {
    if (state is TelemetryActive) {
      final active = state as TelemetryActive;
      emit(active.copyWith(followModeEnabled: !active.followModeEnabled));
    }
  }

  void _onDestinationSet(TelemetryDestinationSet event, Emitter<TelemetryState> emit) {
    if (state is TelemetryActive) {
      final active = state as TelemetryActive;
      final newData = active.data.copyWith(
        destinationLatitude: event.destination.latitude,
        destinationLongitude: event.destination.longitude,
      );
      emit(active.copyWith(data: newData));
      _fleetTrackingService.broadcastLocation(newData);
    }
  }

  void _onDestinationCleared(TelemetryDestinationCleared event, Emitter<TelemetryState> emit) {
    if (state is TelemetryActive) {
      final active = state as TelemetryActive;
      final newData = active.data.copyWith(clearDestination: true);
      emit(active.copyWith(data: newData));
      _fleetTrackingService.broadcastLocation(newData);
    }
  }

  @override
  Future<void> close() {
    _positionSubscription?.cancel();
    return super.close();
  }
}
