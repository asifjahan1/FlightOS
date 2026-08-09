import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skynav/features/flight_plan/domain/entities/flight_plan.dart';
import 'package:skynav/features/flight_plan/domain/entities/waypoint.dart';

// ── Events ──

sealed class FlightPlanEvent extends Equatable {
  const FlightPlanEvent();

  @override
  List<Object?> get props => [];
}

class WaypointAdded extends FlightPlanEvent {
  const WaypointAdded(this.waypoint);
  final Waypoint waypoint;

  @override
  List<Object?> get props => [waypoint];
}

class WaypointRemoved extends FlightPlanEvent {
  const WaypointRemoved(this.index);
  final int index;

  @override
  List<Object?> get props => [index];
}

class FlightPlanCleared extends FlightPlanEvent {
  const FlightPlanCleared();
}

class CruiseSpeedUpdated extends FlightPlanEvent {
  const CruiseSpeedUpdated(this.speedKnots);
  final double speedKnots;

  @override
  List<Object?> get props => [speedKnots];
}

class DestinationSet extends FlightPlanEvent {
  const DestinationSet(this.destination);
  final Waypoint destination;

  @override
  List<Object?> get props => [destination];
}

class DestinationCleared extends FlightPlanEvent {
  const DestinationCleared();
}

// ── States ──

sealed class FlightPlanState extends Equatable {
  const FlightPlanState();

  @override
  List<Object?> get props => [];
}

class FlightPlanInitial extends FlightPlanState {
  const FlightPlanInitial();
}

class FlightPlanActive extends FlightPlanState {
  const FlightPlanActive(this.flightPlan);
  final FlightPlan flightPlan;

  @override
  List<Object?> get props => [flightPlan];
}

// ── BLoC ──

@injectable
class FlightPlanBloc extends Bloc<FlightPlanEvent, FlightPlanState> {
  FlightPlanBloc() : super(const FlightPlanInitial()) {
    on<WaypointAdded>(_onWaypointAdded);
    on<WaypointRemoved>(_onWaypointRemoved);
    on<FlightPlanCleared>(_onFlightPlanCleared);
    on<CruiseSpeedUpdated>(_onCruiseSpeedUpdated);
    on<DestinationSet>(_onDestinationSet);
    on<DestinationCleared>(_onDestinationCleared);
  }

  void _onWaypointAdded(WaypointAdded event, Emitter<FlightPlanState> emit) {
    if (state is FlightPlanActive) {
      final currentPlan = (state as FlightPlanActive).flightPlan;
      final newWaypoints = List<Waypoint>.from(currentPlan.waypoints)
        ..add(event.waypoint);
      emit(FlightPlanActive(currentPlan.copyWith(waypoints: newWaypoints)));
    } else {
      emit(FlightPlanActive(FlightPlan(waypoints: [event.waypoint])));
    }
  }

  void _onWaypointRemoved(
    WaypointRemoved event,
    Emitter<FlightPlanState> emit,
  ) {
    if (state is FlightPlanActive) {
      final currentPlan = (state as FlightPlanActive).flightPlan;
      if (event.index >= 0 && event.index < currentPlan.waypoints.length) {
        final newWaypoints = List<Waypoint>.from(currentPlan.waypoints)
          ..removeAt(event.index);

        if (newWaypoints.isEmpty) {
          emit(const FlightPlanInitial());
        } else {
          emit(FlightPlanActive(currentPlan.copyWith(waypoints: newWaypoints)));
        }
      }
    }
  }

  void _onFlightPlanCleared(
    FlightPlanCleared event,
    Emitter<FlightPlanState> emit,
  ) {
    emit(const FlightPlanInitial());
  }

  void _onCruiseSpeedUpdated(
    CruiseSpeedUpdated event,
    Emitter<FlightPlanState> emit,
  ) {
    if (state is FlightPlanActive) {
      final currentPlan = (state as FlightPlanActive).flightPlan;
      emit(
        FlightPlanActive(
          currentPlan.copyWith(cruiseSpeedKnots: event.speedKnots),
        ),
      );
    }
  }

  void _onDestinationSet(DestinationSet event, Emitter<FlightPlanState> emit) {
    if (state is FlightPlanActive) {
      final currentPlan = (state as FlightPlanActive).flightPlan;
      emit(
        FlightPlanActive(currentPlan.copyWith(destination: event.destination)),
      );
    } else {
      emit(
        FlightPlanActive(
          FlightPlan(waypoints: const [], destination: event.destination),
        ),
      );
    }
  }

  void _onDestinationCleared(
    DestinationCleared event,
    Emitter<FlightPlanState> emit,
  ) {
    if (state is FlightPlanActive) {
      final currentPlan = (state as FlightPlanActive).flightPlan;
      final newPlan = currentPlan.copyWith(clearDestination: true);
      if (newPlan.waypoints.isEmpty) {
        emit(const FlightPlanInitial());
      } else {
        emit(FlightPlanActive(newPlan));
      }
    }
  }
}
