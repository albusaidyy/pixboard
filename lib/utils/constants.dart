class PixBoardValues {
  PixBoardValues({
    required this.urlScheme,
    required this.baseDomain,
  });
  final String urlScheme;
  final String baseDomain;
}

class PixBoardConfig {
  factory PixBoardConfig({required PixBoardValues values}) {
    return _instance ??= PixBoardConfig._internal(values);
  }

  PixBoardConfig._internal(this.values);

  final PixBoardValues values;
  static PixBoardConfig? _instance;

  static PixBoardConfig? get instance => _instance;
}
