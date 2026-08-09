/// Aviation-specific constants and conversion factors.
///
/// All values are sourced from FAA and ICAO standards.
library;

/// Conversion factors between aviation units.
abstract final class AviationUnits {
  /// Nautical miles to statute miles.
  static const double nmToSm = 1.15078;

  /// Statute miles to nautical miles.
  static const double smToNm = 0.868976;

  /// Nautical miles to meters.
  static const double nmToMeters = 1852;

  /// Meters to nautical miles.
  static const double metersToNm = 1.0 / nmToMeters;

  /// Nautical miles to kilometers.
  static const double nmToKm = 1.852;

  /// Kilometers to nautical miles.
  static const double kmToNm = 1.0 / nmToKm;

  /// Feet to meters.
  static const double ftToMeters = 0.3048;

  /// Meters to feet.
  static const double metersToFt = 1.0 / ftToMeters;

  /// Knots to meters per second.
  static const double ktsToMs = 0.514444;

  /// Meters per second to knots.
  static const double msToKts = 1.0 / ktsToMs;

  /// Knots to km/h.
  static const double ktsToKmh = 1.852;

  /// Knots to mph.
  static const double ktsToMph = 1.15078;

  /// Gallons (US) to liters.
  static const double galToLiters = 3.78541;

  /// Liters to gallons (US).
  static const double litersToGal = 1.0 / galToLiters;

  /// Pounds to kilograms.
  static const double lbToKg = 0.453592;

  /// Kilograms to pounds.
  static const double kgToLb = 1.0 / lbToKg;

  /// Inches of mercury to hectopascals (millibars).
  static const double inhgToHpa = 33.8639;

  /// Hectopascals to inches of mercury.
  static const double hpaToInhg = 1.0 / inhgToHpa;
}

/// Earth's physical constants (WGS-84).
abstract final class Earth {
  /// Mean radius of the Earth in meters (WGS-84).
  static const double meanRadiusMeters = 6371008.8;

  /// Mean radius of the Earth in nautical miles.
  static const double meanRadiusNm =
      meanRadiusMeters * AviationUnits.metersToNm;

  /// Semi-major axis (equatorial radius) in meters (WGS-84).
  static const double semiMajorAxisMeters = 6378137;

  /// Semi-minor axis (polar radius) in meters (WGS-84).
  static const double semiMinorAxisMeters = 6356752.314245;

  /// Flattening factor (WGS-84).
  static const double flattening = 1.0 / 298.257223563;

  /// Standard pressure at sea level in inches of mercury.
  static const double standardPressureInhg = 29.92;

  /// Standard pressure at sea level in hectopascals.
  static const double standardPressureHpa = 1013.25;

  /// Standard temperature at sea level in degrees Celsius.
  static const double standardTempC = 15;

  /// Standard lapse rate in degrees Celsius per 1000 feet.
  static const double lapseRateCPer1000Ft = 1.98;
}

/// Standard AIRAC cycle duration.
abstract final class AiracCycle {
  /// Duration of an AIRAC cycle in days.
  static const int durationDays = 28;
}
