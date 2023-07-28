import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  const HomeButton(
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
    return
      ElevatedButton(

        onPressed: onPressed,

        style: ButtonStyle(
          alignment: Alignment.center,
          padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(horizontal: 10),
          ),
          textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(fontSize: 22,
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
          maximumSize: MaterialStateProperty.all<Size>(const Size(200, 110)),
          minimumSize: MaterialStateProperty.all<Size>(const Size(160, 110)),


        ),

        child: Column(
          children: [
            Icon(icon, size: 70,), // Ícone
            const SizedBox(height: 10), // Espaçamento entre o ícone e o texto
            Text(label), // Texto
          ],
        ),


    );
  }
}
