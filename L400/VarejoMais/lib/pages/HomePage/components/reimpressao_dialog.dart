import 'package:flutter/material.dart';
import 'package:varejoMais/shared/platform_channel/platform_channel.dart';

class DialogReimpressao {
  final platformChannel = PlatformChannel();

  //final PixController pixController = PixController();

  Future<void> showReimpressaoDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            title: const Text(
              'Opções de Reimpressão',
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
                          await platformChannel.reprint();
                        },
                        style:  ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            backgroundColor:
                            const MaterialStatePropertyAll(Color.fromRGBO(248, 67, 21, 1.0)),
                            padding: const MaterialStatePropertyAll(
                                EdgeInsetsDirectional.zero)),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.payments_outlined,
                              size: 45,
                              color: Colors.white,
                            ),
                            // SizedBox(
                            //   width: 10,
                            // ),
                            Text(
                              'Comprovante Rede',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
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

                        },
                        style:  ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            backgroundColor:
                                const MaterialStatePropertyAll(Colors.blueAccent),
                            padding: const MaterialStatePropertyAll(
                                EdgeInsetsDirectional.zero)),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.pix_outlined,
                              size: 45,
                              color: Colors.white,
                            ),

                            Text(
                              'Comprovante Datapay',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
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
