import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:skynav/features/bluetooth/presentation/bloc/bluetooth_bloc.dart';
import 'package:skynav/features/bluetooth/presentation/widgets/device_list_sheet.dart';

/// Compact Bluetooth status panel that sits alongside the telemetry panel.
///
/// Shows:
/// - Connection status icon (color-coded)
/// - Connected device name (when connected)
/// - Tap action to open device management sheet
class BluetoothPanel extends StatelessWidget {
  const BluetoothPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BluetoothBloc, BluetoothState>(
      builder: (context, state) {
        final (icon, color, label) = _stateInfo(state);

        return GestureDetector(
          onTap: () => DeviceListSheet.show(context),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.75),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color, size: 16),
                const SizedBox(width: 6),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 90),
                  child: Text(
                    label,
                    style: TextStyle(
                      color: color,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  (IconData, Color, String) _stateInfo(BluetoothState state) {
    return switch (state) {
      BluetoothConnected s => (
          Icons.bluetooth_connected,
          Colors.greenAccent,
          s.device.displayName,
        ),
      BluetoothConnecting _ => (
          Icons.bluetooth_searching,
          Colors.cyanAccent,
          'Connecting…',
        ),
      BluetoothScanning _ => (
          Icons.bluetooth_searching,
          Colors.cyanAccent,
          'Scanning…',
        ),
      BluetoothAdapterOff _ => (
          Icons.bluetooth_disabled,
          Colors.orangeAccent,
          'BT Off',
        ),
      BluetoothUnsupported _ => (
          Icons.bluetooth_disabled,
          Colors.grey,
          'No BLE',
        ),
      BluetoothError s => (
          Icons.error_outline,
          Colors.redAccent,
          s.message.length > 12
              ? '${s.message.substring(0, 12)}…'
              : s.message,
        ),
      _ => (Icons.bluetooth, Colors.white38, 'BLE'),
    };
  }
}
