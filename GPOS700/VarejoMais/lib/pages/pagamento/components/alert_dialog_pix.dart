import 'package:flutter/material.dart';
import 'package:varejoMais/data/controllers/pagamento_controller.dart';
import 'package:varejoMais/data/controllers/pixController.dart';
import 'package:varejoMais/pages/pagamento/components/pix_datapay.dart';
import 'package:varejoMais/shared/components/show_dialog_price/dialog_price.dart';
import 'package:varejoMais/shared/platform_channel/platform_channel.dart';

class DialogPix {
  final platformChannel = PlatformChannel();
  final PixController pixController = PixController();

  Future<void> showInputDialogPix(
      BuildContext context,
      double valor,
      double valorAPagar,
      double valorTotalPago,
      PagamentoController pagamentoController,
      double totalVenda) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            title: const Text(
              'Escolha a opção de Pix',
              style: TextStyle(
                fontFamily: "Arista-Pro-Bold-trial",
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: ElevatedButton(
                        onPressed: () async {
                          valorAPagar = (await DialogPrice()
                              .showInputDialog(context, valor))!;
                          valorTotalPago = valor;
                          String result = "";
                          if (valorAPagar > 0.0) {
                            if (valorAPagar == valorTotalPago) {
                              result = await platformChannel.pix(valorAPagar);
                              if (result == "ok!") {
                                pagamentoController.calculaValorRestante(
                                    valorAPagar, totalVenda);
                                Navigator.pushReplacementNamed(
                                    context, '/vendaFinalizada');
                              }
                            } else {
                              while (valorTotalPago > valorAPagar) {
                                if (valorAPagar > 0) {
                                  result =
                                      await platformChannel.pix(valorAPagar);
                                  if (result == "ok!") {
                                    pagamentoController.calculaValorRestante(
                                        valorAPagar, totalVenda);
                                    Navigator.of(context).pop();
                                    break;
                                  } else {
                                    Navigator.of(context).pop();
                                    break;
                                  }
                                }
                              }
                            }
                          }
                        },
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Color.fromRGBO(248, 67, 21, 1.0)),
                          minimumSize:
                              MaterialStatePropertyAll(Size.fromHeight(75)),
                        ),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.payments_outlined,
                              size: 45,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Pix Rede',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                fontFamily: "Arista-Pro-Bold-trial",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: ElevatedButton(
                        onPressed: () async {
                          valorAPagar = (await DialogPrice()
                              .showInputDialog(context, valor))!;
                          valorTotalPago = valor;
                          Navigator.of(context).pop();
                          if(valorAPagar > 0){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QrCodePix(
                                      valorAPagar: valorAPagar,
                                      pagamentoController:
                                      pagamentoController,
                                      pixController: pixController,
                                      valorTotalPago: valorTotalPago,
                                    )));
                          }
                        },
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.blueAccent),
                          minimumSize:
                              MaterialStatePropertyAll(Size.fromHeight(75)),
                        ),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.monetization_on,
                              size: 45,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Pix DataPay',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                fontFamily: "Arista-Pro-Bold-trial",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  final snackBar = const SnackBar(
    content: Text(
      "Falha no Pagamento pix",
      style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.blueAccent,
  );
}
