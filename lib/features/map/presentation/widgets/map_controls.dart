/// Map control widgets: zoom buttons, compass, and layer toggle panel.
library;

import 'package:flutter/material.dart';

import 'package:skynav/core/theme/app_theme.dart';
import 'package:skynav/core/utils/responsive_layout.dart';
import 'package:skynav/features/map/presentation/bloc/map_bloc.dart';

/// Floating map controls panel.
class MapControls extends StatelessWidget {
  const MapControls({
    required this.currentZoom,
    required this.visibleLayers,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onLayerToggle,
    required this.isFollowing,
    required this.onFollowToggle,
    required this.isDrawMode,
    required this.onDrawModeToggle,
    required this.isEmergencyMode,
    required this.onEmergencyModeToggle,
    required this.on3DToggle,
    required this.onClearRoute,
    super.key,
  });

  final double currentZoom;
  final Set<MapLayerType> visibleLayers;
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final ValueChanged<MapLayerType> onLayerToggle;
  final bool isFollowing;
  final VoidCallback onFollowToggle;
  final bool isDrawMode;
  final VoidCallback onDrawModeToggle;
  final bool isEmergencyMode;
  final VoidCallback onEmergencyModeToggle;
  final VoidCallback on3DToggle;
  final VoidCallback onClearRoute;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Zoom Controls ──
          _ControlPanel(
            children: [
              _ControlButton(
                icon: Icons.add,
                tooltip: 'Zoom In',
                onPressed: onZoomIn,
              ),
              const _ControlDivider(),
              _ControlButton(
                icon: Icons.remove,
                tooltip: 'Zoom Out',
                onPressed: onZoomOut,
              ),
            ],
          ),

          const SizedBox(height: 8),

          // ── Compass & Follow ──
          _ControlPanel(
            children: [
              _LayerToggle(
                icon: Icons.my_location,
                label: 'Follow Mode',
                isActive: isFollowing,
                onTap: onFollowToggle,
              ),
              const _ControlDivider(),
              _ControlButton(
                icon: Icons.navigation,
                tooltip: 'North Up',
                onPressed: () {
                  // Reset bearing to north (future)
                },
              ),
              const _ControlDivider(),
              _ControlButton(
                icon: Icons.threed_rotation,
                tooltip: 'Synthetic Vision (3D)',
                onPressed: on3DToggle,
              ),
            ],
          ),

          const SizedBox(height: 8),

          // ── Route Controls ──
          _ControlPanel(
            children: [
              _LayerToggle(
                icon: Icons.edit_location_alt,
                label: 'Draw Route',
                isActive: isDrawMode,
                onTap: onDrawModeToggle,
              ),
              const _ControlDivider(),
              _ControlButton(
                icon: Icons.delete_outline,
                tooltip: 'Clear Route',
                onPressed: onClearRoute,
              ),
            ],
          ),

          const SizedBox(height: 8),

          // ── Emergency Controls ──
          _ControlPanel(
            children: [
              _LayerToggle(
                icon: Icons.warning,
                label: 'NRST / Emergency',
                isActive: isEmergencyMode,
                onTap: onEmergencyModeToggle,
                activeColor: AppTheme.error,
              ),
            ],
          ),

          const SizedBox(height: 8),

          // ── Layer Toggle ──
          _ControlPanel(
            children: [
              _LayerToggle(
                icon: Icons.local_airport,
                label: 'Airports',
                isActive: visibleLayers.contains(MapLayerType.airports),
                onTap: () => onLayerToggle(MapLayerType.airports),
              ),
              const _ControlDivider(),
              _LayerToggle(
                icon: Icons.map,
                label: 'VFR Chart',
                isActive: visibleLayers.contains(MapLayerType.vfrChart),
                onTap: () => onLayerToggle(MapLayerType.vfrChart),
              ),
              const _ControlDivider(),
              _LayerToggle(
                icon: Icons.layers,
                label: 'IFR Low',
                isActive: visibleLayers.contains(MapLayerType.ifrChart),
                onTap: () => onLayerToggle(MapLayerType.ifrChart),
              ),
              const _ControlDivider(),
              _LayerToggle(
                icon: Icons.terrain,
                label: 'Terrain',
                isActive: visibleLayers.contains(MapLayerType.terrain),
                onTap: () => onLayerToggle(MapLayerType.terrain),
              ),
              const _ControlDivider(),
              _LayerToggle(
                icon: Icons.cloud,
                label: 'Weather',
                isActive: visibleLayers.contains(MapLayerType.weather),
                onTap: () => onLayerToggle(MapLayerType.weather),
              ),
              const _ControlDivider(),
              _LayerToggle(
                icon: Icons.people,
                label: 'Traffic',
                isActive: visibleLayers.contains(MapLayerType.traffic),
                onTap: () => onLayerToggle(MapLayerType.traffic),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// A translucent control panel container.
class _ControlPanel extends StatelessWidget {
  const _ControlPanel({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppTheme.backgroundSecondary.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: children),
    );
  }
}

/// A single icon button in the control panel.
class _ControlButton extends StatelessWidget {
  const _ControlButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isPhone = ResponsiveLayout.isPhone(context);
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: EdgeInsets.all(isPhone ? 12 : 18),
          child: Icon(
            icon,
            color: AppTheme.textPrimary,
            size: isPhone ? 24 : 28,
          ),
        ),
      ),
    );
  }
}

/// A layer toggle button with active state.
class _LayerToggle extends StatelessWidget {
  const _LayerToggle({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
    this.activeColor,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    final isPhone = ResponsiveLayout.isPhone(context);
    return Tooltip(
      message: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: EdgeInsets.all(isPhone ? 12 : 18),
          child: Icon(
            icon,
            color: isActive ? (activeColor ?? AppTheme.accentPrimary) : AppTheme.textTertiary,
            size: isPhone ? 24 : 28,
          ),
        ),
      ),
    );
  }
}

/// Horizontal divider for control panels.
class _ControlDivider extends StatelessWidget {
  const _ControlDivider();

  @override
  Widget build(BuildContext context) {
    return Container(height: 1, width: 28, color: AppTheme.border);
  }
}
