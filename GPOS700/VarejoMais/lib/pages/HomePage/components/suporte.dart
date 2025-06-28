import 'package:flutter/material.dart';

class Suporte {
  Future<void> showSuporteDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            title: const Text(
              'Entre em Contato Com o Suporte',
              style: TextStyle(
                fontFamily: "Arista-Pro-Bold-trial",
                fontWeight: FontWeight.w700,
              ),
            ),
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/images/zapLogo.png",
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 20,),
                const Text(
                    "0800 606 8144",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,

                  ),
                ),
              ],
            ),
          );
        });
  }
}
