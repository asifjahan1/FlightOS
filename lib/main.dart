library;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:skynav/app.dart';
import 'package:skynav/core/database/connection.dart';
import 'package:skynav/features/airport/data/seed/airport_seeder.dart';
import 'package:skynav/injection.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ignore: prefer_single_quotes, avoid_redundant_argument_values
  await dotenv.load(fileName: '.env');

  // Allow all orientations on mobile devices
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Supabase init is non-blocking on Android to avoid slow splash screen.
  // It runs in the background — features that need it will wait.
  _initSupabaseInBackground();

  setupSqliteDatabase();

  // Initialize window manager for kiosk-like behavior
  if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
    await windowManager.ensureInitialized();

    final windowOptions = WindowOptions(
      title: 'SkyNav',
      size: const Size(1920, 1080),
      minimumSize: const Size(1024, 768),
      center: true,
      backgroundColor: const Color(0xFF0D1117),
      titleBarStyle: Platform.isLinux || Platform.isMacOS
          ? TitleBarStyle.normal
          : TitleBarStyle.hidden,
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.setPreventClose(false);
      await windowManager.show();
      await windowManager.focus();
    });
  }

  await configureDependencies();

  // Seed airports BEFORE launching the app so the database is ready when the
  // map initializes. On Android this avoids the race where onMapReady fires
  // before seeding finishes.
  try {
    await sl<AirportSeeder>().seedDatabaseIfEmpty();
  } catch (e, stack) {
    debugPrint('WARNING: Database seeding failed: $e\n$stack');
  }

  runApp(const SkyNavApp());

  // Maximize window on desktop platforms (non-blocking, after runApp).
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    try {
      if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
        await windowManager.maximize();
      }
    } catch (e) {
      debugPrint('WARNING: Could not maximize window: $e');
    }
  });
}

/// Initialize Supabase in the background so it doesn't block app startup.
/// On Android with slow/no network, this can take several seconds.
/// Anonymous sign-in is not used — the app works without Supabase auth.
void _initSupabaseInBackground() {
  Future<void>(() async {
    try {
      final url = dotenv.env['SUPABASE_URL'] ?? '';
      final key = dotenv.env['SUPABASE_ANON_KEY'] ?? '';
      if (url.isEmpty || key.isEmpty) {
        debugPrint('Supabase credentials missing — skipping init.');
        return;
      }
      await Supabase.initialize(url: url, anonKey: key);
      debugPrint('Supabase initialized (no auth required).');
    } catch (e) {
      debugPrint('Supabase initialization failed (non-blocking): $e');
    }
  });
}
