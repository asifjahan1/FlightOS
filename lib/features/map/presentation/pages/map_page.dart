/// Main map page — the primary view of the application.
///
/// Displays the FlutterMap widget with layer controls and an info bar.
/// This is the home screen of SkyNav.
library;

import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:skynav/core/constants/map_constants.dart';
import 'package:skynav/core/theme/app_theme.dart';
import 'package:skynav/features/airspace/presentation/bloc/airspace_bloc.dart';
import 'package:skynav/features/airspace/presentation/bloc/airspace_event.dart';
import 'package:skynav/features/airspace/presentation/bloc/airspace_state.dart';
import 'package:skynav/features/checklist/presentation/widgets/checklist_panel.dart';
import 'package:skynav/features/flight_plan/domain/entities/waypoint.dart';
import 'package:skynav/features/flight_plan/presentation/bloc/flight_plan_bloc.dart';
import 'package:skynav/features/map/presentation/bloc/map_bloc.dart';
import 'package:skynav/features/map/presentation/widgets/map_controls.dart';
import 'package:skynav/features/map/presentation/widgets/map_info_bar.dart';
import 'package:skynav/features/scratchpad/presentation/widgets/scratchpad_panel.dart';
import 'package:skynav/features/telemetry/presentation/bloc/telemetry_bloc.dart';
import 'package:skynav/features/telemetry/presentation/widgets/telemetry_panel.dart';
import 'package:skynav/features/terrain/presentation/bloc/terrain_bloc.dart';
import 'package:skynav/features/terrain/presentation/bloc/terrain_event.dart';
import 'package:skynav/features/terrain/presentation/bloc/terrain_state.dart';
import 'package:skynav/features/traffic/presentation/bloc/traffic_bloc.dart';
import 'package:skynav/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:skynav/features/weather/presentation/bloc/weather_event.dart';
import 'package:window_manager/window_manager.dart';

