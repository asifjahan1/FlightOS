/// SkyNav application entry point.
///
/// Initializes dependencies, configures the window for kiosk mode,
/// and launches the Flutter application.
library;

import 'package:flutter/material.dart';
import 'package:skynav/app.dart';
import 'package:skynav/features/airport/data/seed/airport_seeder.dart';
import 'package:skynav/injection.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize window manager for kiosk-like behavior
  await windowManager.ensureInitialized();

  const windowOptions = WindowOptions(
    title: 'SkyNav',
    size: Size(1920, 1080),
    minimumSize: Size(1024, 768),
    center: true,
    backgroundColor: Color(0xFF0D1117),
    titleBarStyle: TitleBarStyle.hidden,
  );

  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setFullScreen(false);
    await windowManager.maximize();
    await windowManager.setPreventClose(false);
    await windowManager.show();
    await windowManager.focus();
  });

  // Initialize dependency injection
  await configureDependencies();

  // Launch the UI IMMEDIATELY — never block the main isolate before runApp().
  runApp(const SkyNavApp());

  // Seed the database AFTER the first frame is painted so the window
  // stays responsive and the OS never flags "not responding".
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    try {
      await sl<AirportSeeder>().seedDatabaseIfEmpty();
    } catch (e, stack) {
      debugPrint('WARNING: Database seeding failed: $e\n$stack');
    }
  });
}
