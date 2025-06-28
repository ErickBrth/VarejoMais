
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:varejoMais/data/controllers/carrinho_controller.dart';

class AlertDialogVenda{

  Future<void> showVendaDialog(BuildContext context) async {
    final carrinho = Provider.of<CarrinhoController>(context, listen: false);
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            title: const Text(
              'Deseja Limpar o Carrinho?',
              style: TextStyle(
                fontFamily: "Arista-Pro-Bold-trial",
                fontWeight: FontWeight.w800,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          carrinho.produtos.clear();
                          carrinho.zerarQuantidades();
                          Navigator.popUntil(context, ModalRoute.withName('/venda'));
                        },
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromRGBO(248, 67, 21, 1.0)),
                            padding: MaterialStatePropertyAll(
                                EdgeInsetsDirectional.zero)),
                        child: const Text(
                          'Sim',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            fontFamily: "Arista-Pro-Bold-trial",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                        },
                        style: const ButtonStyle(
                          backgroundColor:
                          MaterialStatePropertyAll(Colors.blueAccent),
                          padding: MaterialStatePropertyAll(
                              EdgeInsetsDirectional.zero),
                        ),
                        child: const Text(
                          'Não',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            fontFamily: "Arista-Pro-Bold-trial",
                          ),
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
}