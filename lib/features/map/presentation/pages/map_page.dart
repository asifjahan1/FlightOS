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
import 'package:skynav/features/map/presentation/widgets/airport_search_bar.dart';
import 'package:skynav/features/traffic/presentation/widgets/aircraft_details_sheet.dart' as skynav_details;
import 'package:skynav/features/map/presentation/widgets/map_controls.dart';
import 'package:skynav/features/map/presentation/widgets/map_info_bar.dart';
import 'package:skynav/features/scratchpad/presentation/widgets/scratchpad_panel.dart';
import 'package:skynav/features/telemetry/presentation/bloc/telemetry_bloc.dart';
import 'package:skynav/features/telemetry/presentation/widgets/fleet_layer.dart';
import 'package:skynav/features/telemetry/presentation/widgets/telemetry_panel.dart';
import 'package:skynav/features/terrain/presentation/bloc/terrain_bloc.dart';
import 'package:skynav/features/terrain/presentation/bloc/terrain_event.dart';
import 'package:skynav/features/terrain/presentation/bloc/terrain_state.dart';
import 'package:skynav/features/traffic/presentation/bloc/traffic_bloc.dart';
import 'package:skynav/features/weather/domain/entities/weather_data.dart';
import 'package:skynav/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:skynav/features/weather/presentation/bloc/weather_event.dart';
import 'package:skynav/features/weather/presentation/bloc/weather_state.dart';
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
            if (Platform.isWindows)
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
                        return previous.airports != current.airports ||
                            previous.visibleLayers != current.visibleLayers;
                      }
                      return current is MapReady;
                    },
                    listener: (context, state) {
                      if (state is MapReady &&
                          state.visibleLayers.contains(MapLayerType.weather) &&
                          state.airports.isNotEmpty) {
                        context.read<WeatherBloc>().add(
                          FetchWeatherForAirports(
                            state.airports.map((a) => a.icao).toList(),
                          ),
                        );
                      }
                    },
                  ),
                  BlocListener<TelemetryBloc, TelemetryState>(
                    listener: (context, state) {
                      if (state is TelemetryActive && state.followModeEnabled) {
                        final mapState = context.read<MapBloc>().state;
                        if (mapState is MapReady) {
                          _flutterMapController.move(
                            LatLng(state.data.latitude, state.data.longitude),
                            mapState.zoom,
                          );
                        }
                      }
                      // Trigger airspace/terrain updates
                      if (state is TelemetryActive) {
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
  const _MapReadyView({required this.state, required this.mapController});

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
                    onLongPress: (tapPosition, latLng) {
                      context.read<TelemetryBloc>().add(
                        TelemetryDestinationSet(latLng),
                      );
                    },
                  ),
                  children: [
                    // ── Base Tile Layer ──
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.skynav.skynav',
                      tileProvider: NetworkTileProvider(),
                      maxZoom: MapConstants.maxZoom,
                      // Use a dark-themed tile server or apply color filter
                    ),

                    // ── VFR Chart Overlay ──
                    if (state.visibleLayers.contains(MapLayerType.vfrChart))
                      Opacity(
                        opacity: 0.7,
                        child: TileLayer(
                          // Chartbundle is permanently down. Using OpenTopoMap as a temporary fallback.
                          urlTemplate:
                              'https://tile.opentopomap.org/{z}/{x}/{y}.png',
                          tileProvider: NetworkTileProvider(),
                          maxZoom: 12,
                        ),
                      ),

                    // ── IFR Chart Overlay ──
                    if (state.visibleLayers.contains(MapLayerType.ifrChart))
                      Opacity(
                        opacity: 0.7,
                        child: TileLayer(
                          // Chartbundle is permanently down. Using OpenTopoMap as a temporary fallback.
                          urlTemplate:
                              'https://tile.opentopomap.org/{z}/{x}/{y}.png',
                          tileProvider: NetworkTileProvider(),
                          maxZoom: 12,
                        ),
                      ),

                    // ── Terrain Overlay ──
                    if (state.visibleLayers.contains(MapLayerType.terrain))
                      Opacity(
                        opacity: 0.6,
                        child: TileLayer(
                          urlTemplate:
                              'https://tile.opentopomap.org/{z}/{x}/{y}.png',
                          tileProvider: NetworkTileProvider(),
                          maxZoom: 17,
                        ),
                      ),

                    // ── Weather Radar Overlay ──
                    if (state.visibleLayers.contains(MapLayerType.weather))
                      const SizedBox.shrink(), // Temporarily disabled: RainViewer tile cache returns 429/404 and crashes the app
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

                    // ── Direct-To Line (Destination) ──
                    if (activePlan != null && activePlan.destination != null)
                      BlocBuilder<TelemetryBloc, TelemetryState>(
                        builder: (context, telemetryState) {
                          if (telemetryState is TelemetryActive) {
                            return PolylineLayer(
                              polylines: [
                                Polyline(
                                  points: [
                                    LatLng(
                                      telemetryState.data.latitude,
                                      telemetryState.data.longitude,
                                    ),
                                    LatLng(
                                      activePlan.destination!.latitude,
                                      activePlan.destination!.longitude,
                                    ),
                                  ],
                                  color: const Color(
                                    0xFF00FFFF,
                                  ), // Cyan for Direct-To
                                  strokeWidth: 3,
                                  pattern: const StrokePattern.dotted(),
                                ),
                              ],
                            );
                          }
                          return const SizedBox.shrink();
                        },
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
                                final waypoint = Waypoint(
                                  latitude: airport.latitude,
                                  longitude: airport.longitude,
                                  name: airport.icao,
                                  elevation: airport.elevation,
                                );
                                showModalBottomSheet(
                                  context: context,
                                  builder: (ctx) => SafeArea(
                                    child: Wrap(
                                      children: [
                                        ListTile(
                                          leading: const Icon(
                                            Icons.add_location_alt,
                                          ),
                                          title: const Text('Add to Route'),
                                          onTap: () {
                                            Navigator.pop(ctx);
                                            context.read<FlightPlanBloc>().add(
                                              WaypointAdded(waypoint),
                                            );
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Added ${airport.icao} to route',
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        ListTile(
                                          leading: const Icon(
                                            Icons.flight_takeoff,
                                            color: Color(0xFF00FFFF),
                                          ),
                                          title: const Text(
                                            'Direct-To (Set Destination)',
                                          ),
                                          onTap: () {
                                            Navigator.pop(ctx);
                                            context.read<FlightPlanBloc>().add(
                                              DestinationSet(waypoint),
                                            );
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Direct-To ${airport.icao} set',
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
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
                                  Icons.location_on,
                                  color: AppTheme.accentPrimary,
                                  size: 16,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                    // ── Weather Markers (VFR/IFR Conditions) ──
                    if (state.visibleLayers.contains(MapLayerType.weather))
                      BlocBuilder<WeatherBloc, WeatherState>(
                        builder: (context, weatherState) {
                          if (weatherState is WeatherLoaded) {
                            return MarkerLayer(
                              markers: state.airports
                                  .where(
                                    (a) => weatherState.reports.containsKey(
                                      a.icao,
                                    ),
                                  )
                                  .map((airport) {
                                    final report =
                                        weatherState.reports[airport.icao]!;
                                    Color catColor = Colors.grey;
                                    switch (report.category) {
                                      case FlightCategory.vfr:
                                        catColor = Colors.green;
                                        break;
                                      case FlightCategory.mvfr:
                                        catColor = Colors.blue;
                                        break;
                                      case FlightCategory.ifr:
                                        catColor = Colors.red;
                                        break;
                                      case FlightCategory.lifr:
                                        catColor = Colors.purple;
                                        break;
                                      case FlightCategory.unknown:
                                        catColor = Colors.grey;
                                        break;
                                    }

                                    var weatherIcon = Icons.cloud;
                                    if (report.cloudCover == 'CLR' ||
                                        report.cloudCover == 'SKC') {
                                      weatherIcon = Icons.wb_sunny;
                                    } else if (report.cloudCover == 'FEW' ||
                                        report.cloudCover == 'SCT') {
                                      weatherIcon = Icons.wb_cloudy_outlined;
                                    } else if (report.cloudCover == 'BKN' ||
                                        report.cloudCover == 'OVC') {
                                      weatherIcon = Icons.cloud;
                                    }

                                    final tempText = report.tempC != null
                                        ? '${report.tempC!.round()}°C'
                                        : '';
                                    final windText = report.windSpeed != null
                                        ? '${report.windSpeed}kt'
                                        : '';
                                    final weatherText = [
                                      tempText,
                                      windText,
                                    ].where((s) => s.isNotEmpty).join(' ');

                                    return Marker(
                                      point: LatLng(
                                        airport.latitude,
                                        airport.longitude,
                                      ),
                                      width: 100,
                                      height: 40,
                                      alignment:
                                          Alignment.topRight, // Offset slightly
                                      child: Tooltip(
                                        message:
                                            'METAR:\n${report.rawMetar}\n\nTAF:\n${report.rawTaf}',
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: catColor,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            border: Border.all(
                                              color: Colors.black54,
                                              width: 2,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withValues(
                                                  alpha: 0.5,
                                                ),
                                                blurRadius: 4,
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                weatherIcon,
                                                color: Colors.white,
                                                size: 14,
                                              ),
                                              if (weatherText.isNotEmpty) ...[
                                                const SizedBox(width: 4),
                                                Text(
                                                  weatherText,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                                  .toList(),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),

                    // ── Ownship Telemetry Route (Polyline) ──
                    BlocBuilder<TelemetryBloc, TelemetryState>(
                      builder: (context, telemetryState) {
                        if (telemetryState is TelemetryActive &&
                            telemetryState.data.destinationLatitude != null &&
                            telemetryState.data.destinationLongitude != null) {
                          return PolylineLayer(
                            polylines: [
                              Polyline(
                                points: [
                                  LatLng(
                                    telemetryState.data.latitude,
                                    telemetryState.data.longitude,
                                  ),
                                  LatLng(
                                    telemetryState.data.destinationLatitude!,
                                    telemetryState.data.destinationLongitude!,
                                  ),
                                ],
                                color: Colors.blueAccent,
                                strokeWidth: 4,
                              ),
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      },
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
                                  angle:
                                      telemetryState.data.trueTrack *
                                      math.pi /
                                      180.0,
                                  child: const Icon(
                                    Icons.flight,
                                    color: Colors.blueAccent,
                                    size: 36,
                                  ),
                                ),
                              ),
                              if (telemetryState.data.destinationLatitude != null &&
                                  telemetryState.data.destinationLongitude != null)
                                Marker(
                                  point: LatLng(
                                    telemetryState.data.destinationLatitude!,
                                    telemetryState.data.destinationLongitude!,
                                  ),
                                  width: 48,
                                  height: 48,
                                  child: const Icon(
                                    Icons.location_on,
                                    color: Colors.redAccent,
                                    size: 36,
                                  ),
                                ),
                            ],
                          );
                        }
                        return const MarkerLayer(markers: []);
                      },
                    ),

                    // ── Fleet Markers (Admin Only) ──
                    const FleetLayer(),

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
                                  child: GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (ctx) => skynav_details.AircraftDetailsSheet(target: target),
                                      );
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                      Transform.rotate(
                                        angle:
                                            target.trackDegrees *
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
                  mapController.move(mapController.camera.center, newZoom);
                  context.read<MapBloc>().add(MapZoomChanged(zoom: newZoom));
                },
                onZoomOut: () {
                  final newZoom = (state.zoom - 1).clamp(
                    MapConstants.minZoom,
                    MapConstants.maxZoom,
                  );
                  mapController.move(mapController.camera.center, newZoom);
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

        // ── Search Bar (top-center) ──
        const Positioned(
          top: 16,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.topCenter,
            child: AirportSearchBar(),
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
