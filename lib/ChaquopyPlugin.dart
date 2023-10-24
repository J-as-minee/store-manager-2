import 'package:flutter/services.dart';

class ChaquopyPluginClass {
  static const MethodChannel _channel = MethodChannel('chaquopy');

  static Future<String> runPythonScript(String scriptPath) async {
    print('in plugin class');
    final result = await _channel.invokeMethod('runPythonScript', {'scriptPath': scriptPath});
    print('result: $result');
    return result as String;
  }
}