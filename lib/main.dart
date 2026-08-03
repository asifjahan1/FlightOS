/// SkyNav application entry point.
///
/// Initializes dependencies, configures the window for kiosk mode,
/// and launches the Flutter application.
library;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:skynav/app.dart';
import 'package:skynav/core/database/connection.dart';
import 'package:skynav/features/airport/data/seed/airport_seeder.dart';
import 'package:skynav/injection.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupSqliteDatabase();

  // Initialize window manager for kiosk-like behavior
  await windowManager.ensureInitialized();

  final windowOptions = WindowOptions(
    title: 'SkyNav',
    size: const Size(1920, 1080),
    minimumSize: const Size(1024, 768),
    center: true,
    backgroundColor: const Color(0xFF0D1117),
    // Hidden title bar crashes on Linux — use normal there.
    titleBarStyle: Platform.isLinux
        ? TitleBarStyle.normal
        : TitleBarStyle.hidden,
  );

  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setPreventClose(false);
    await windowManager.show();
    await windowManager.focus();
  });

  // Initialize dependency injection
  await configureDependencies();

  // Launch the UI IMMEDIATELY — never block the main isolate before runApp().
  runApp(const SkyNavApp());

  // After the first frame is painted, do the heavy lifting:
  // maximize the window and seed the database.
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    // Give the OpenGL/EGL surface time to initialize on Linux
    // before changing the window geometry.
    await Future<void>.delayed(const Duration(milliseconds: 500));
    try {
      await windowManager.maximize();
    } catch (e) {
      debugPrint('WARNING: Could not maximize window: $e');
    }
    try {
      await sl<AirportSeeder>().seedDatabaseIfEmpty();
    } catch (e, stack) {
      debugPrint('WARNING: Database seeding failed: $e\n$stack');
    }
  });
}
