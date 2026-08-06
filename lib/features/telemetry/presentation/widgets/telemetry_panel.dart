import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:skynav/features/telemetry/presentation/bloc/telemetry_bloc.dart';

class TelemetryPanel extends StatelessWidget {
  const TelemetryPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TelemetryBloc, TelemetryState>(
      builder: (context, state) {
        if (state is TelemetryActive) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.75),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildGauge('GS', state.data.groundSpeedKnots.toStringAsFixed(0), 'KT'),
                const Divider(color: Colors.white24, height: 24),
                _buildGauge('TRK', state.data.trueTrack.toStringAsFixed(0).padLeft(3, '0'), '°'),
                const Divider(color: Colors.white24, height: 24),
                _buildGauge('ALT', state.data.altitudeMslFeet.toStringAsFixed(0), 'FT'),
                if (state.data.destinationLatitude != null && state.data.destinationLongitude != null) ...[
                  const Divider(color: Colors.white24, height: 24),
                  GestureDetector(
                    onLongPress: () {
                      context.read<TelemetryBloc>().add(const TelemetryDestinationCleared());
                    },
                    child: _buildGauge(
                      'DTG',
                      (const Distance().as(
                        LengthUnit.Meter,
                        LatLng(state.data.latitude, state.data.longitude),
                        LatLng(state.data.destinationLatitude!, state.data.destinationLongitude!),
                      ) / 1852.0).toStringAsFixed(1),
                      'NM',
                    ),
                  ),
                ],
              ],
            ),
          );
        }
        return const SizedBox.shrink(); // Hide if no telemetry
      },
    );
  }

  Widget _buildGauge(String label, String value, String unit) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.greenAccent,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w900,
                fontFamily: 'Courier',
              ),
            ),
            const SizedBox(width: 2),
            Text(
              unit,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
