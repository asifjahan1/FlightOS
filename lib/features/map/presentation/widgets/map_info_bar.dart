/// Map info bar — bottom status strip showing position, zoom, and data info.
library;

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import 'package:skynav/core/geo/coordinate_utils.dart';
import 'package:skynav/core/theme/app_theme.dart';
import 'package:skynav/core/utils/nav_math.dart';
import 'package:skynav/features/flight_plan/domain/entities/flight_plan.dart';

/// Bottom status bar displaying map information.
class MapInfoBar extends StatelessWidget {
  const MapInfoBar({
    required this.center,
    required this.zoom,
    this.activePlan,
    super.key,
  });

  final LatLng center;
  final double zoom;
  final FlightPlan? activePlan;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        color: AppTheme.backgroundSecondary,
        border: Border(
          top: BorderSide(color: AppTheme.border),
        ),
      ),
      child: Row(
        children: [
          // ── Position ──
          _InfoChip(
            icon: Icons.location_on,
            label: CoordinateUtils.formatDecimal(
              center.latitude,
              center.longitude,
            ),
          ),

          const SizedBox(width: 24),

          // ── Zoom Level ──
          _InfoChip(
            icon: Icons.zoom_in,
            label: 'Z${zoom.toStringAsFixed(1)}',
          ),

          if (activePlan != null && activePlan!.waypoints.length > 1) ...[
            const SizedBox(width: 24),
            _InfoChip(
              icon: Icons.route,
              label: '${activePlan!.totalDistanceNm.toStringAsFixed(1)} NM',
              color: const Color(0xFFFF00FF),
            ),
            const SizedBox(width: 16),
            _InfoChip(
              icon: Icons.timer,
              label: 'ETE ${NavMath.formatEte(activePlan!.estimatedTimeEnrouteMinutes)}',
              color: const Color(0xFFFF00FF),
            ),
          ],

          const Spacer(),

          // ── Data Status ──
          const _InfoChip(
            icon: Icons.storage,
            label: 'Offline Ready',
            color: AppTheme.success,
          ),

          const SizedBox(width: 24),

          // ── Connection Status ──
          const _InfoChip(
            icon: Icons.wifi_off,
            label: 'Offline',
            color: AppTheme.textTertiary,
          ),
        ],
      ),
    );
  }
}

/// A compact info chip for the status bar.
class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
    this.color,
  });

  final IconData icon;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final displayColor = color ?? AppTheme.textSecondary;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: displayColor),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            color: displayColor,
            fontSize: 12,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }
}
