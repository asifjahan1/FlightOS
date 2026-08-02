import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skynav/core/traffic/traffic_service.dart';
import 'package:skynav/features/traffic/domain/entities/traffic_target.dart';

// ── Events ──
sealed class TrafficEvent extends Equatable {
  const TrafficEvent();

  @override
  List<Object?> get props => [];
}

class TrafficStarted extends TrafficEvent {
  const TrafficStarted();
}

class _TrafficUpdated extends TrafficEvent {
  const _TrafficUpdated(this.targets);
  final List<TrafficTarget> targets;

  @override
  List<Object?> get props => [targets];
}

// ── States ──
sealed class TrafficState extends Equatable {
  const TrafficState();

  @override
  List<Object?> get props => [];
}

class TrafficInitial extends TrafficState {
  const TrafficInitial();
}

class TrafficActive extends TrafficState {
  const TrafficActive({required this.targets});

  final List<TrafficTarget> targets;

  @override
  List<Object?> get props => [targets];
}

// ── BLoC ──
@injectable
class TrafficBloc extends Bloc<TrafficEvent, TrafficState> {
  TrafficBloc(this._trafficService) : super(const TrafficInitial()) {
    on<TrafficStarted>(_onStarted);
    on<_TrafficUpdated>(_onUpdated);
  }

  final TrafficService _trafficService;
  StreamSubscription<List<TrafficTarget>>? _subscription;

  void _onStarted(TrafficStarted event, Emitter<TrafficState> emit) {
    _subscription?.cancel();
    _subscription = _trafficService.getTrafficStream().listen((targets) {
      add(_TrafficUpdated(targets));
    });
  }

  void _onUpdated(_TrafficUpdated event, Emitter<TrafficState> emit) {
    emit(TrafficActive(targets: event.targets));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
