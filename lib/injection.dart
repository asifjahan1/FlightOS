import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:skynav/injection.config.dart';

final GetIt sl = GetIt.instance;

@InjectableInit(
  preferRelativeImports: true, // default
)
Future<void> configureDependencies() async {
  sl.init();
}
