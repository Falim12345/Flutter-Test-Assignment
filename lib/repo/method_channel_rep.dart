import 'package:flutter/services.dart';

class MethodChannelHelper {
  static const MethodChannel _channel = MethodChannel('URL');

  Future<void> invokeNativeMethod(String methodName,
      [dynamic arguments]) async {
    try {
      await _channel.invokeMethod(methodName, arguments);
    } on PlatformException catch (e) {
      print("Failed to invoke: ${e.message}");
    }
  }
}
