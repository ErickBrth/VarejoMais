import 'package:flutter/material.dart';

class PagamentoButton extends StatelessWidget {
  const PagamentoButton(
      {required this.icon,
        required this.label,
        required this.onPressed,
        Key? key})
      : super(key: key);
  final Function()? onPressed;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        alignment: Alignment.center,
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        ),
        side: const MaterialStatePropertyAll<BorderSide>(
            BorderSide(color: Color.fromRGBO(248, 67, 21, 1.0), width: 2.0)),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            fontSize: 25,
            fontFamily: "Arista-Pro-Bold-trial",
          ),
        ),
        elevation: MaterialStateProperty.all(10),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        iconColor: MaterialStateProperty.all<Color>(
          const Color.fromRGBO(248, 67, 21, 1.0),
        ),
        shadowColor: MaterialStateProperty.all<Color>(Colors.black),
        // maximumSize: MaterialStateProperty.all<Size>(const Size(220, 140)),
        // minimumSize: MaterialStateProperty.all<Size>(const Size(160, 110)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 5),
          Expanded(
            child: Icon(
              icon,
              size: 90,
            ),
          ), // Ícone
           // const SizedBox(height: 5), // Espaçamento entre o ícone e o texto
          Expanded(
            child: Container(
              alignment: AlignmentDirectional.bottomCenter,
                //color: Colors.blue,
                child: Text(
                    label,
                  textAlign: TextAlign.center,
                )
            ),
          ),
          const SizedBox(height: 10),// Texto
        ],
      ),
    );
  }
}
