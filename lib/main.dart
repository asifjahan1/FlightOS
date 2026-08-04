library;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:skynav/app.dart';
import 'package:skynav/core/database/connection.dart';
import 'package:skynav/features/airport/data/seed/airport_seeder.dart';
import 'package:skynav/injection.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:window_manager/window_manager.dart';
 
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Supabase
    await Supabase.initialize(
      url: 'https://qpfglplzegtaglybqekx.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFwZmdscGx6ZWd0YWdseWJxZWt4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODU4MzU5MTgsImV4cCI6MjEwMTQxMTkxOH0.yedTWK0BlOEt76b9dhTwt3qmT_7lh3mAVHAZT9k-rAE',
    );

    // Sign in anonymously if not already signed in (so we have an ID for tracking)
    final supabase = Supabase.instance.client;
    if (supabase.auth.currentSession == null) {
      try {
        await supabase.auth.signInAnonymously();
      } catch (e) {
        debugPrint('Supabase anonymous sign in failed: $e');
      }
    }
  } catch (e) {
    debugPrint('Supabase initialization or sign-in failed: $e');
  }

  setupSqliteDatabase();

  // Initialize window manager for kiosk-like behavior
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

  await configureDependencies();

  runApp(const SkyNavApp());

  WidgetsBinding.instance.addPostFrameCallback((_) async {
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
