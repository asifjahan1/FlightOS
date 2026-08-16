/// Represents the lifecycle state of a BLE connection.
enum BleConnectionState {
  /// No device connected, not scanning.
  disconnected,

  /// Actively scanning for nearby BLE devices.
  scanning,

  /// Attempting to connect to a specific device.
  connecting,

  /// Successfully connected and receiving data.
  connected,

  /// Graceful disconnect in progress.
  disconnecting,

  /// An error occurred (adapter off, permission denied, etc.).
  error,
}
