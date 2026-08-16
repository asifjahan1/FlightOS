/// BLE data parsers for converting raw Bluetooth bytes into [CockpitTelemetry].
///
/// Supports three industry-standard aviation data protocols plus a raw
/// byte fallback. The [AutoDetectParser] inspects the first bytes of
/// incoming data and automatically selects the appropriate parser.
library;

import 'dart:convert';
import 'dart:typed_data';

import 'package:skynav/features/bluetooth/domain/entities/cockpit_telemetry.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Abstract Parser
// ─────────────────────────────────────────────────────────────────────────────

/// Base class for all BLE data parsers.
abstract class BleDataParser {
  /// Parses raw bytes from a BLE characteristic into [CockpitTelemetry].
  ///
  /// Returns `null` if the data cannot be parsed by this parser.
  CockpitTelemetry? parse(List<int> rawBytes, String sourceDeviceId);

  /// Human-readable name of this parser (for debugging/UI).
  String get protocolName;
}

// ─────────────────────────────────────────────────────────────────────────────
// GDL90 Parser — FAA standard for ADS-B and aviation data link
// ─────────────────────────────────────────────────────────────────────────────

/// Parses GDL90 protocol messages.
///
/// GDL90 is the FAA standard for ADS-B data. Messages are framed with
/// 0x7E flag bytes and contain CRC-16 checksums. This parser handles:
/// - Message ID 0: Heartbeat
/// - Message ID 10: Ownship Report (position, altitude, speed)
/// - Message ID 11: Ownship Geometric Altitude
class Gdl90Parser extends BleDataParser {
  @override
  String get protocolName => 'GDL90';

  @override
  CockpitTelemetry? parse(List<int> rawBytes, String sourceDeviceId) {
    if (rawBytes.length < 5) return null;

    // GDL90 messages start and end with 0x7E flag byte
    final unescaped = _unescapeGdl90(rawBytes);
    if (unescaped.isEmpty) return null;

    final messageId = unescaped[0];

    switch (messageId) {
      case 10: // Ownship Report
        return _parseOwnshipReport(unescaped, sourceDeviceId);
      case 11: // Ownship Geometric Altitude
        return _parseGeometricAltitude(unescaped, sourceDeviceId);
      default:
        return null; // Heartbeat (0) and other messages are metadata only
    }
  }

  CockpitTelemetry? _parseOwnshipReport(
    List<int> data,
    String sourceDeviceId,
  ) {
    // Ownship report is 28 bytes (after unescaping, excluding message ID)
    if (data.length < 28) return null;

    try {
      // Bytes 5-7: Latitude (24-bit signed, semicircles)
      final latRaw = (data[5] << 16) | (data[6] << 8) | data[7];
      final lat =
          (latRaw > 0x7FFFFF ? latRaw - 0x1000000 : latRaw) * (180.0 / (1 << 23));

      // Bytes 8-10: Longitude (24-bit signed, semicircles)
      final lonRaw = (data[8] << 16) | (data[9] << 8) | data[10];
      final lon =
          (lonRaw > 0x7FFFFF ? lonRaw - 0x1000000 : lonRaw) * (180.0 / (1 << 23));

      // Bytes 11-12: Altitude (12-bit, 25ft resolution, offset -1000ft)
      final altRaw = ((data[11] << 4) | (data[12] >> 4)) & 0xFFF;
      final altFeet = (altRaw * 25.0) - 1000.0;

      // Byte 14: Ground speed (in knots, unsigned)
      final groundSpeed = ((data[13] & 0x0F) << 8 | data[14]).toDouble();

      // Bytes 15-16: Track/heading (angular, 360/256 resolution)
      final trackRaw = data[15];
      final trackDeg = trackRaw * (360.0 / 256.0);

      return CockpitTelemetry(
        latitude: lat,
        longitude: lon,
        altitudeMslFeet: altFeet,
        groundSpeedKnots: groundSpeed,
        trackTrueDeg: trackDeg,
        timestamp: DateTime.now(),
        sourceDeviceId: sourceDeviceId,
      );
    } catch (_) {
      return null;
    }
  }

