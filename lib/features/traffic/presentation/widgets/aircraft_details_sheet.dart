import 'package:flutter/material.dart';
import 'package:skynav/features/traffic/domain/entities/traffic_target.dart';

class AircraftDetailsSheet extends StatelessWidget {
  final TrafficTarget target;

  const AircraftDetailsSheet({super.key, required this.target});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Flight \${target.callsign ?? 'Unknown'}",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text('ICAO Hex: \${target.icaoHex}'),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoCol(context, 'Altitude', '\${target.altitudeFeet.round()} ft'),
                _buildInfoCol(context, 'Speed', '\${target.groundSpeedKnots.round()} kts'),
                _buildInfoCol(context, 'Heading', '\${target.trackDegrees.round()}°'),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCol(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
