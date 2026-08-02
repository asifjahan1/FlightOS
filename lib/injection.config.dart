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
import 'package:logger/logger.dart' as _i974;

import 'core/database/database.dart' as _i234;
import 'features/airport/data/repositories/airport_repository_impl.dart'
    as _i505;
import 'features/airport/data/seed/airport_seeder.dart' as _i969;
import 'features/airport/domain/repositories/airport_repository.dart' as _i1064;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i234.AppDatabase>(() => _i234.AppDatabase());
    gh.lazySingleton<_i1064.AirportRepository>(
      () => _i505.AirportRepositoryImpl(gh<_i234.AppDatabase>()),
    );
    gh.lazySingleton<_i969.AirportSeeder>(
      () => _i969.AirportSeeder(gh<_i234.AppDatabase>(), gh<_i974.Logger>()),
    );
    return this;
  }
}
