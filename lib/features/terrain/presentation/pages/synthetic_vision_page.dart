import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:skynav/core/theme/app_theme.dart';
import 'package:skynav/features/telemetry/presentation/bloc/telemetry_bloc.dart';

class SyntheticVisionPage extends StatelessWidget {
  const SyntheticVisionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Synthetic Vision (AHRS)',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          // Simulated 3D Background (Sky/Ground)
          BlocBuilder<TelemetryBloc, TelemetryState>(
            builder: (context, state) {
              double pitch = 0; // Degrees
              double roll = 0; // Degrees

              if (state is TelemetryActive) {
                // Simulate pitch/roll from altitude changes or assume 0 for now
                // In a real EFB, this comes from AHRS gyro sensors.
              }

              return Transform.rotate(
                angle: roll * (math.pi / 180),
                child: Transform.translate(
                  offset: Offset(0, pitch * 5),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
                            ),
                          ),
                        ),
                      ),
                      Container(height: 2, color: Colors.white), // Horizon line
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFF5D4037), Color(0xFF3E2723)],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // Crosshair / Aircraft Symbol
          const Center(
            child: Icon(Icons.flight, color: Colors.yellow, size: 48),
          ),

          // HUD Overlays
          const Positioned.fill(child: _HudOverlay()),

          // Waiting for GPS Warning
          BlocBuilder<TelemetryBloc, TelemetryState>(
            builder: (context, state) {
              if (state is! TelemetryActive) {
                return const Center(
                  child: Text(
                    'WAITING FOR GPS/AHRS',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.black54,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

class _HudOverlay extends StatelessWidget {
  const _HudOverlay();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TelemetryBloc, TelemetryState>(
      builder: (context, state) {
        double altitude = 0;
        double speed = 0;
        double heading = 0;

        if (state is TelemetryActive) {
          altitude = state.data.altitudeMslFeet;
          speed = state.data.groundSpeedKnots;
          heading = state.data.trueTrack;
        }

        return Stack(
          children: [
            // Altitude Tape (Right)
            Positioned(
              right: 20,
              top: 0,
              bottom: 0,
              child: Center(
                child: Container(
                  width: 60,
                  height: 300,
                  color: Colors.black45,
                  alignment: Alignment.center,
                  child: Text(
                    '${altitude.round()}\nFT',
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            // Speed Tape (Left)
            Positioned(
              left: 20,
              top: 0,
              bottom: 0,
              child: Center(
                child: Container(
                  width: 60,
                  height: 300,
                  color: Colors.black45,
                  alignment: Alignment.center,
                  child: Text(
                    '${speed.round()}\nKT',
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            // Heading Tape (Top)
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 300,
                  height: 40,
                  color: Colors.black45,
                  alignment: Alignment.center,
                  child: Text(
                    'HDG ${heading.round().toString().padLeft(3, '0')}°',
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            // 3D Terrain Warning
            const Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'SYNTHETIC TERRAIN DATA UNAVAILABLE',
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
