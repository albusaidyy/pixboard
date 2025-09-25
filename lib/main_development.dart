import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pixboard/app/app.dart';
import 'package:pixboard/bootstrap.dart';
import 'package:pixboard/utils/_index.dart';

Future<void> main() async {
  await dotenv.load().then((value) {
    PixBoardConfig(
      values: PixBoardValues(
        urlScheme: 'https',
        baseDomain: 'pixabay.com/api/',
        apiKey: dotenv.env['API_KEY'] ?? '',
      ),
    );
  });

  await bootstrap(() => const App());
}
