/// Main map page — the primary view of the application.
///
/// Displays the flutter_map widget with layer controls and an info bar.
/// This is the home screen of SkyNav.
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:maplibre/maplibre.dart';

import 'package:skynav/core/constants/map_constants.dart';
import 'package:skynav/core/theme/app_theme.dart';
import 'package:skynav/features/map/presentation/bloc/map_bloc.dart';
import 'package:skynav/features/map/presentation/widgets/map_controls.dart';
import 'package:skynav/features/map/presentation/widgets/map_info_bar.dart';

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
    return Scaffold(
      body: BlocConsumer<MapBloc, MapState>(
        listener: (context, state) {
          if (state is MapReady) {
             _mapController?.animateCamera(
               center: Geographic(lat: state.center.latitude, lon: state.center.longitude),
             );
          }
        },
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
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 16,
            ),
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
          const Icon(
            Icons.error_outline,
            color: AppTheme.error,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            'Map Error',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
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
        MapLibreMap(
          onMapCreated: onMapCreated,
          options: MapOptions(
            initCenter: Geographic(lat: state.center.latitude, lon: state.center.longitude),
            initZoom: state.zoom,
            minZoom: MapConstants.minZoom,
            maxZoom: MapConstants.maxZoom,
          ),
          onEvent: (event) async {
            if (event is MapEventCameraIdle && mapController != null) {
              final bounds = mapController!.getVisibleRegion();
              final camera = mapController!.camera;
              
              if (camera != null) {
                if (context.mounted) {
                  context.read<MapBloc>().add(MapMoved(
                    center: LatLng(camera.center.lat, camera.center.lon),
                    zoom: camera.zoom,
                    bounds: MapBounds(
                      southWest: LatLng(bounds.latitudeSouth, bounds.longitudeWest),
                      northEast: LatLng(bounds.latitudeNorth, bounds.longitudeEast),
                    ),
                  ));
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
                    point: Geographic(lat: airport.latitude, lon: airport.longitude),
                    size: const Size(32, 32),
                    child: GestureDetector(
                      onTap: () {
                        // TODO: Show airport details
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${airport.icao} - ${airport.name}')),
                        );
                      },
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppTheme.backgroundSecondary,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppTheme.accentPrimary, width: 2),
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
          ],
        ),

        // ── Map Controls (top-right) ──
        Positioned(
          top: 16,
          right: 16,
          child: MapControls(
            currentZoom: state.zoom,
            visibleLayers: state.visibleLayers,
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
          ),
        ),

        // ── Info Bar (bottom) ──
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: MapInfoBar(
            center: state.center,
            zoom: state.zoom,
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
                Icon(
                  Icons.flight,
                  color: AppTheme.accentPrimary,
                  size: 20,
                ),
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
      ],
    );
  }
}

