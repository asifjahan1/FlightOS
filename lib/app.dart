/// SkyNav application root widget.
///
/// Configures the MaterialApp with the aviation dark theme,
/// BLoC providers, and routing.
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:skynav/core/theme/app_theme.dart';
import 'package:skynav/features/flight_plan/presentation/bloc/flight_plan_bloc.dart';
import 'package:skynav/features/map/presentation/bloc/map_bloc.dart';
import 'package:skynav/features/map/presentation/pages/map_page.dart';
import 'package:skynav/features/telemetry/presentation/bloc/telemetry_bloc.dart';
import 'package:skynav/features/traffic/presentation/bloc/traffic_bloc.dart';
import 'package:skynav/features/airspace/presentation/bloc/airspace_bloc.dart';
import 'package:skynav/features/airspace/presentation/bloc/airspace_event.dart';
import 'package:skynav/injection.dart';

/// Root application widget.
class SkyNavApp extends StatelessWidget {
  const SkyNavApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MapBloc>(
          create: (_) => sl<MapBloc>()..add(const MapInitialized()),
        ),
        BlocProvider<FlightPlanBloc>(
          create: (_) => sl<FlightPlanBloc>(),
        ),
        BlocProvider<TelemetryBloc>(
          create: (_) => sl<TelemetryBloc>()..add(const TelemetryStarted()),
        ),
        BlocProvider<TrafficBloc>(
          create: (_) => sl<TrafficBloc>()..add(const TrafficStarted()),
        ),
        BlocProvider<AirspaceBloc>(
          create: (_) => sl<AirspaceBloc>()..add(AirspacesLoaded()),
        ),
      ],
      child: MaterialApp(
        title: 'SkyNav',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const MapPage(),
      ),
    );
  }
}
