import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:skynav/features/bluetooth/domain/entities/cockpit_telemetry.dart';
import 'package:skynav/features/bluetooth/presentation/bloc/bluetooth_bloc.dart';
import 'package:skynav/features/bluetooth/presentation/widgets/device_list_sheet.dart';

/// Compact HUD overlay showing real-time cockpit data on the map.
///
/// Displays flight data (airspeed, altitude, wind, engine) received
/// via Bluetooth in a glassmorphism-styled panel. Tapping opens the
/// device management sheet.
class CockpitDataOverlay extends StatelessWidget {
  const CockpitDataOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BluetoothBloc, BluetoothState>(
      builder: (context, state) {
        if (state is BluetoothConnected && state.cockpitData != null) {
          return _buildDataOverlay(context, state);
        }

        // Show a small BT button when not connected
        return _buildConnectionButton(context, state);
      },
    );
  }

  Widget _buildConnectionButton(BuildContext context, BluetoothState state) {
    final isUnsupported = state is BluetoothUnsupported;

    return GestureDetector(
      onTap: isUnsupported ? null : () => DeviceListSheet.show(context),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isUnsupported ? Icons.bluetooth_disabled : Icons.bluetooth,
              color: isUnsupported ? Colors.grey : Colors.cyanAccent,
              size: 18,
            ),
            const SizedBox(width: 6),
            Text(
              isUnsupported ? 'BLE N/A' : 'Connect',
              style: TextStyle(
                color: isUnsupported ? Colors.grey : Colors.cyanAccent,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataOverlay(BuildContext context, BluetoothConnected state) {
    final data = state.cockpitData!;

    return GestureDetector(
      onTap: () => DeviceListSheet.show(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.75),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.cyanAccent.withValues(alpha: 0.25)),
          boxShadow: [
            BoxShadow(
              color: Colors.cyanAccent.withValues(alpha: 0.08),
              blurRadius: 12,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header with live indicator ──
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const _LiveIndicator(),
                const SizedBox(width: 6),
                Text(
                  state.device.displayName,
                  style: const TextStyle(
                    color: Colors.cyanAccent,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // ── Flight data gauges ──
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (data.groundSpeedKnots != null ||
                    data.trueAirspeedKnots != null)
                  _buildGauge(
                    'SPD',
                    (data.trueAirspeedKnots ?? data.groundSpeedKnots)!
                        .toStringAsFixed(0),
                    'KT',
                  ),
                if (data.altitudeMslFeet != null) ...[
                  _verticalDivider(),
                  _buildGauge(
                    'ALT',
                    data.altitudeMslFeet!.toStringAsFixed(0),
                    'FT',
                  ),
                ],
                if (data.verticalSpeedFpm != null) ...[
                  _verticalDivider(),
                  _buildGauge(
                    'VS',
                    '${data.verticalSpeedFpm! >= 0 ? '+' : ''}${data.verticalSpeedFpm!.toStringAsFixed(0)}',
                    'FPM',
                    valueColor: data.verticalSpeedFpm! > 100
                        ? Colors.greenAccent
                        : data.verticalSpeedFpm! < -100
                        ? Colors.redAccent
                        : Colors.white,
                  ),
                ],
              ],
            ),

            // ── Wind data ──
            if (data.hasWindData) ...[
              const Divider(color: Colors.white12, height: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _WindArrow(directionDeg: data.windDirectionDeg!),
                  const SizedBox(width: 8),
                  _buildGauge(
                    'WIND',
                    '${data.windDirectionDeg!.toStringAsFixed(0)}°/${data.windSpeedKnots!.toStringAsFixed(0)}',
                    'KT',
                  ),
                  if (data.outsideAirTempC != null) ...[
                    _verticalDivider(),
                    _buildGauge(
                      'OAT',
                      data.outsideAirTempC!.toStringAsFixed(0),
                      '°C',
                    ),
                  ],
                ],
              ),
            ],

            // ── Engine data ──
            if (data.hasEngineData) ...[
              const Divider(color: Colors.white12, height: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (data.engineRpm != null)
                    _buildGauge('RPM', data.engineRpm!.toStringAsFixed(0), ''),
                  if (data.fuelFlowGph != null) ...[
                    _verticalDivider(),
                    _buildGauge(
                      'FF',
                      data.fuelFlowGph!.toStringAsFixed(1),
                      'GPH',
                    ),
                  ],
                  if (data.fuelRemainingGallons != null) ...[
                    _verticalDivider(),
                    _buildGauge(
                      'FUEL',
                      data.fuelRemainingGallons!.toStringAsFixed(0),
                      'GAL',
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildGauge(
    String label,
    String value,
    String unit, {
    Color valueColor = Colors.white,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.cyanAccent,
              fontWeight: FontWeight.bold,
              fontSize: 9,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 3),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: valueColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Courier',
                ),
              ),
              if (unit.isNotEmpty) ...[
                const SizedBox(width: 2),
                Text(
                  unit,
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(
      width: 1,
      height: 28,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: Colors.white12,
    );
  }
}

/// Pulsing green "LIVE" indicator.
class _LiveIndicator extends StatefulWidget {
  const _LiveIndicator();

  @override
  State<_LiveIndicator> createState() => _LiveIndicatorState();
}

class _LiveIndicatorState extends State<_LiveIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.greenAccent.withValues(
              alpha: 0.5 + 0.5 * _controller.value,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.greenAccent.withValues(
                  alpha: 0.3 * _controller.value,
                ),
                blurRadius: 6,
                spreadRadius: 2,
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Wind direction arrow rotated to show wind-from direction.
class _WindArrow extends StatelessWidget {
  const _WindArrow({required this.directionDeg});

  final double directionDeg;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: directionDeg * (math.pi / 180),
      child: const Icon(
        Icons.arrow_downward,
        color: Colors.lightBlueAccent,
        size: 20,
      ),
    );
  }
}
