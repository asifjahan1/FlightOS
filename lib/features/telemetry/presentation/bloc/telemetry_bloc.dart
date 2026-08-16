import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:skynav/core/location/location_service.dart';
import 'package:skynav/features/bluetooth/domain/entities/cockpit_telemetry.dart';
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

/// Merge cockpit data from Bluetooth into telemetry.
///
/// When BLE cockpit data is available, it supplements/overrides GPS
/// data with higher-quality instrument readings (airspeed, altitude, etc.).
class TelemetryBleCockpitDataMerged extends TelemetryEvent {
  const TelemetryBleCockpitDataMerged(this.cockpitData);
  final CockpitTelemetry cockpitData;

  @override
  List<Object?> get props => [cockpitData];
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
  const TelemetryActive({required this.data, this.followModeEnabled = false});

  final TelemetryData data;
  final bool followModeEnabled;

  TelemetryActive copyWith({TelemetryData? data, bool? followModeEnabled}) {
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
  TelemetryBloc(this._locationService, this._fleetTrackingService)
    : super(const TelemetryInitial()) {
    on<TelemetryStarted>(_onStarted);
    on<_TelemetryUpdated>(_onUpdated);
    on<TelemetryFollowToggled>(_onFollowToggled);
    on<TelemetryDestinationSet>(_onDestinationSet);
    on<TelemetryDestinationCleared>(_onDestinationCleared);
    on<TelemetryBleCockpitDataMerged>(_onBleCockpitData);
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
      if (activeState.data.destinationLatitude != null &&
          activeState.data.destinationLongitude != null) {
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

  void _onFollowToggled(
    TelemetryFollowToggled event,
    Emitter<TelemetryState> emit,
  ) {
    if (state is TelemetryActive) {
      final active = state as TelemetryActive;
      emit(active.copyWith(followModeEnabled: !active.followModeEnabled));
    }
  }

  void _onDestinationSet(
    TelemetryDestinationSet event,
    Emitter<TelemetryState> emit,
  ) {
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

  void _onDestinationCleared(
    TelemetryDestinationCleared event,
    Emitter<TelemetryState> emit,
  ) {
    if (state is TelemetryActive) {
      final active = state as TelemetryActive;
      final newData = active.data.copyWith(clearDestination: true);
      emit(active.copyWith(data: newData));
      _fleetTrackingService.broadcastLocation(newData);
    }
  }

  /// Merges Bluetooth cockpit data into the current telemetry state.
  ///
  /// BLE cockpit data overrides GPS values for fields it provides (altitude,
  /// airspeed, heading), since cockpit instruments are more accurate than
  /// phone GPS. Fields not provided by the cockpit device are preserved
  /// from the existing GPS telemetry.
  void _onBleCockpitData(
    TelemetryBleCockpitDataMerged event,
    Emitter<TelemetryState> emit,
  ) {
    final cockpit = event.cockpitData;

    if (state is TelemetryActive) {
      final active = state as TelemetryActive;
      final current = active.data;

      // Override GPS data with cockpit instrument data where available
      final merged = current.copyWith(
        latitude: cockpit.latitude ?? current.latitude,
        longitude: cockpit.longitude ?? current.longitude,
        altitudeMslFeet: cockpit.altitudeMslFeet ?? current.altitudeMslFeet,
        groundSpeedKnots: cockpit.groundSpeedKnots ?? current.groundSpeedKnots,
        trueTrack: cockpit.trackTrueDeg ??
            cockpit.headingTrueDeg ??
            cockpit.headingMagneticDeg ??
            current.trueTrack,
      );

      emit(active.copyWith(data: merged));
      _fleetTrackingService.broadcastLocation(merged);
    } else {
      // No GPS data yet — create telemetry from cockpit data alone
      if (cockpit.latitude != null && cockpit.longitude != null) {
        final data = TelemetryData(
          latitude: cockpit.latitude!,
          longitude: cockpit.longitude!,
          altitudeMslFeet: cockpit.altitudeMslFeet ?? 0,
          groundSpeedKnots: cockpit.groundSpeedKnots ?? 0,
          trueTrack: cockpit.trackTrueDeg ??
              cockpit.headingTrueDeg ??
              cockpit.headingMagneticDeg ??
              0,
        );
        emit(TelemetryActive(data: data));
        _fleetTrackingService.broadcastLocation(data);
      }
    }
  }

  @override
  Future<void> close() {
    _positionSubscription?.cancel();
    return super.close();
  }
}
