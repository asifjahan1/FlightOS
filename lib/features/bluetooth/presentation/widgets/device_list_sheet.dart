import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:skynav/features/bluetooth/domain/entities/bluetooth_device_entity.dart';
import 'package:skynav/features/bluetooth/presentation/bloc/bluetooth_bloc.dart';

/// Bottom sheet for scanning and managing BLE device connections.
///
/// Shows discovered devices with signal strength, allows connecting/
/// disconnecting, and displays adapter state messages.
class DeviceListSheet extends StatelessWidget {
  const DeviceListSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<BluetoothBloc>(),
        child: const DeviceListSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D23),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        border: Border.all(color: Colors.white10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Handle bar ──
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // ── Header ──
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Row(
              children: [
                const Icon(Icons.bluetooth, color: Colors.cyanAccent, size: 22),
                const SizedBox(width: 10),
                const Text(
                  'Cockpit Devices',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                BlocBuilder<BluetoothBloc, BluetoothState>(
                  builder: (context, state) {
                    final isScanning = state is BluetoothScanning;
                    return TextButton.icon(
                      onPressed: () {
                        if (isScanning) {
                          context
                              .read<BluetoothBloc>()
                              .add(const BluetoothScanStopped());
                        } else {
                          context
                              .read<BluetoothBloc>()
                              .add(const BluetoothScanRequested());
                        }
                      },
                      icon: isScanning
                          ? const SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.cyanAccent,
                              ),
                            )
                          : const Icon(Icons.search, size: 18),
                      label: Text(
                        isScanning ? 'Stop' : 'Scan',
                        style: const TextStyle(fontSize: 13),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.cyanAccent,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white10, height: 1),
          // ── Body ──
          Flexible(
            child: BlocBuilder<BluetoothBloc, BluetoothState>(
              builder: (context, state) {
                if (state is BluetoothUnsupported) {
                  return _buildMessage(
                    Icons.bluetooth_disabled,
                    'Bluetooth Not Supported',
                    'This platform does not support BLE.',
                    Colors.grey,
                  );
                }

                if (state is BluetoothAdapterOff) {
                  return _buildMessage(
                    Icons.bluetooth_disabled,
                    'Bluetooth is Off',
                    'Turn on Bluetooth in system settings.',
                    Colors.orangeAccent,
                  );
                }

                if (state is BluetoothError) {
                  return _buildMessage(
                    Icons.error_outline,
                    'Error',
                    state.message,
                    Colors.redAccent,
                  );
                }

                if (state is BluetoothConnecting) {
                  return _buildConnecting(state.device);
                }

                if (state is BluetoothConnected) {
                  return _buildConnectedDevice(context, state.device);
                }

                if (state is BluetoothScanning) {
                  if (state.devices.isEmpty) {
                    return _buildMessage(
                      Icons.bluetooth_searching,
                      'Scanning…',
                      'Looking for nearby cockpit devices.',
                      Colors.cyanAccent,
                    );
                  }
                  return _buildDeviceList(context, state.devices);
                }

                // BluetoothReady / BluetoothInitial
                return _buildMessage(
                  Icons.bluetooth,
                  'Ready',
                  'Tap "Scan" to find nearby cockpit devices.',
                  Colors.white38,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(
    IconData icon,
    String title,
    String subtitle,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: color),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white54, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildConnecting(BluetoothDeviceEntity device) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 36,
            height: 36,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: Colors.cyanAccent,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Connecting to ${device.displayName}…',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConnectedDevice(BuildContext context, BluetoothDeviceEntity device) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.cyanAccent.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.cyanAccent.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.greenAccent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        device.displayName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Connected • Receiving data',
                        style: TextStyle(
                          color: Colors.greenAccent.withValues(alpha: 0.8),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context
                        .read<BluetoothBloc>()
                        .add(const BluetoothDisconnectRequested());
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.redAccent,
                  ),
                  child: const Text('Disconnect'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceList(
    BuildContext context,
    List<BluetoothDeviceEntity> devices,
  ) {
    // Sort by signal strength (strongest first)
    final sorted = List<BluetoothDeviceEntity>.from(devices)
      ..sort((a, b) => b.rssi.compareTo(a.rssi));

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      shrinkWrap: true,
      itemCount: sorted.length,
      separatorBuilder: (_, __) => const Divider(
        color: Colors.white10,
        height: 1,
        indent: 56,
      ),
      itemBuilder: (context, index) {
        final device = sorted[index];
        return _DeviceTile(device: device);
      },
    );
  }
}

class _DeviceTile extends StatelessWidget {
  const _DeviceTile({required this.device});

  final BluetoothDeviceEntity device;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: _buildSignalIcon(),
      title: Text(
        device.displayName,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        '${device.rssi} dBm • ${device.id.substring(0, 8).toUpperCase()}',
        style: const TextStyle(color: Colors.white38, fontSize: 11),
      ),
      trailing: TextButton(
        onPressed: () {
          context
              .read<BluetoothBloc>()
              .add(BluetoothDeviceConnectRequested(device.id));
        },
        style: TextButton.styleFrom(
          foregroundColor: Colors.cyanAccent,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        child: const Text('Connect', style: TextStyle(fontSize: 13)),
      ),
      onTap: () {
        context
            .read<BluetoothBloc>()
            .add(BluetoothDeviceConnectRequested(device.id));
      },
    );
  }

  Widget _buildSignalIcon() {
    final bars = device.signalBars;
    final color = switch (bars) {
      >= 3 => Colors.greenAccent,
      2 => Colors.yellowAccent,
      _ => Colors.redAccent,
    };

    return SizedBox(
      width: 28,
      height: 28,
      child: CustomPaint(
        painter: _SignalBarsPainter(bars: bars, color: color),
      ),
    );
  }
}

/// Custom painter for RSSI signal bars (4 vertical bars).
class _SignalBarsPainter extends CustomPainter {
  _SignalBarsPainter({required this.bars, required this.color});

  final int bars;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final barWidth = size.width / 6;
    final gap = barWidth * 0.5;
    final totalWidth = barWidth * 4 + gap * 3;
    final startX = (size.width - totalWidth) / 2;

    for (var i = 0; i < 4; i++) {
      final barHeight = size.height * (0.25 + 0.25 * i);
      final x = startX + i * (barWidth + gap);
      final y = size.height - barHeight;

      final paint = Paint()
        ..color = i < bars ? color : Colors.white12
        ..style = PaintingStyle.fill;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, barWidth, barHeight),
          const Radius.circular(1),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_SignalBarsPainter oldDelegate) =>
      oldDelegate.bars != bars || oldDelegate.color != color;
}
