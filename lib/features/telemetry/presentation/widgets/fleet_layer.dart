import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:skynav/features/telemetry/data/services/fleet_tracking_service.dart';
import 'package:skynav/features/telemetry/domain/entities/fleet_target.dart';
import 'package:skynav/injection.dart';

class FleetLayer extends StatefulWidget {
  const FleetLayer({super.key});

  @override
  State<FleetLayer> createState() => _FleetLayerState();
}

class _FleetLayerState extends State<FleetLayer> {
  late final Stream<List<FleetTarget>> _fleetStream;

  @override
  void initState() {
    super.initState();
    final fleetService = sl<FleetTrackingService>();
    _fleetStream = fleetService.getFleetStream();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<FleetTarget>>(
      stream: _fleetStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const MarkerLayer(markers: []);
        }

        final targets = snapshot.data!;
        
        final polylines = <Polyline>[];
        final markers = <Marker>[];

        for (final target in targets) {
          // If the location is older than 5 minutes, consider it stale (faded)
          final isStale = DateTime.now().difference(target.updatedAt).inMinutes > 5;
          final opacity = isStale ? 0.4 : 1.0;

          if (target.destinationLatitude != null && target.destinationLongitude != null) {
            polylines.add(
              Polyline(
                points: [
                  LatLng(target.latitude, target.longitude),
                  LatLng(target.destinationLatitude!, target.destinationLongitude!),
                ],
                color: Colors.deepOrangeAccent.withValues(alpha: opacity),
                strokeWidth: 4,
              ),
            );
            
            markers.add(
              Marker(
                point: LatLng(target.destinationLatitude!, target.destinationLongitude!),
                width: 32,
                height: 32,
                child: Opacity(
                  opacity: opacity,
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.deepOrangeAccent,
                    size: 24,
                  ),
                ),
              ),
            );
          }

          markers.add(
            Marker(
              point: LatLng(target.latitude, target.longitude),
              width: 48,
              height: 48,
              child: Opacity(
                opacity: opacity,
                child: Transform.rotate(
                  angle: target.heading * math.pi / 180.0,
                  child: const Icon(
                    Icons.flight,
                    color: Colors.deepOrangeAccent,
                    size: 32,
                  ),
                ),
              ),
            ),
          );
        }

        return Stack(
          fit: StackFit.expand,
          children: [
            if (polylines.isNotEmpty) PolylineLayer(polylines: polylines),
            if (markers.isNotEmpty) MarkerLayer(markers: markers),
          ],
        );
      },
    );
  }
}
