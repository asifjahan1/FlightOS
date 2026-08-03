/// Main map page — the primary view of the application.
///
/// Displays the flutter_map widget with layer controls and an info bar.
/// This is the home screen of SkyNav.
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:maplibre/maplibre.dart';
import 'package:window_manager/window_manager.dart';

import 'package:skynav/core/constants/map_constants.dart';
import 'package:skynav/core/theme/app_theme.dart';
import 'package:skynav/features/flight_plan/domain/entities/waypoint.dart';
import 'package:skynav/features/flight_plan/presentation/bloc/flight_plan_bloc.dart';
import 'package:skynav/features/map/presentation/bloc/map_bloc.dart';
import 'package:skynav/features/map/presentation/widgets/map_controls.dart';
import 'package:skynav/features/map/presentation/widgets/map_info_bar.dart';
import 'package:skynav/features/telemetry/presentation/bloc/telemetry_bloc.dart';
import 'package:skynav/features/telemetry/presentation/widgets/telemetry_panel.dart';
import 'package:skynav/features/traffic/presentation/bloc/traffic_bloc.dart';
import 'package:skynav/features/airspace/presentation/bloc/airspace_bloc.dart';
import 'package:skynav/features/airspace/presentation/bloc/airspace_event.dart';
import 'package:skynav/features/airspace/presentation/bloc/airspace_state.dart';
import 'package:skynav/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:skynav/features/weather/presentation/bloc/weather_event.dart';
import 'package:skynav/features/weather/domain/entities/weather_data.dart';
import 'package:skynav/features/terrain/presentation/bloc/terrain_bloc.dart';
import 'package:skynav/features/terrain/presentation/bloc/terrain_event.dart';
import 'package:skynav/features/terrain/presentation/bloc/terrain_state.dart';
import 'package:skynav/features/checklist/presentation/widgets/checklist_panel.dart';
import 'package:skynav/features/scratchpad/presentation/widgets/scratchpad_panel.dart';

