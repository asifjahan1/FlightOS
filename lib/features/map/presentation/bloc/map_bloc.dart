/// Map BLoC — manages map state including viewport, layers, and interactions.
///
/// Events:
/// - [MapInitialized] — Load initial map state and offline tiles
/// - [MapMoved] — User panned/zoomed the map
/// - [MapLayerToggled] — Toggle a layer on/off
/// - [MapCenterOnLocation] — Center map on a specific location
/// - [MapZoomChanged] — Explicit zoom change
///
/// States:
/// - [MapInitial] — Before initialization
/// - [MapLoading] — Loading tiles and data
/// - [MapReady] — Map is interactive with current viewport state
/// - [MapError] — Failed to load map resources
library;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

import 'package:skynav/core/constants/map_constants.dart';
import 'package:skynav/features/airport/domain/entities/airport.dart';
import 'package:skynav/features/airport/domain/repositories/airport_repository.dart';

// ── Events ──

/// Base class for map events.
sealed class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object?> get props => [];
}

/// Initialize the map with default or persisted state.
class MapInitialized extends MapEvent {
  const MapInitialized();
}

/// The map viewport was moved (pan or zoom).
class MapMoved extends MapEvent {
  const MapMoved({
    required this.center,
    required this.zoom,
    required this.bounds,
  });

  final LatLng center;
  final double zoom;
  final MapBounds bounds;

  @override
  List<Object?> get props => [center, zoom, bounds];
}

/// Toggle a map layer's visibility.
class MapLayerToggled extends MapEvent {
  const MapLayerToggled({required this.layer});

  final MapLayerType layer;

  @override
  List<Object?> get props => [layer];
}

/// Center the map on a specific location.
class MapCenterOnLocation extends MapEvent {
  const MapCenterOnLocation({
    required this.location,
    this.zoom,
  });

  final LatLng location;
  final double? zoom;

  @override
  List<Object?> get props => [location, zoom];
}

/// Change the zoom level explicitly.
class MapZoomChanged extends MapEvent {
  const MapZoomChanged({required this.zoom});

  final double zoom;

  @override
  List<Object?> get props => [zoom];
}

// ── States ──

/// Base class for map states.
sealed class MapState extends Equatable {
  const MapState();

  @override
  List<Object?> get props => [];
}

/// Initial state before map is loaded.
class MapInitial extends MapState {
  const MapInitial();
}

/// Map is loading tiles or data.
class MapLoading extends MapState {
  const MapLoading();
}

/// Map is ready and interactive.
class MapReady extends MapState {
  const MapReady({
    required this.center,
    required this.zoom,
    required this.bounds,
    required this.visibleLayers,
    this.tilesLoaded = false,
    this.airports = const [],
  });

  final LatLng center;
  final double zoom;
  final MapBounds bounds;
  final Set<MapLayerType> visibleLayers;
  final bool tilesLoaded;
  final List<Airport> airports;

  MapReady copyWith({
    LatLng? center,
    double? zoom,
    MapBounds? bounds,
    Set<MapLayerType>? visibleLayers,
    bool? tilesLoaded,
    List<Airport>? airports,
  }) {
    return MapReady(
      center: center ?? this.center,
      zoom: zoom ?? this.zoom,
      bounds: bounds ?? this.bounds,
      visibleLayers: visibleLayers ?? this.visibleLayers,
      tilesLoaded: tilesLoaded ?? this.tilesLoaded,
      airports: airports ?? this.airports,
    );
  }

  @override
  List<Object?> get props => [center, zoom, bounds, visibleLayers, tilesLoaded, airports];
}

/// Map failed to load.
class MapError extends MapState {
  const MapError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

// ── Supporting Models ──

/// Map viewport bounding box.
class MapBounds extends Equatable {
  const MapBounds({
    required this.southWest,
    required this.northEast,
  });

  /// Creates a default bounds covering the entire world.
  const MapBounds.world()
      : southWest = const LatLng(-90, -180),
        northEast = const LatLng(90, 180);

  final LatLng southWest;
  final LatLng northEast;

  @override
  List<Object?> get props => [southWest, northEast];
}

/// Available map layers.
enum MapLayerType {
  basemap,
  airports,
  navaids,
  airspace,
  terrain,
  weather,
  traffic,
  route,
}

// ── BLoC ──

/// Map BLoC implementation.
@injectable
class MapBloc extends Bloc<MapEvent, MapState> {

  MapBloc(this._airportRepository) : super(const MapInitial()) {
    on<MapInitialized>(_onInitialized);
    on<MapMoved>(_onMoved);
    on<MapLayerToggled>(_onLayerToggled);
    on<MapCenterOnLocation>(_onCenterOnLocation);
    on<MapZoomChanged>(_onZoomChanged);
  }
  final AirportRepository _airportRepository;

  Future<void> _onInitialized(
    MapInitialized event,
    Emitter<MapState> emit,
  ) async {
    emit(const MapLoading());

    try {
      // Default visible layers for MVP
      final defaultLayers = <MapLayerType>{
        MapLayerType.basemap,
        MapLayerType.airports,
      };

      emit(MapReady(
        center: MapConstants.defaultCenter,
        zoom: MapConstants.defaultZoom,
        bounds: const MapBounds.world(),
        visibleLayers: defaultLayers,
        tilesLoaded: true,
      ));
    } on Exception catch (e) {
      emit(MapError(message: 'Failed to initialize map: $e'));
    }
  }

  Future<void> _onMoved(
    MapMoved event,
    Emitter<MapState> emit,
  ) async {
    final currentState = state;
    if (currentState is MapReady) {
      List<Airport>? newAirports;

      // Only fetch airports if zoomed in enough to prevent clutter/perf issues.
      if (event.zoom > 6.0 && currentState.visibleLayers.contains(MapLayerType.airports)) {
        try {
          newAirports = await _airportRepository.getAirportsInBoundingBox(
            minLat: event.bounds.southWest.latitude,
            maxLat: event.bounds.northEast.latitude,
            minLon: event.bounds.southWest.longitude,
            maxLon: event.bounds.northEast.longitude,
          );
        } catch (_) {
          // Ignore fetch errors for now
        }
      }

      emit(currentState.copyWith(
        center: event.center,
        zoom: event.zoom,
        bounds: event.bounds,
        airports: newAirports,
      ));
    }
  }

  void _onLayerToggled(
    MapLayerToggled event,
    Emitter<MapState> emit,
  ) {
    final currentState = state;
    if (currentState is MapReady) {
      final updatedLayers = Set<MapLayerType>.from(currentState.visibleLayers);
      if (updatedLayers.contains(event.layer)) {
        updatedLayers.remove(event.layer);
      } else {
        updatedLayers.add(event.layer);
      }
      emit(currentState.copyWith(visibleLayers: updatedLayers));
    }
  }

  void _onCenterOnLocation(
    MapCenterOnLocation event,
    Emitter<MapState> emit,
  ) {
    final currentState = state;
    if (currentState is MapReady) {
      emit(currentState.copyWith(
        center: event.location,
        zoom: event.zoom ?? currentState.zoom,
      ));
    }
  }

  void _onZoomChanged(
    MapZoomChanged event,
    Emitter<MapState> emit,
  ) {
    final currentState = state;
    if (currentState is MapReady) {
      final clampedZoom = event.zoom.clamp(
        MapConstants.minZoom,
        MapConstants.maxZoom,
      );
      emit(currentState.copyWith(zoom: clampedZoom));
    }
  }
}
