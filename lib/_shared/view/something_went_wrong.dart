import 'package:flutter/material.dart';
import 'package:pixboard/utils/_index.dart';

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({
    required this.errorMessage,
    required this.onRetry,
    super.key,
  });

  final String errorMessage;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final isInternetError = Misc.deviceIsOffline(errorMessage);
    return SizedBox.expand(
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isInternetError
                      ? Icons.wifi_off_sharp
                      : Icons.domain_disabled,
                  color: Colors.red,
                  size: 60,
                ),
                const SizedBox(height: 25.96),
                Text(
                  isInternetError
                      ? 'No Internet connection'
                      : 'Sorry, something went\nwrong on our server',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    isInternetError
                        ? '''Sorry, no Internet connectivity detected. Please reconnect and try again.'''
                        : '''The server encountered an unexpected condition\nthat prevented it from fulfilling your request.''',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: onRetry,
                  child: const Text('RETRY'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
