import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skynav/core/location/location_service.dart';
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
  TelemetryBloc(this._locationService) : super(const TelemetryInitial()) {
    on<TelemetryStarted>(_onStarted);
    on<_TelemetryUpdated>(_onUpdated);
    on<TelemetryFollowToggled>(_onFollowToggled);
  }

  final LocationService _locationService;
  StreamSubscription<TelemetryData>? _positionSubscription;

  void _onStarted(TelemetryStarted event, Emitter<TelemetryState> emit) {
    _positionSubscription?.cancel();
    _positionSubscription = _locationService.getPositionStream().listen((data) {
      add(_TelemetryUpdated(data));
    });
  }

  void _onUpdated(_TelemetryUpdated event, Emitter<TelemetryState> emit) {
    if (state is TelemetryActive) {
      emit((state as TelemetryActive).copyWith(data: event.data));
    } else {
      emit(TelemetryActive(data: event.data));
    }
  }

  void _onFollowToggled(TelemetryFollowToggled event, Emitter<TelemetryState> emit) {
    if (state is TelemetryActive) {
      final active = state as TelemetryActive;
      emit(active.copyWith(followModeEnabled: !active.followModeEnabled));
    }
  }

  @override
  Future<void> close() {
    _positionSubscription?.cancel();
    return super.close();
  }
}
