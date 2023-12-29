

import 'package:flutter/services.dart';

class PlatformChannel {
  var platformReprint = const MethodChannel("unique.identifier.method/reprint");
  var platformCreditoParcelado =
      const MethodChannel("unique.identifier.method/creditoParcelado");
  var platformCreditoVista =
      const MethodChannel("unique.identifier.method/creditoVista");

  var platformDebito = const MethodChannel("unique.identifier.method/debito");
  var platformVoucher = const MethodChannel("unique.identifier.method/voucher");
  var platformPix = const MethodChannel("unique.identifier.method/pix");
  var platformReversal =
      const MethodChannel("unique.identifier.method/estorno");


  Future<String> creditoParcelado(double valor, int parcelas) async{
    if (valor == null || valor <= 0.0) {
      return '';
    }else{
      Map args ={
        "valor": valor,
        "parcelas": parcelas,
      };
      return await platformCreditoParcelado.invokeMethod("creditoParcelado", args);
    }
  }

  // Future<void> creditoParceladoEmissor() async =>
  //     await platformCreditoParceladoEmissor
  //         .invokeMethod("creditoParceladoEmissor");

  Future<void> reprint() async => await platformReprint.invokeMethod("reprint");

  Future<String> creditoVista(double valor) async {
    if (valor == null || valor <= 0.0) {
      return '';
    }else{
      return await platformCreditoVista.invokeMethod("creditoVista", {"valor": valor});
    }
  }
  Future<String> pix(double valor) async{
    if (valor == null || valor <= 0.0) {
      return '';
    }else{
      return await platformPix.invokeMethod("pix", {"valor": valor});
    }
  }
  Future<String> debito(double valor) async{
    if (valor == null || valor <= 0.0) {
      return '';
    }else{
      return await platformDebito.invokeMethod("debito", {"valor" : valor});
    }
  }
  Future<void> voucher() async => await platformVoucher.invokeMethod("voucher");
  Future<void> estorno() async =>
      await platformReversal.invokeMethod("estorno");
}
