import 'package:flutter/services.dart';

class ExemplePlatformChannel {
  var platform = const MethodChannel("unique.identifier.method/hello");
  var platform2 = const MethodChannel("unique.identifier.method/getLongAmount");

  Future<String> callSimpleMethodChannel() async =>
      await platform.invokeMethod("getHelloWorld");

  Future<int> getLongAmount() async =>
      await platform2.invokeMethod("getLongAmount");
}
