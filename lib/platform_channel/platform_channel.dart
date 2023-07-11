import 'package:flutter/services.dart';

class PlatformChannel {
  var platform = const MethodChannel("unique.identifier.method/hello");
  var platform2 = const MethodChannel("unique.identifier.method/getLongAmount");
  // var platformCreditCard = const MethodChannel("unique.identifier.method/creditoParcelado");
  var platformReprint = const MethodChannel("unique.identifier.method/reprint");
  var platformCreditoParceladoEmissor = const MethodChannel("unique.identifier.method/creditoParceladoEmissor");


  Future<String> callSimpleMethodChannel() async =>
      await platform.invokeMethod("getHelloWorld");

  Future<int> getLongAmount() async =>
      await platform2.invokeMethod("getLongAmount");

  // Future<void> creditoParcelado() async =>
  //     await platformCreditCard.invokeMethod("creditoParcelado");

  Future<void> creditoParceladoEmissor() async =>
      await platformCreditoParceladoEmissor.invokeMethod("creditoParceladoEmissor");

  Future<void> reprint() async =>
      await platformReprint.invokeMethod("reprint");
}
