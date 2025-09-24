import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pixboard/app/app.dart';
import 'package:pixboard/bootstrap.dart';
import 'package:pixboard/utils/_index.dart';

Future<void> main() async {
  PixBoardConfig(
    values: PixBoardValues(
      urlScheme: 'https',
      baseDomain: 'pixabay.com/api/',
    ),
  );

  await dotenv.load();

  await bootstrap(() => const App());
}
