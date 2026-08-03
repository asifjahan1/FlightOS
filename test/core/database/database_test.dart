import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:skynav/core/database/connection.dart';
import 'package:skynav/core/database/database.dart';

class MockPathProvider extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async => '.';

  @override
  Future<String?> getTemporaryPath() async => '.';
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    PathProviderPlatform.instance = MockPathProvider();
    setupSqliteDatabase();
  });

  test('AppDatabase opens and executes queries on Linux', () async {
    final db = AppDatabase();
    final count = await db.airportDao.getAirportsCount();
    expect(count, greaterThanOrEqualTo(0));
    await db.close();
  });
}