/// The main map page — home screen of SkyNav.
class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapController? _mapController;

  @override
  void dispose() {
    // MapController doesn't have a dispose method directly exposed, or handled natively.
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
              final newZoom = (state.zoom + 1).clamp(MapConstants.minZoom, MapConstants.maxZoom);
              _mapController?.animateCamera(zoom: newZoom);
              context.read<MapBloc>().add(MapZoomChanged(zoom: newZoom));
            }
            return KeyEventResult.handled;
          } else if (char == '-') {
            // Zoom Out
            final state = context.read<MapBloc>().state;
            if (state is MapReady) {
              final newZoom = (state.zoom - 1).clamp(MapConstants.minZoom, MapConstants.maxZoom);
              _mapController?.animateCamera(zoom: newZoom);
              context.read<MapBloc>().add(MapZoomChanged(zoom: newZoom));
            }
            return KeyEventResult.handled;
          } else if (char == 't') {
            // Toggle Traffic
            context.read<MapBloc>().add(const MapLayerToggled(layer: MapLayerType.traffic));
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
            const WindowCaption(
              brightness: Brightness.dark,
              title: Text('SkyNav', style: TextStyle(color: Colors.white70)),
              backgroundColor: Color(0xFF0D1117),
            ),
            Expanded(
              child: MultiBlocListener(
                listeners: [
          BlocListener<MapBloc, MapState>(
            listener: (context, state) {
              if (state is MapReady) {
                if (state.airports.isNotEmpty) {
                  context.read<WeatherBloc>().add(FetchWeatherForAirports(
                    state.airports.map((a) => a.icao).toList(),
                  ));
                }
                
                _mapController?.animateCamera(
                  center: Geographic(
                    lat: state.center.latitude,
                    lon: state.center.longitude,
                  ),
                );
              }
            },
          ),
          BlocListener<TelemetryBloc, TelemetryState>(
            listener: (context, state) {
              if (state is TelemetryActive) {
                // Check airspace proximity
                context.read<AirspaceBloc>().add(AirspaceLocationUpdated(
                  latitude: state.data.latitude,
                  longitude: state.data.longitude,
                  altitude: state.data.altitudeMslFeet,
                ));
                // Check terrain proximity
                context.read<TerrainBloc>().add(TerrainLocationUpdated(
                  latitude: state.data.latitude,
                  longitude: state.data.longitude,
                  altitudeMsl: state.data.altitudeMslFeet,
                ));
                
                if (state.followModeEnabled && _mapController != null) {
                  _mapController?.animateCamera(
                    center: Geographic(
                      lat: state.data.latitude,
                      lon: state.data.longitude,
                    ),
                    zoom: 12,
                  );
                }
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
                onMapCreated: (controller) => _mapController = controller,
                mapController: _mapController,
              ),
              MapError(:final message) => _MapErrorView(message: message),
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
    required this.onMapCreated,
    this.mapController,
  });

  final MapReady state;
  final void Function(MapController) onMapCreated;
  final MapController? mapController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ── Main Map ──
        BlocBuilder<AirspaceBloc, AirspaceState>(
          builder: (context, airspaceState) {
            return BlocBuilder<FlightPlanBloc, FlightPlanState>(
              builder: (context, flightPlanState) {
                final activePlan = flightPlanState is FlightPlanActive
                    ? flightPlanState.flightPlan
                    : null;

                final layers = <Layer>[];
                
                if (airspaceState is AirspaceLoaded) {
                  for (final airspace in airspaceState.airspaces) {
                    final color = airspace.type == 'Class B' ? Colors.blue : Colors.red;
                    layers.add(
                      PolygonLayer(
                        polygons: [
                          Feature<Polygon>(
                            geometry: Polygon([
                              PositionSeries.from(
                                airspace.boundary
                                    .map((List<double> c) => Position.create(x: c[1], y: c[0]))
                                    .toList(),
                              )
                            ]),
                          ),
                        ],
                        color: color.withValues(alpha: 0.15),
                        outlineColor: color,
                      ),
                    );
                  }
                }
            if (activePlan != null && activePlan.waypoints.length > 1) {
              layers.add(
                PolylineLayer(
                  polylines: [
                    Feature<LineString>(
                      geometry: LineString.from(
                        activePlan.waypoints.map(
                          (wp) =>
                              Position.create(x: wp.longitude, y: wp.latitude),
                        ),
                      ),
                    ),
                  ],
                  color: const Color(0xFFFF00FF), // Aviation Magenta
                  width: 4,
                ),
              );
            }

            return MapLibreMap(
              onMapCreated: onMapCreated,
              options: MapOptions(
                initCenter: Geographic(
                  lat: state.center.latitude,
                  lon: state.center.longitude,
                ),
                initZoom: state.zoom,
                minZoom: MapConstants.minZoom,
                maxZoom: MapConstants.maxZoom,
              ),
              layers: layers,
              onEvent: (event) async {
                if (event is MapEventClick) {
                  final position = event.point;
                  context.read<FlightPlanBloc>().add(
                    WaypointAdded(
                      Waypoint(
                        latitude: position.lat,
                        longitude: position.lon,
                        name: 'Custom',
                      ),
                    ),
                  );
                }

                if (event is MapEventCameraIdle && mapController != null) {
                  final bounds = mapController!.getVisibleRegion();
                  final camera = mapController!.camera;

                  if (camera != null) {
                    if (context.mounted) {
                      context.read<MapBloc>().add(
                        MapMoved(
                          center: LatLng(camera.center.lat, camera.center.lon),
                          zoom: camera.zoom,
                          bounds: MapBounds(
                            southWest: LatLng(
                              bounds.latitudeSouth,
                              bounds.longitudeWest,
                            ),
                            northEast: LatLng(
                              bounds.latitudeNorth,
                              bounds.longitudeEast,
                            ),
                          ),
                        ),
                      );
                    }
                  }
                }
              },
              children: [
                if (state.visibleLayers.contains(MapLayerType.airports))
                  WidgetLayer(
                    allowInteraction: true,
                    markers: state.airports.map((airport) {
                      return Marker(
                        point: Geographic(
                          lat: airport.latitude,
                          lon: airport.longitude,
                        ),
                        size: const Size(32, 32),
                        child: GestureDetector(
                          onTap: () {
                            // Add airport to flight plan
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
                                content: Text('Added ${airport.icao} to route'),
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
                BlocBuilder<TelemetryBloc, TelemetryState>(
                  builder: (context, telemetryState) {
                    if (telemetryState is TelemetryActive) {
                      return WidgetLayer(
                        markers: [
                          Marker(
                            point: Geographic(
                              lat: telemetryState.data.latitude,
                              lon: telemetryState.data.longitude,
                            ),
                            size: const Size(48, 48),
                            child: Transform.rotate(
                              angle: (telemetryState.data.trueTrack * 3.1415926535) / 180.0,
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
                    return const SizedBox.shrink();
                  },
                ),
                if (state.visibleLayers.contains(MapLayerType.traffic))
                  BlocBuilder<TrafficBloc, TrafficState>(
                    builder: (context, trafficState) {
                      if (trafficState is TrafficActive) {
                        return WidgetLayer(
                          markers: trafficState.targets.map((target) {
                            return Marker(
                              point: Geographic(
                                lat: target.latitude,
                                lon: target.longitude,
                              ),
                              size: const Size(64, 48),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Transform.rotate(
                                    angle: (target.trackDegrees * 3.1415926535) / 180.0,
                                    child: const Icon(
                                      Icons.navigation,
                                      color: Colors.cyanAccent,
                                      size: 24,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: 0.6),
                                      borderRadius: BorderRadius.circular(4),
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
                      return const SizedBox.shrink();
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
              final isFollowing = telemetryState is TelemetryActive && telemetryState.followModeEnabled;
              return MapControls(
                currentZoom: state.zoom,
                visibleLayers: state.visibleLayers,
                isFollowing: isFollowing,
                onFollowToggle: () {
                  context.read<TelemetryBloc>().add(const TelemetryFollowToggled());
                },
                onZoomIn: () {
                  final newZoom = (state.zoom + 1).clamp(
                    MapConstants.minZoom,
                    MapConstants.maxZoom,
                  );
                  mapController?.animateCamera(zoom: newZoom);
                  context.read<MapBloc>().add(MapZoomChanged(zoom: newZoom));
                },
                onZoomOut: () {
                  final newZoom = (state.zoom - 1).clamp(
                    MapConstants.minZoom,
                    MapConstants.maxZoom,
                  );
                  mapController?.animateCamera(zoom: newZoom);
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
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
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
                    child: Text(
                      'PULL UP\nTERRAIN TERRAIN',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
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
          }
        ),

        // ── Floating Panels ──
        Positioned(
          top: 60,
          right: 0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const [
              ScratchpadPanel(),
              ChecklistPanel(),
            ],
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
        const Positioned(
          left: 16,
          top: 80,
          child: TelemetryPanel(),
        ),

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
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
