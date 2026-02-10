import 'package:flutter/services.dart';

class ServerStateService {
  static const MethodChannel _channel = MethodChannel(
    'com.example.slides_for_mac/server_state',
  );

  static Future<void> setServerPort(int port) async {
    try {
      await _channel.invokeMethod('setServerPort', {'port': port});
    } catch (e) {
      print("Error setting server port: $e");
    }
  }

  static void listenForServerStart(Function(int) onStart) {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'onServerPortChanged') {
        final int? port = call.arguments['port'];
        if (port != null) {
          onStart(port);
        }
      }
    });
  }
}