  CockpitTelemetry? _parseGeometricAltitude(
    List<int> data,
    String sourceDeviceId,
  ) {
    if (data.length < 5) return null;

    try {
      // Bytes 1-2: Geometric altitude (16-bit signed, 5ft resolution)
      final altRaw = (data[1] << 8) | data[2];
      final altFeet = (altRaw > 0x7FFF ? altRaw - 0x10000 : altRaw) * 5.0;

      return CockpitTelemetry(
        altitudeMslFeet: altFeet,
        timestamp: DateTime.now(),
        sourceDeviceId: sourceDeviceId,
      );
    } catch (_) {
      return null;
    }
  }

  /// Remove GDL90 byte-stuffing (0x7D escape sequences).
  List<int> _unescapeGdl90(List<int> raw) {
    // Strip leading/trailing 0x7E flag bytes
    var start = 0;
    var end = raw.length;
    if (raw.isNotEmpty && raw.first == 0x7E) start++;
    if (raw.length > 1 && raw.last == 0x7E) end--;

    final result = <int>[];
    var i = start;
    while (i < end) {
      if (raw[i] == 0x7D && i + 1 < end) {
        result.add(raw[i + 1] ^ 0x20);
        i += 2;
      } else {
        result.add(raw[i]);
        i++;
      }
    }
    return result;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// NMEA Parser — Standard GPS/navigation sentence format
// ─────────────────────────────────────────────────────────────────────────────

/// Parses NMEA 0183 sentences commonly output by GPS receivers and AHRS units.
///
/// Supports:
/// - $GPRMC: Position, speed, track, date/time
/// - $GPGGA: Position, altitude, fix quality
/// - $PFLAU/$PFLAA: FLARM wind/traffic data
class NmeaParser extends BleDataParser {
  @override
  String get protocolName => 'NMEA';

  @override
  CockpitTelemetry? parse(List<int> rawBytes, String sourceDeviceId) {
    try {
      final line = utf8.decode(rawBytes).trim();
      if (!line.startsWith(r'$')) return null;

      // Remove checksum (everything after '*')
      final sentence = line.contains('*') ? line.substring(0, line.indexOf('*')) : line;
      final parts = sentence.split(',');
      if (parts.isEmpty) return null;

      final sentenceType = parts[0];

      // Handle both $GP and $GN prefixes
      if (sentenceType.endsWith('RMC')) {
        return _parseRMC(parts, sourceDeviceId);
      } else if (sentenceType.endsWith('GGA')) {
        return _parseGGA(parts, sourceDeviceId);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  /// Parse $GPRMC — Recommended Minimum sentence.
  CockpitTelemetry? _parseRMC(List<String> parts, String sourceDeviceId) {
    if (parts.length < 10) return null;

    // Field 2: Status (A=active, V=void)
    if (parts[2] != 'A') return null;

    final lat = _parseNmeaCoord(parts[3], parts[4]);
    final lon = _parseNmeaCoord(parts[5], parts[6]);
    final speedKnots = double.tryParse(parts[7]);
    final trackDeg = double.tryParse(parts[8]);

    if (lat == null || lon == null) return null;

    return CockpitTelemetry(
      latitude: lat,
      longitude: lon,
      groundSpeedKnots: speedKnots,
      trackTrueDeg: trackDeg,
      timestamp: DateTime.now(),
      sourceDeviceId: sourceDeviceId,
    );
  }

  /// Parse $GPGGA — Fix information.
  CockpitTelemetry? _parseGGA(List<String> parts, String sourceDeviceId) {
    if (parts.length < 10) return null;

    final lat = _parseNmeaCoord(parts[2], parts[3]);
    final lon = _parseNmeaCoord(parts[4], parts[5]);
    final altMeters = double.tryParse(parts[9]);

    if (lat == null || lon == null) return null;

    return CockpitTelemetry(
      latitude: lat,
      longitude: lon,
      altitudeMslFeet: altMeters != null ? altMeters * 3.28084 : null,
      timestamp: DateTime.now(),
      sourceDeviceId: sourceDeviceId,
    );
  }

  /// Convert NMEA coordinate (DDMM.MMMMM / DDDMM.MMMMM) to decimal degrees.
  double? _parseNmeaCoord(String raw, String hemisphere) {
    if (raw.isEmpty) return null;
    final value = double.tryParse(raw);
    if (value == null) return null;

    final degrees = value ~/ 100;
    final minutes = value - (degrees * 100);
    var result = degrees + (minutes / 60.0);

    if (hemisphere == 'S' || hemisphere == 'W') result = -result;
    return result;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Generic JSON Parser — For custom/modern cockpit devices
// ─────────────────────────────────────────────────────────────────────────────

/// Parses JSON-encoded telemetry data from modern cockpit devices.
///
/// Expects a JSON object with snake_case keys matching [CockpitTelemetry]
/// fields. Missing fields are treated as null (partial updates are fine).
class GenericJsonParser extends BleDataParser {
  @override
  String get protocolName => 'JSON';

  @override
  CockpitTelemetry? parse(List<int> rawBytes, String sourceDeviceId) {
    try {
      final jsonString = utf8.decode(rawBytes).trim();
      if (!jsonString.startsWith('{')) return null;

      final data = jsonDecode(jsonString) as Map<String, dynamic>;

      return CockpitTelemetry(
        indicatedAirspeedKnots: _toDouble(data['ias'] ?? data['indicated_airspeed']),
        trueAirspeedKnots: _toDouble(data['tas'] ?? data['true_airspeed']),
        groundSpeedKnots: _toDouble(data['gs'] ?? data['ground_speed']),
        altitudeMslFeet: _toDouble(data['alt'] ?? data['altitude'] ?? data['altitude_msl']),
        altitudeAglFeet: _toDouble(data['agl'] ?? data['altitude_agl']),
        verticalSpeedFpm: _toDouble(data['vs'] ?? data['vertical_speed']),
        headingMagneticDeg: _toDouble(data['hdg'] ?? data['heading'] ?? data['heading_mag']),
        headingTrueDeg: _toDouble(data['hdg_true'] ?? data['heading_true']),
        trackTrueDeg: _toDouble(data['trk'] ?? data['track']),
        pitchDeg: _toDouble(data['pitch']),
        rollDeg: _toDouble(data['roll']),
        yawDeg: _toDouble(data['yaw']),
        windSpeedKnots: _toDouble(data['wind_speed'] ?? data['ws']),
        windDirectionDeg: _toDouble(data['wind_dir'] ?? data['wd']),
        outsideAirTempC: _toDouble(data['oat'] ?? data['temperature']),
        fuelFlowGph: _toDouble(data['fuel_flow'] ?? data['ff']),
        fuelRemainingGallons: _toDouble(data['fuel_remaining']),
        engineRpm: _toDouble(data['rpm'] ?? data['engine_rpm']),
        manifoldPressureInHg: _toDouble(data['mp'] ?? data['manifold_pressure']),
        oilTempC: _toDouble(data['oil_temp']),
        oilPressurePsi: _toDouble(data['oil_pressure']),
        egtDegC: _toDouble(data['egt']),
        chtDegC: _toDouble(data['cht']),
        latitude: _toDouble(data['lat'] ?? data['latitude']),
        longitude: _toDouble(data['lon'] ?? data['longitude']),
        gForce: _toDouble(data['g_force'] ?? data['g']),
        barometerInHg: _toDouble(data['baro'] ?? data['barometer']),
        timestamp: DateTime.now(),
        sourceDeviceId: sourceDeviceId,
      );
    } catch (_) {
      return null;
    }
  }

  double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Raw Bytes Parser — Fixed-layout binary protocol fallback
// ─────────────────────────────────────────────────────────────────────────────

/// Parses a fixed-layout binary packet (big-endian IEEE 754 floats).
///
/// Expected layout (minimum 24 bytes):
///   [0-3]   float32: latitude
///   [4-7]   float32: longitude
///   [8-11]  float32: altitude MSL (feet)
///   [12-15] float32: ground speed (knots)
///   [16-19] float32: heading (degrees)
///   [20-23] float32: vertical speed (FPM)
///   [24-27] float32: wind speed (knots)    — optional
///   [28-31] float32: wind direction (deg)  — optional
class RawBytesParser extends BleDataParser {
  @override
  String get protocolName => 'RAW';

  @override
  CockpitTelemetry? parse(List<int> rawBytes, String sourceDeviceId) {
    if (rawBytes.length < 24) return null;

    try {
      final bytes = Uint8List.fromList(rawBytes);
      final view = ByteData.view(bytes.buffer);

      return CockpitTelemetry(
        latitude: view.getFloat32(0, Endian.big).toDouble(),
        longitude: view.getFloat32(4, Endian.big).toDouble(),
        altitudeMslFeet: view.getFloat32(8, Endian.big).toDouble(),
        groundSpeedKnots: view.getFloat32(12, Endian.big).toDouble(),
        headingTrueDeg: view.getFloat32(16, Endian.big).toDouble(),
        verticalSpeedFpm: view.getFloat32(20, Endian.big).toDouble(),
        windSpeedKnots:
            rawBytes.length >= 28 ? view.getFloat32(24, Endian.big).toDouble() : null,
        windDirectionDeg:
            rawBytes.length >= 32 ? view.getFloat32(28, Endian.big).toDouble() : null,
        timestamp: DateTime.now(),
        sourceDeviceId: sourceDeviceId,
      );
    } catch (_) {
      return null;
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Auto-Detect Parser — Inspects bytes and delegates to the right parser
// ─────────────────────────────────────────────────────────────────────────────

/// Automatically detects the protocol of incoming BLE data and routes it
/// to the appropriate parser.
///
/// Detection order:
/// 1. GDL90 — starts with 0x7E flag byte
/// 2. NMEA — starts with '$' (0x24)
/// 3. JSON — starts with '{' (0x7B)
/// 4. Raw bytes — fallback
class AutoDetectParser extends BleDataParser {
  AutoDetectParser()
      : _gdl90 = Gdl90Parser(),
        _nmea = NmeaParser(),
        _json = GenericJsonParser(),
        _raw = RawBytesParser();

  final Gdl90Parser _gdl90;
  final NmeaParser _nmea;
  final GenericJsonParser _json;
  final RawBytesParser _raw;

  /// The last successfully detected protocol name.
  String? _detectedProtocol;
  String? get detectedProtocol => _detectedProtocol;

  @override
  String get protocolName => _detectedProtocol ?? 'AUTO';

  @override
  CockpitTelemetry? parse(List<int> rawBytes, String sourceDeviceId) {
    if (rawBytes.isEmpty) return null;

    final firstByte = rawBytes.first;

    // GDL90: 0x7E flag byte
    if (firstByte == 0x7E) {
      final result = _gdl90.parse(rawBytes, sourceDeviceId);
      if (result != null) {
        _detectedProtocol = _gdl90.protocolName;
        return result;
      }
    }

    // NMEA: starts with '$'
    if (firstByte == 0x24) {
      final result = _nmea.parse(rawBytes, sourceDeviceId);
      if (result != null) {
        _detectedProtocol = _nmea.protocolName;
        return result;
      }
    }

    // JSON: starts with '{'
    if (firstByte == 0x7B) {
      final result = _json.parse(rawBytes, sourceDeviceId);
      if (result != null) {
        _detectedProtocol = _json.protocolName;
        return result;
      }
    }

    // Fallback: raw binary
    final result = _raw.parse(rawBytes, sourceDeviceId);
    if (result != null) {
      _detectedProtocol = _raw.protocolName;
      return result;
    }

    return null;
  }
}
