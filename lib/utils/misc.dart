class Misc {
  static bool deviceIsOffline(String errorMessage) {
    final message = errorMessage.toLowerCase();
    return message.contains('network is unreachable') ||
        message.contains('failed host lookup') ||
        message.contains('connection closed before full header was received') ||
        message.contains('failed to connect to') ||
        message.contains('the operation timed out') ||
        message.contains(
          '''operationexception(linkexception: serverexception(originalexception: clientexception: xmlhttprequest error''',
        ) ||
        message.contains('network request failed') ||
        message.contains('socket exception: connection failed') ||
        message.contains('failed to establish connection') ||
        message.contains('unable to resolve host') ||
        message.contains('connection timed out') ||
        message.contains('no internet connection') ||
        message.contains('network error') ||
        message.contains('socket hangup') ||
        message.contains('econnrefused') ||
        message.contains('etimedout');
  }
}
