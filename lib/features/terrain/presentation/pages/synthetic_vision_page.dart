// ignore_for_file: use_colored_box

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skynav/features/telemetry/presentation/bloc/telemetry_bloc.dart';

class SyntheticVisionPage extends StatefulWidget {
  const SyntheticVisionPage({super.key});

  @override
  State<SyntheticVisionPage> createState() => _SyntheticVisionPageState();
}

class _SyntheticVisionPageState extends State<SyntheticVisionPage> {
  // Manual gesture offsets for 3D vibe
  double _pitchOffset = 0; // Degrees
  double _rollOffset = 0; // Degrees

  @override
  Widget build(BuildContext context) {
    // Determine a large size for the moving background so edges aren't visible
    final screenSize = MediaQuery.sizeOf(context);
    final bgHeight = screenSize.height * 4;
    final bgWidth = screenSize.width * 4;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ── Simulated 3D Environment (Sky, Ground, Pitch Ladder) ──
          GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                // Adjust pitch (vertical swipe)
                _pitchOffset += details.delta.dy * 0.2;
                // Clamp pitch so it doesn't wrap entirely upside down unrealistically
                _pitchOffset = _pitchOffset.clamp(-80.0, 80.0);

                // Adjust roll (horizontal swipe)
                _rollOffset -= details.delta.dx * 0.15;
                _rollOffset = _rollOffset.clamp(-90.0, 90.0);
              });
            },
            onDoubleTap: () {
              setState(() {
                _pitchOffset = 0.0;
                _rollOffset = 0.0;
              });
            },
            child: Container(
              color: Colors.black, // Base color behind everything
              child: Center(
                child: BlocBuilder<TelemetryBloc, TelemetryState>(
                  builder: (context, state) {
                    const double telemetryPitch = 0;
                    const double telemetryRoll = 0;

                    if (state is TelemetryActive) {
                      // If we had real AHRS data from Stratux, we'd use it here.
                      // For now, we combine telemetry with manual gesture offsets.
                    }

                    final finalPitch = telemetryPitch + _pitchOffset;
                    final finalRoll = telemetryRoll + _rollOffset;

                    return Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.0015) // Perspective distortion
                        ..rotateZ(finalRoll * (math.pi / 180)) // Roll
                        ..rotateX(-finalPitch * (math.pi / 180)), // Pitch
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: bgWidth,
                        height: bgHeight,
                        child: Stack(
                          children: [
                            // Sky and Ground Backgrounds
                            Column(
                              children: [
                                // Sky (Top Half)
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(
                                            0xFF09143C,
                                          ), // Deep space blue at zenith
                                          Color(0xFF1E3C72), // Blue
                                          Color(
                                            0xFF4A89DC,
                                          ), // Lighter blue near horizon
                                        ],
                                        stops: [0.0, 0.6, 1.0],
                                      ),
                                    ),
                                  ),
                                ),
                                // Glowing Horizon Line
                                Container(
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withValues(
                                          alpha: 0.8,
                                        ),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                      ),
                                      BoxShadow(
                                        color: Colors.lightBlueAccent
                                            .withValues(alpha: 0.5),
                                        blurRadius: 20,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                ),
                                // Ground (Bottom Half)
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(
                                            0xFF5D4037,
                                          ), // Earth brown at horizon
                                          Color(0xFF3E2723), // Darker brown
                                          Color(
                                            0xFF1A0F0D,
                                          ), // Almost black at nadir
                                        ],
                                        stops: [0.0, 0.4, 1.0],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Pitch Ladder Overlay
                            Positioned.fill(
                              child: CustomPaint(painter: PitchLadderPainter()),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // ── PFD Boresight (Aircraft Symbol) ──
          // Fixed in the center of the screen
          const IgnorePointer(child: Center(child: _BoresightSymbol())),

          // ── HUD Tapes (Altitude, Speed, Heading) ──
          const Positioned.fill(child: _HudOverlay()),

          // ── App Bar Overlay ──
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.black.withValues(alpha: 0.4),
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.white),
              title: const Text(
                'Synthetic Vision',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),

          // ── Waiting for GPS/AHRS Warning ──
          BlocBuilder<TelemetryBloc, TelemetryState>(
            builder: (context, state) {
              if (state is! TelemetryActive) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'WAITING FOR GPS/AHRS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
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
      ),
    );
  }
}

class _BoresightSymbol extends StatelessWidget {
  const _BoresightSymbol();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 100,
      child: CustomPaint(painter: RealisticAircraftPainter()),
    );
  }
}

class RealisticAircraftPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // 1. Shadows for the entire aircraft
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.7)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    // Common shadow path combining main elements
    final shadowPath = Path();

    // 2. Main Wings
    final wingPath = Path();
    // Left Wing
    wingPath.moveTo(center.dx - 15, center.dy + 5);
    wingPath.lineTo(center.dx - 80, center.dy + 15); // Wingtip back
    wingPath.lineTo(center.dx - 85, center.dy + 5); // Wingtip front
    wingPath.lineTo(center.dx - 15, center.dy - 5);
    // Right Wing
    wingPath.moveTo(center.dx + 15, center.dy + 5);
    wingPath.lineTo(center.dx + 80, center.dy + 15);
    wingPath.lineTo(center.dx + 85, center.dy + 5);
    wingPath.lineTo(center.dx + 15, center.dy - 5);
    wingPath.close();

    shadowPath.addPath(wingPath, const Offset(0, 10));

    final wingPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(center.dx, center.dy - 10),
        Offset(center.dx, center.dy + 20),
        [const Color(0xFF555555), const Color(0xFF222222)],
      );

    // 3. Horizontal Stabilizers (Tail Wings)
    final hStabPath = Path();
    hStabPath.moveTo(center.dx - 10, center.dy - 10);
    hStabPath.lineTo(center.dx - 40, center.dy - 5);
    hStabPath.lineTo(center.dx - 42, center.dy - 10);
    hStabPath.lineTo(center.dx - 10, center.dy - 15);

    hStabPath.moveTo(center.dx + 10, center.dy - 10);
    hStabPath.lineTo(center.dx + 40, center.dy - 5);
    hStabPath.lineTo(center.dx + 42, center.dy - 10);
    hStabPath.lineTo(center.dx + 10, center.dy - 15);
    hStabPath.close();

    shadowPath.addPath(hStabPath, const Offset(0, 8));

    final hStabPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(center.dx, center.dy - 20),
        Offset(center.dx, center.dy - 5),
        [const Color(0xFF666666), const Color(0xFF333333)],
      );

    // 4. Vertical Stabilizer (Tail)
    final vStabPath = Path();
    vStabPath.moveTo(center.dx - 2, center.dy - 10);
    vStabPath.lineTo(center.dx - 4, center.dy - 40);
    vStabPath.lineTo(center.dx + 4, center.dy - 40);
    vStabPath.lineTo(center.dx + 2, center.dy - 10);
    vStabPath.close();

    shadowPath.addPath(vStabPath, const Offset(0, 5));

    final vStabPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(center.dx - 5, center.dy),
        Offset(center.dx + 5, center.dy),
        [
          const Color(0xFF777777),
          const Color(0xFF444444),
          const Color(0xFF777777),
        ],
        [0.0, 0.5, 1.0],
      );

    // 5. Fuselage (Main Body) - Ellipse
    final fuselageRect = Rect.fromCenter(center: center, width: 30, height: 35);
    shadowPath.addOval(fuselageRect.shift(const Offset(0, 8)));

    final fuselagePaint = Paint()
      ..shader = ui.Gradient.radial(Offset(center.dx, center.dy - 5), 20, [
        const Color(0xFF999999),
        const Color(0xFF333333),
      ]);

    // Draw Combined Shadows
    canvas.drawPath(shadowPath, shadowPaint);

    // Draw Aircraft Parts
    canvas.drawPath(wingPath, wingPaint);
    canvas.drawPath(hStabPath, hStabPaint);
    canvas.drawPath(vStabPath, vStabPaint);
    canvas.drawOval(fuselageRect, fuselagePaint);

    // 6. Glowing Engines (Twin Jet Engines)
    final engineGlowPaint = Paint()
      ..shader = ui.Gradient.radial(Offset(center.dx - 8, center.dy + 15), 10, [
        Colors.cyanAccent,
        Colors.blue.withValues(alpha: 0),
      ]);
    final engineGlowPaint2 = Paint()
      ..shader = ui.Gradient.radial(Offset(center.dx + 8, center.dy + 15), 10, [
        Colors.cyanAccent,
        Colors.blue.withValues(alpha: 0),
      ]);

    final engineCore = Paint()..color = Colors.white;

    // Left Engine
    canvas.drawCircle(
      Offset(center.dx - 8, center.dy + 15),
      10,
      engineGlowPaint,
    );
    canvas.drawCircle(Offset(center.dx - 8, center.dy + 15), 3, engineCore);

    // Right Engine
    canvas.drawCircle(
      Offset(center.dx + 8, center.dy + 15),
      10,
      engineGlowPaint2,
    );
    canvas.drawCircle(Offset(center.dx + 8, center.dy + 15), 3, engineCore);

    // 7. Glass Canopy Reflection
    final canopyPaint = Paint()
      ..color = Colors.lightBlueAccent.withValues(alpha: 0.5)
      ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(center.dx, center.dy - 8),
        width: 12,
        height: 6,
      ),
      canopyPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PitchLadderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.5)
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;

    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      shadows: [
        Shadow(offset: Offset(1, 1), blurRadius: 3),
      ],
    );

    final center = Offset(size.width / 2, size.height / 2);

    // In our 3D space, how many pixels represent 1 degree of pitch?
    // A standard PFD might use 10-15 pixels per degree depending on FOV.
    // Since our container height is 4x screen size, we use a generous multiplier.
    const pixelsPerDegree = 25.0;

    void drawPitchLine(int degrees) {
      if (degrees == 0) {
        return; // Horizon is drawn by the container gradient separator
      }

      final yOffset = center.dy - (degrees * pixelsPerDegree);
      final isPositive = degrees > 0;

      final textSpan = TextSpan(text: '${degrees.abs()}', style: textStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      // Width of the pitch line
      var lineWidth = isPositive ? 120.0 : 80.0;
      if (degrees % 10 != 0) {
        lineWidth *= 0.6; // Smaller width for 5-degree increments
      }

      final leftEdge = center.dx - (lineWidth / 2);
      final rightEdge = center.dx + (lineWidth / 2);

      // Draw the line (with shadow)
      if (isPositive) {
        // Solid line with downward ticks at ends
        final path = Path()
          ..moveTo(leftEdge, yOffset + 10)
          ..lineTo(leftEdge, yOffset)
          ..lineTo(rightEdge, yOffset)
          ..lineTo(rightEdge, yOffset + 10);

        canvas.drawPath(path, shadowPaint);
        canvas.drawPath(path, paint);
      } else {
        // Dashed line for negative pitch
        const dashWidth = 15.0;
        const dashSpace = 10.0;
        var currentX = leftEdge;

        while (currentX < rightEdge) {
          final nextX = (currentX + dashWidth)
              .clamp(currentX, rightEdge)
              ;
          final path = Path()
            ..moveTo(currentX, yOffset)
            ..lineTo(nextX, yOffset);

          canvas.drawPath(path, shadowPaint);
          canvas.drawPath(path, paint);
          currentX += dashWidth + dashSpace;
        }
      }

      // Draw Text on both sides
      textPainter.paint(
        canvas,
        Offset(
          leftEdge - textPainter.width - 15,
          yOffset - (textPainter.height / 2),
        ),
      );
      textPainter.paint(
        canvas,
        Offset(rightEdge + 15, yOffset - (textPainter.height / 2)),
      );
    }

    // Draw from -90 to +90 degrees in 5 degree increments
    for (var i = -90; i <= 90; i += 5) {
      drawPitchLine(i);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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

        return IgnorePointer(
          child: Stack(
            children: [
              // ── Altitude Tape (Right) ──
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: Center(
                  child: _buildGlassTape(
                    width: 70,
                    height: 350,
                    value: altitude.round(),
                    unit: 'FT',
                    align: Alignment.centerLeft,
                    isRightSide: true,
                  ),
                ),
              ),

              // ── Speed Tape (Left) ──
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Center(
                  child: _buildGlassTape(
                    width: 70,
                    height: 350,
                    value: speed.round(),
                    unit: 'KT',
                    align: Alignment.centerRight,
                    isRightSide: false,
                  ),
                ),
              ),

              // ── Heading Tape (Top) ──
              Positioned(
                top: 80,
                left: 0,
                right: 0,
                child: Center(child: _buildHeadingTape(heading.round())),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGlassTape({
    required double width,
    required double height,
    required int value,
    required String unit,
    required Alignment align,
    required bool isRightSide,
  }) {
    return ClipRRect(
      borderRadius: isRightSide
          ? const BorderRadius.horizontal(left: Radius.circular(12))
          : const BorderRadius.horizontal(right: Radius.circular(12)),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.3),
            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
          ),
          child: Stack(
            children: [
              // The central highlighted box
              Center(
                child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    border: Border.all(color: Colors.greenAccent, width: 2),
                  ),
                ),
              ),
              // The central value
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$value',
                      style: const TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        shadows: [Shadow(blurRadius: 4)],
                      ),
                    ),
                  ],
                ),
              ),
              // The unit at the bottom
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Text(
                  unit,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Pointer triangle
              Center(
                child: CustomPaint(
                  size: const Size(10, 20),
                  painter: _PointerPainter(isRight: isRightSide),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeadingTape(int heading) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          width: 320,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.3),
            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
          ),
          child: Stack(
            children: [
              Center(
                child: Container(
                  width: 80,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    border: Border.all(color: Colors.greenAccent, width: 2),
                  ),
                ),
              ),
              Center(
                child: Text(
                  '${heading.toString().padLeft(3, '0')}°',
                  style: const TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    shadows: [Shadow(blurRadius: 4)],
                  ),
                ),
              ),
              // Triangle pointer
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomPaint(
                  size: const Size(20, 10),
                  painter: _HeadingPointerPainter(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PointerPainter extends CustomPainter {
  _PointerPainter({required this.isRight});
  final bool isRight;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.greenAccent
      ..style = PaintingStyle.fill;

    final path = Path();
    if (isRight) {
      path.moveTo(0, size.height / 2);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
    } else {
      path.moveTo(size.width, size.height / 2);
      path.lineTo(0, 0);
      path.lineTo(0, size.height);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HeadingPointerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.greenAccent
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
