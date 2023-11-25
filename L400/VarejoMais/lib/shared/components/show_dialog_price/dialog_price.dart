import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DialogPrice {
  Future<double?> showInputDialog(
      BuildContext context, double valorRestante) async {
    String inputValue = "0.00";
    var formato = NumberFormat.decimalPattern('pt_BR');

    TextEditingController valorController = TextEditingController();
    valorController.text = formato.format(valorRestante);
    final formKey = GlobalKey<FormState>();

    final currencyFormat =
        NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title:
              Text(
                  'Valor Restante: ${currencyFormat.format(valorRestante)}',
                style: const TextStyle(
                 color: Colors.deepOrange,
                ),
              ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: formKey,
                child: TextFormField(
                 controller: valorController,
                  keyboardType: TextInputType.number,
                  validator: (valor) {
                    double total = double.tryParse(valor!) ?? 0;
                    double? valorRestanteDouble = double.tryParse(valorRestante.toStringAsFixed(2));
                    if (valor.isEmpty || valor == "0.00" || total > valorRestanteDouble!){
                      return 'Valor Inválido';
                    }
                    return null;
                  },
                  //decoration: const InputDecoration(labelText: inputValue),
                ),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: TextButton(
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.deepOrange),
                    ),
                    onPressed: () {
                      inputValue = "0.0";
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancelar',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Arista-Pro-Bold-trial",
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green),
                    ),
                    onPressed: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (formKey.currentState!.validate()) {
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        inputValue = valorController.text;

                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text(
                      'OK',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Arista-Pro-Bold-trial",
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ],
        );
      },
    );
    inputValue = inputValue.replaceAll('.', '');
    return double.tryParse(inputValue.replaceAll(',', '.'))?? 0;
  }
}
