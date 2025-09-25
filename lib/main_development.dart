import 'package:pixboard/app/app.dart';
import 'package:pixboard/bootstrap.dart';
import 'package:pixboard/utils/_index.dart';

Future<void> main() async {
  PixBoardConfig(
    values: PixBoardValues(
      urlScheme: const String.fromEnvironment(
        'URL_SCHEME',
        defaultValue: 'https',
      ),
      baseDomain: const String.fromEnvironment(
        'BASE_DOMAIN',
        defaultValue: 'pixabay.com/api/',
      ),
      apiKey: const String.fromEnvironment('API_KEY', defaultValue: ''),
    ),
  );

  await bootstrap(() => const App());
}
