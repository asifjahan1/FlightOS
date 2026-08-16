library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skynav/core/theme/app_theme.dart';
import 'package:skynav/features/airspace/presentation/bloc/airspace_bloc.dart';
import 'package:skynav/features/airspace/presentation/bloc/airspace_event.dart';
import 'package:skynav/features/bluetooth/presentation/bloc/bluetooth_bloc.dart';
import 'package:skynav/features/checklist/presentation/bloc/checklist_bloc.dart';
import 'package:skynav/features/flight_plan/presentation/bloc/flight_plan_bloc.dart';
import 'package:skynav/features/map/presentation/bloc/map_bloc.dart';
import 'package:skynav/features/map/presentation/pages/map_page.dart';
import 'package:skynav/features/scratchpad/presentation/bloc/scratchpad_bloc.dart';
import 'package:skynav/features/telemetry/presentation/bloc/telemetry_bloc.dart';
import 'package:skynav/features/terrain/presentation/bloc/terrain_bloc.dart';
import 'package:skynav/features/traffic/presentation/bloc/traffic_bloc.dart';
import 'package:skynav/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:skynav/injection.dart';

class SkyNavApp extends StatelessWidget {
  const SkyNavApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MapBloc>(
          create: (_) => sl<MapBloc>()..add(const MapInitialized()),
        ),
        BlocProvider<FlightPlanBloc>(create: (_) => sl<FlightPlanBloc>()),
        BlocProvider<TelemetryBloc>(
          create: (_) => sl<TelemetryBloc>()..add(const TelemetryStarted()),
        ),
        BlocProvider<TrafficBloc>(
          create: (_) => sl<TrafficBloc>()..add(const TrafficStarted()),
        ),
        BlocProvider<AirspaceBloc>(
          create: (_) => sl<AirspaceBloc>()
            ..add(
              const AirspacesLoaded(
                latMin: 20.0,
                lonMin: 88.0,
                latMax: 27.0,
                lonMax: 93.0,
              ),
            ),
        ),
        BlocProvider<WeatherBloc>(create: (_) => sl<WeatherBloc>()),
        BlocProvider<TerrainBloc>(create: (_) => sl<TerrainBloc>()),
        BlocProvider<ChecklistBloc>(create: (_) => sl<ChecklistBloc>()),
        BlocProvider<ScratchpadBloc>(create: (_) => sl<ScratchpadBloc>()),
        BlocProvider<BluetoothBloc>(
          create: (_) => sl<BluetoothBloc>()..add(const BluetoothStarted()),
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
