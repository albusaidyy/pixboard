class Failure implements Exception {
  const Failure({
    required this.message,
  });

  final String message;

  @override
  String toString() {
    return 'Failure: $message';
  }
}
