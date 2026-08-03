// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'core/database/database.dart' as _i234;
import 'core/location/location_service.dart' as _i406;
import 'core/traffic/traffic_service.dart' as _i290;
import 'features/airport/data/repositories/airport_repository_impl.dart'
    as _i505;
import 'features/airport/data/seed/airport_seeder.dart' as _i969;
import 'features/airport/domain/repositories/airport_repository.dart' as _i1064;
import 'features/airspace/data/airspace_service.dart' as _i654;
import 'features/airspace/presentation/bloc/airspace_bloc.dart' as _i949;
import 'features/flight_plan/presentation/bloc/flight_plan_bloc.dart' as _i1022;
import 'features/map/presentation/bloc/map_bloc.dart' as _i236;
import 'features/telemetry/presentation/bloc/telemetry_bloc.dart' as _i695;
import 'features/traffic/presentation/bloc/traffic_bloc.dart' as _i610;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i1022.FlightPlanBloc>(() => _i1022.FlightPlanBloc());
    gh.lazySingleton<_i234.AppDatabase>(() => _i234.AppDatabase());
    gh.lazySingleton<_i654.AirspaceService>(() => _i654.AirspaceService());
    gh.lazySingleton<_i406.LocationService>(
      () => _i406.GeolocatorLocationService(),
    );
    gh.factory<_i695.TelemetryBloc>(
      () => _i695.TelemetryBloc(gh<_i406.LocationService>()),
    );
    gh.lazySingleton<_i290.TrafficService>(
      () => _i290.SimulatorTrafficService(gh<_i406.LocationService>()),
    );
    gh.lazySingleton<_i969.AirportSeeder>(
      () => _i969.AirportSeeder(gh<_i234.AppDatabase>()),
    );
    gh.factory<_i949.AirspaceBloc>(
      () => _i949.AirspaceBloc(gh<_i654.AirspaceService>()),
    );
    gh.lazySingleton<_i1064.AirportRepository>(
      () => _i505.AirportRepositoryImpl(gh<_i234.AppDatabase>()),
    );
    gh.factory<_i610.TrafficBloc>(
      () => _i610.TrafficBloc(gh<_i290.TrafficService>()),
    );
    gh.factory<_i236.MapBloc>(
      () => _i236.MapBloc(gh<_i1064.AirportRepository>()),
    );
    return this;
  }
}
