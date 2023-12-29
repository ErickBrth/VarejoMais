

import 'package:flutter/material.dart';

import 'package:varejoMais/shared/platform_channel/platform_channel.dart';

class DialogCancelamento {
  final platformChannel = PlatformChannel();

  Future<void> showCancelamentoDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            title: const Text(
              'Opções de Cancelamento',
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
                        onPressed: () async {
                          Navigator.of(context).pop();
                          await platformChannel.estorno();
                        },
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromRGBO(248, 67, 21, 1.0)),
                            padding: MaterialStatePropertyAll(
                                EdgeInsetsDirectional.zero)),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.payments_outlined,
                              size: 45,
                            ),
                            Text(
                              'Rede',
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
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushNamed('/cancelamento');
                        },
                        style: const ButtonStyle(
                            backgroundColor:
                            MaterialStatePropertyAll(Colors.blueAccent),
                            padding: MaterialStatePropertyAll(
                                EdgeInsetsDirectional.zero),
                        ),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.monetization_on_outlined,
                              size: 45,
                            ),
                            Text(
                              'Datapay',
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
}