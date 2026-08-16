import 'package:equatable/equatable.dart';

/// Represents a discovered Bluetooth Low Energy (BLE) device.
///
/// Wraps the flutter_blue_plus [BluetoothDevice] into a domain entity
/// so the domain/presentation layers remain independent of the BLE plugin.
class BluetoothDeviceEntity extends Equatable {
  const BluetoothDeviceEntity({
    required this.id,
    required this.name,
    required this.rssi,
    required this.isConnected,
    required this.lastSeen,
    this.serviceUuids = const [],
  });

  /// Platform-specific device identifier (MAC on Android, UUID on iOS/macOS).
  final String id;

  /// Human-readable device name (e.g. "Garmin G3X", "Stratus 3").
  /// May be empty if the device doesn't advertise a name.
  final String name;

  /// Received Signal Strength Indicator (dBm). Closer to 0 = stronger.
  final int rssi;

  /// Whether the device is currently connected.
  final bool isConnected;

  /// Advertised BLE service UUIDs.
  final List<String> serviceUuids;

  /// When this device was last seen during a scan.
  final DateTime lastSeen;

  /// Human-readable display name — falls back to truncated ID if unnamed.
  String get displayName =>
      name.isNotEmpty ? name : 'Unknown (${id.substring(0, 8)}…)';

  /// Signal quality as 0–4 bars based on RSSI.
  int get signalBars {
    if (rssi >= -55) return 4;
    if (rssi >= -67) return 3;
    if (rssi >= -80) return 2;
    if (rssi >= -90) return 1;
    return 0;
  }

  BluetoothDeviceEntity copyWith({
    String? id,
    String? name,
    int? rssi,
    bool? isConnected,
    List<String>? serviceUuids,
    DateTime? lastSeen,
  }) {
    return BluetoothDeviceEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      rssi: rssi ?? this.rssi,
      isConnected: isConnected ?? this.isConnected,
      serviceUuids: serviceUuids ?? this.serviceUuids,
      lastSeen: lastSeen ?? this.lastSeen,
    );
  }

  @override
  List<Object?> get props => [id, name, rssi, isConnected, lastSeen];
}
