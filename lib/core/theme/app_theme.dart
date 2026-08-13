/// Application theme definition.
///
/// SkyNav uses a dark theme optimized for cockpit readability:
/// - High contrast text on dark backgrounds
/// - Muted backgrounds that don't cause glare
/// - Aviation-standard colors for all functional elements
library;

import 'package:flutter/material.dart';

/// Builds the SkyNav application theme.
abstract final class AppTheme {
  // ── Color Palette ──

  /// Primary background — deep charcoal for cockpit readability.
  static const Color backgroundPrimary = Color(0xFF0D1117);

  /// Secondary background — slightly lighter for panels/cards.
  static const Color backgroundSecondary = Color(0xFF161B22);

  /// Tertiary background — for elevated surfaces.
  static const Color backgroundTertiary = Color(0xFF21262D);

  /// Surface color for cards and dialogs.
  static const Color surface = Color(0xFF1C2128);

  /// Primary accent color — aviation cyan.
  static const Color accentPrimary = Color(0xFF58A6FF);

  /// Secondary accent — for secondary actions.
  static const Color accentSecondary = Color(0xFF3FB950);

  /// Text primary — high-contrast white.
  static const Color textPrimary = Color(0xFFF0F6FC);

  /// Text secondary — muted for labels and descriptions.
  static const Color textSecondary = Color(0xFF8B949E);

  /// Text tertiary — subtle hints.
  static const Color textTertiary = Color(0xFF6E7681);

  /// Border/divider color.
  static const Color border = Color(0xFF30363D);

  /// Error/danger color.
  static const Color error = Color(0xFFFF7B72);

  /// Warning color.
  static const Color warning = Color(0xFFD29922);

  /// Success color.
  static const Color success = Color(0xFF3FB950);

  // ── Theme Data ──

  /// Returns the dark theme for SkyNav.
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundPrimary,
      colorScheme: const ColorScheme.dark(
        primary: accentPrimary,
        secondary: accentSecondary,
        surface: surface,
        error: error,
        onPrimary: backgroundPrimary,
        onSecondary: backgroundPrimary,
        onSurface: textPrimary,
        onError: backgroundPrimary,
        outline: border,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundSecondary,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: const CardThemeData(
        color: backgroundSecondary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          side: BorderSide(color: border),
        ),
      ),
      dividerTheme: const DividerThemeData(color: border, thickness: 1),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: backgroundTertiary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: accentPrimary, width: 2),
        ),
        labelStyle: const TextStyle(color: textSecondary),
        hintStyle: const TextStyle(color: textTertiary),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: textPrimary,
          fontSize: 32,
          fontWeight: FontWeight.w700,
        ),
        displayMedium: TextStyle(
          color: textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.w700,
        ),
        headlineLarge: TextStyle(
          color: textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          color: textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          color: textTertiary,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        labelLarge: TextStyle(
          color: textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      iconTheme: const IconThemeData(color: textSecondary, size: 24),
      tooltipTheme: const TooltipThemeData(
        decoration: BoxDecoration(
          color: backgroundTertiary,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        textStyle: TextStyle(color: textPrimary, fontSize: 12),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: backgroundTertiary,
        contentTextStyle: TextStyle(color: textPrimary),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }
}
