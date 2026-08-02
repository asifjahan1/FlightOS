/// Dependency injection configuration using get_it.
///
/// This file manually registers all dependencies. For large projects,
/// consider migrating to `injectable` for annotation-based registration.
library;

import 'package:get_it/get_it.dart';

import 'package:skynav/database/app_database.dart';
import 'package:skynav/database/daos/airport_dao.dart';
import 'package:skynav/features/map/presentation/bloc/map_bloc.dart';

/// Global service locator instance.
final GetIt sl = GetIt.instance;

/// Initializes all dependency injection bindings.
///
/// Must be called before `runApp()` in `main.dart`.
Future<void> configureDependencies() async {
  // ── Database ──
  sl.registerLazySingleton<AppDatabase>(AppDatabase.new);

  // ── DAOs ──
  sl.registerLazySingleton<AirportDao>(
    () => AirportDao(sl<AppDatabase>()),
  );

  // ── Repositories ──
  // (Registered as implementations are built)

  // ── BLoCs ──
  sl.registerFactory<MapBloc>(MapBloc.new);
}