/// The main map page — home screen of SkyNav.
class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController _flutterMapController = MapController();

  @override
  void dispose() {
    _flutterMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          final char = event.logicalKey.keyLabel.toLowerCase();

          if (char == '=') {
            // Zoom In
            final state = context.read<MapBloc>().state;
            if (state is MapReady) {
              final newZoom = (state.zoom + 1).clamp(
                MapConstants.minZoom,
                MapConstants.maxZoom,
              );
              _flutterMapController.move(
                _flutterMapController.camera.center,
                newZoom,
              );
              context.read<MapBloc>().add(MapZoomChanged(zoom: newZoom));
            }
            return KeyEventResult.handled;
          } else if (char == '-') {
            // Zoom Out
            final state = context.read<MapBloc>().state;
            if (state is MapReady) {
              final newZoom = (state.zoom - 1).clamp(
                MapConstants.minZoom,
                MapConstants.maxZoom,
              );
              _flutterMapController.move(
                _flutterMapController.camera.center,
                newZoom,
              );
              context.read<MapBloc>().add(MapZoomChanged(zoom: newZoom));
            }
            return KeyEventResult.handled;
          } else if (char == 't') {
            // Toggle Traffic
            context.read<MapBloc>().add(
              const MapLayerToggled(layer: MapLayerType.traffic),
            );
            return KeyEventResult.handled;
          } else if (char == 'f') {
            // Toggle Follow Mode
            context.read<TelemetryBloc>().add(const TelemetryFollowToggled());
            return KeyEventResult.handled;
          } else if (char == 'c') {
            // Clear Route
            context.read<FlightPlanBloc>().add(const FlightPlanCleared());
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: Scaffold(
        body: Column(
          children: [
            // Custom title bar — on Linux/macOS use native title bar.
            if (Platform.isLinux || Platform.isMacOS)
              const SizedBox.shrink()
            else
              const WindowCaption(
                brightness: Brightness.dark,
                title: Text('SkyNav', style: TextStyle(color: Colors.white70)),
                backgroundColor: Color(0xFF0D1117),
              ),
            Expanded(
              child: MultiBlocListener(
                listeners: [
                  BlocListener<MapBloc, MapState>(
                    listenWhen: (previous, current) {
                      if (previous is MapReady && current is MapReady) {
                        return previous.visibleLayers != current.visibleLayers;
                      }
                      return current is MapReady;
                    },
                    listener: (context, state) {
                      // Layer visibility changes are handled reactively
                      // in the BlocBuilder below.
                    },
                  ),
                  BlocListener<TelemetryBloc, TelemetryState>(
                    listener: (context, state) {
                      if (state is TelemetryActive && state.followModeEnabled) {
                        final mapState = context.read<MapBloc>().state;
                        if (mapState is MapReady) {
                          _flutterMapController.move(
                            LatLng(
                              state.data.latitude,
                              state.data.longitude,
                            ),
                            mapState.zoom,
                          );
                        }
                      }
                      // Trigger weather/airspace/terrain updates
                      if (state is TelemetryActive) {
                        context.read<WeatherBloc>().add(
                          const FetchWeatherForAirports(['VGHS']),
                        );
                        context.read<AirspaceBloc>().add(
                          AirspaceLocationUpdated(
                            latitude: state.data.latitude,
                            longitude: state.data.longitude,
                            altitude: state.data.altitudeMslFeet,
                          ),
                        );
                        context.read<TerrainBloc>().add(
                          TerrainLocationUpdated(
                            latitude: state.data.latitude,
                            longitude: state.data.longitude,
                            altitudeMsl: state.data.altitudeMslFeet,
                          ),
                        );
                      }
                    },
                  ),
                ],
                child: BlocBuilder<MapBloc, MapState>(
                  builder: (context, state) {
                    return switch (state) {
                      MapInitial() || MapLoading() => const _MapLoadingView(),
                      MapReady() => _MapReadyView(
                        state: state,
                        mapController: _flutterMapController,
                      ),
                      MapError(:final message) => _MapErrorView(
                        message: message,
                      ),
                    };
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Loading state view.
class _MapLoadingView extends StatelessWidget {
  const _MapLoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text(
            'Initializing SkyNav...',
            style: TextStyle(color: AppTheme.textSecondary, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

/// Error state view.
class _MapErrorView extends StatelessWidget {
  const _MapErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, color: AppTheme.error, size: 48),
          const SizedBox(height: 16),
          Text('Map Error', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text(
            message,
            style: const TextStyle(color: AppTheme.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              context.read<MapBloc>().add(const MapInitialized());
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

/// Ready state — displays the map with overlays.
class _MapReadyView extends StatelessWidget {
  const _MapReadyView({
    required this.state,
    required this.mapController,
  });

  final MapReady state;
  final MapController mapController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ── Main FlutterMap ──
        BlocBuilder<AirspaceBloc, AirspaceState>(
          builder: (context, airspaceState) {
            return BlocBuilder<FlightPlanBloc, FlightPlanState>(
              builder: (context, flightPlanState) {
                final activePlan = flightPlanState is FlightPlanActive
                    ? flightPlanState.flightPlan
                    : null;

                return FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    initialCenter: LatLng(
                      state.center.latitude,
                      state.center.longitude,
                    ),
                    initialZoom: state.zoom,
                    minZoom: MapConstants.minZoom,
                    maxZoom: MapConstants.maxZoom,
                    backgroundColor: const Color(0xFF0D1117),
                    onMapEvent: (event) {
                      if (event is MapEventMoveEnd) {
                        final camera = mapController.camera;
                        final bounds = camera.visibleBounds;
                        if (context.mounted) {
                          context.read<MapBloc>().add(
                            MapMoved(
                              center: camera.center,
                              zoom: camera.zoom,
                              bounds: MapBounds(
                                southWest: bounds.southWest,
                                northEast: bounds.northEast,
                              ),
                            ),
                          );
                        }
                      }
                    },
                    onTap: (tapPosition, latLng) {
                      context.read<FlightPlanBloc>().add(
                        WaypointAdded(
                          Waypoint(
                            latitude: latLng.latitude,
                            longitude: latLng.longitude,
                            name: 'Custom',
                          ),
                        ),
                      );
                    },
                  ),
                  children: [
                    // ── Base Tile Layer ──
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.skynav.skynav',
                      tileProvider: CancellableNetworkTileProvider(),
                      maxZoom: MapConstants.maxZoom,
                      // Use a dark-themed tile server or apply color filter
                    ),

                    // ── VFR Chart Overlay ──
                    if (state.visibleLayers.contains(MapLayerType.vfrChart))
                      Opacity(
                        opacity: 0.7,
                        child: TileLayer(
                          // Chartbundle is permanently down. Using OpenTopoMap as a temporary fallback.
                          urlTemplate: 'https://tile.opentopomap.org/{z}/{x}/{y}.png',
                          tileProvider: CancellableNetworkTileProvider(),
                          maxZoom: 12,
                        ),
                      ),

                    // ── IFR Chart Overlay ──
                    if (state.visibleLayers.contains(MapLayerType.ifrChart))
                      Opacity(
                        opacity: 0.7,
                        child: TileLayer(
                          // Chartbundle is permanently down. Using OpenTopoMap as a temporary fallback.
                          urlTemplate: 'https://tile.opentopomap.org/{z}/{x}/{y}.png',
                          tileProvider: CancellableNetworkTileProvider(),
                          maxZoom: 12,
                        ),
                      ),

                    // ── Terrain Overlay ──
                    if (state.visibleLayers.contains(MapLayerType.terrain))
                      Opacity(
                        opacity: 0.6,
                        child: TileLayer(
                          urlTemplate: 'https://tile.opentopomap.org/{z}/{x}/{y}.png',
                          tileProvider: CancellableNetworkTileProvider(),
                          maxZoom: 17,
                        ),
                      ),

                    // ── Weather Radar Overlay ──
                    if (state.visibleLayers.contains(MapLayerType.weather))
                      Opacity(
                        opacity: 0.6,
                        child: TileLayer(
                          urlTemplate: 'https://tilecache.rainviewer.com/v2/radar/1691234567/256/{z}/{x}/{y}/2/1_1.png',
                          tileProvider: CancellableNetworkTileProvider(),
                        ),
                      ),

                    // ── Airspace Polygons ──
                    if (airspaceState is AirspaceLoaded)
                      PolygonLayer(
                        polygons: airspaceState.airspaces.map((airspace) {
                          final color = airspace.type == 'Class B'
                              ? Colors.blue
                              : Colors.red;
                          return Polygon(
                            points: airspace.boundary
                                .map((c) => LatLng(c[0], c[1]))
                                .toList(),
                            color: color.withValues(alpha: 0.15),
                            borderColor: color,
                            borderStrokeWidth: 2,
                          );
                        }).toList(),
                      ),

                    // ── Flight Plan Route ──
                    if (activePlan != null && activePlan.waypoints.length > 1)
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: activePlan.waypoints
                                .map((wp) => LatLng(wp.latitude, wp.longitude))
                                .toList(),
                            color: const Color(0xFFFF00FF), // Aviation Magenta
                            strokeWidth: 4,
                          ),
                        ],
                      ),

                    // ── Airport Markers ──
                    if (state.visibleLayers.contains(MapLayerType.airports))
                      MarkerLayer(
                        markers: state.airports.map((airport) {
                          return Marker(
                            point: LatLng(airport.latitude, airport.longitude),
                            width: 32,
                            height: 32,
                            child: GestureDetector(
                              onTap: () {
                                context.read<FlightPlanBloc>().add(
                                  WaypointAdded(
                                    Waypoint(
                                      latitude: airport.latitude,
                                      longitude: airport.longitude,
                                      name: airport.icao,
                                      elevation: airport.elevation,
                                    ),
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Added ${airport.icao} to route',
                                    ),
                                  ),
                                );
                              },
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: AppTheme.backgroundSecondary,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppTheme.accentPrimary,
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.local_airport,
                                  color: AppTheme.accentPrimary,
                                  size: 16,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                    // ── Ownship Telemetry Marker ──
                    BlocBuilder<TelemetryBloc, TelemetryState>(
                      builder: (context, telemetryState) {
                        if (telemetryState is TelemetryActive) {
                          return MarkerLayer(
                            markers: [
                              Marker(
                                point: LatLng(
                                  telemetryState.data.latitude,
                                  telemetryState.data.longitude,
                                ),
                                width: 48,
                                height: 48,
                                child: Transform.rotate(
                                  angle: telemetryState.data.trueTrack *
                                      math.pi /
                                      180.0,
                                  child: const Icon(
                                    Icons.flight,
                                    color: Colors.blueAccent,
                                    size: 36,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return const MarkerLayer(markers: []);
                      },
                    ),

                    // ── Traffic Markers ──
                    if (state.visibleLayers.contains(MapLayerType.traffic))
                      BlocBuilder<TrafficBloc, TrafficState>(
                        builder: (context, trafficState) {
                          if (trafficState is TrafficActive) {
                            return MarkerLayer(
                              markers: trafficState.targets.map((target) {
                                return Marker(
                                  point: LatLng(
                                    target.latitude,
                                    target.longitude,
                                  ),
                                  width: 64,
                                  height: 48,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Transform.rotate(
                                        angle: target.trackDegrees *
                                            math.pi /
                                            180.0,
                                        child: const Icon(
                                          Icons.flight,
                                          color: Colors.cyanAccent,
                                          size: 20,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withValues(
                                            alpha: 0.6,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        child: Text(
                                          '${target.callsign ?? target.icaoHex}\n${(target.altitudeFeet / 100).round().toString().padLeft(3, '0')}',
                                          style: const TextStyle(
                                            color: Colors.cyanAccent,
                                            fontSize: 10,
                                            height: 1.1,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          }
                          return const MarkerLayer(markers: []);
                        },
                      ),
                  ],
                );
              },
            );
          },
        ),

        // ── Map Controls (top-right) ──
        Positioned(
          top: 16,
          right: 16,
          child: BlocBuilder<TelemetryBloc, TelemetryState>(
            builder: (context, telemetryState) {
              final isFollowing =
                  telemetryState is TelemetryActive &&
                  telemetryState.followModeEnabled;
              return MapControls(
                currentZoom: state.zoom,
                visibleLayers: state.visibleLayers,
                isFollowing: isFollowing,
                onFollowToggle: () {
                  context.read<TelemetryBloc>().add(
                    const TelemetryFollowToggled(),
                  );
                },
                onZoomIn: () {
                  final newZoom = (state.zoom + 1).clamp(
                    MapConstants.minZoom,
                    MapConstants.maxZoom,
                  );
                  mapController.move(
                    mapController.camera.center,
                    newZoom,
                  );
                  context.read<MapBloc>().add(MapZoomChanged(zoom: newZoom));
                },
                onZoomOut: () {
                  final newZoom = (state.zoom - 1).clamp(
                    MapConstants.minZoom,
                    MapConstants.maxZoom,
                  );
                  mapController.move(
                    mapController.camera.center,
                    newZoom,
                  );
                  context.read<MapBloc>().add(MapZoomChanged(zoom: newZoom));
                },
                onLayerToggle: (layer) {
                  context.read<MapBloc>().add(MapLayerToggled(layer: layer));
                },
              );
            },
          ),
        ),

        // ── TAWS Overlay ──
        BlocBuilder<TerrainBloc, TerrainState>(
          builder: (context, state) {
            if (state is TerrainUpdated && state.isTawsAlertActive) {
              return Positioned(
                top: 40,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.5),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Text(
                      'PULL UP\nTERRAIN TERRAIN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),

        // ── Floating Panels ──
        const Positioned(
          top: 60,
          right: 0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [ScratchpadPanel(), ChecklistPanel()],
          ),
        ),

        // ── Bottom Panel (Telemetry) ──
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: BlocBuilder<FlightPlanBloc, FlightPlanState>(
            builder: (context, flightPlanState) {
              final activePlan = flightPlanState is FlightPlanActive
                  ? flightPlanState.flightPlan
                  : null;
              return MapInfoBar(
                center: state.center,
                zoom: state.zoom,
                activePlan: activePlan,
              );
            },
          ),
        ),

        // ── App Title (top-left) ──
        Positioned(
          top: 16,
          left: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.backgroundSecondary.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.border),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.flight, color: AppTheme.accentPrimary, size: 20),
                SizedBox(width: 8),
                Text(
                  'SkyNav',
                  style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),

        // ── Telemetry Panel (left-center) ──
        const Positioned(left: 16, top: 80, child: TelemetryPanel()),

        // ── Airspace Alert Banner ──
        BlocBuilder<AirspaceBloc, AirspaceState>(
          builder: (context, state) {
            if (state is AirspaceLoaded && state.currentAlert != null) {
              return Positioned(
                top: 40,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.redAccent.withValues(alpha: 0.5),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Text(
                      '⚠️ ENTERING ${state.currentAlert!.name.toUpperCase()}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
