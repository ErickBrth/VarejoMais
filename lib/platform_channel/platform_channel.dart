import 'package:flutter/services.dart';

class PlatformChannel {
  // var platform = const MethodChannel("unique.identifier.method/hello");
  // var platform2 = const MethodChannel("unique.identifier.method/getLongAmount");
  var platformReprint = const MethodChannel("unique.identifier.method/reprint");
  var platformCreditoParceladoEmissor =
      const MethodChannel("unique.identifier.method/creditoParceladoEmissor");
  var platformCreditoVista =
      const MethodChannel("unique.identifier.method/creditoVista");

  var platformDebito = const MethodChannel("unique.identifier.method/debito");
  var platformVoucher = const MethodChannel("unique.identifier.method/voucher");
  var platformReversal =
      const MethodChannel("unique.identifier.method/estorno");

  // Future<String> callSimpleMethodChannel() async =>
  //     await platform.invokeMethod("getHelloWorld");

  // Future<int> getLongAmount() async =>
  //     await platform2.invokeMethod("getLongAmount");

  // Future<void> creditoParcelado() async =>
  //     await platformCreditCard.invokeMethod("creditoParcelado");

  Future<void> creditoParceladoEmissor() async =>
      await platformCreditoParceladoEmissor
          .invokeMethod("creditoParceladoEmissor");

  Future<void> reprint() async => await platformReprint.invokeMethod("reprint");

  Future<void> creditoVista() async =>
      await platformCreditoVista.invokeMethod("creditoVista");

  Future<void> debito() async => await platformDebito.invokeMethod("debito");
  Future<void> voucher() async => await platformVoucher.invokeMethod("voucher");
  Future<void> estorno() async =>
      await platformReversal.invokeMethod("estorno");
}
