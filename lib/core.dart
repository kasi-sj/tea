import 'package:flutter/services.dart';

class PlatformCore {
  static const platform = const MethodChannel('samples.flutter.dev/battery');

  Future<String> changeColor(String color) async {
    var colors = "";
    try {
      final String result =
          await platform.invokeMethod('changeColor', {"color": color});

      colors = result;
    } on PlatformException catch (e) {
      print(e);
    }
    return colors;
  }
}
