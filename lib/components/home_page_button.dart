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
      ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 40),
        style: ButtonStyle(
          alignment: Alignment.centerLeft,
          padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 16),
          ),
          textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(fontSize: 30,
            fontFamily: "Arista-Pro-Bold-trial",
            ),
          ),
          elevation: MaterialStateProperty.all(10),

          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          iconColor: MaterialStateProperty.all<Color>(
            const Color.fromRGBO(248, 67, 21, 1.0),
          ),
          shadowColor: MaterialStateProperty.all<Color>(Colors.black),
          // maximumSize: MaterialStateProperty.all<Size>(const Size(370, 70)),
          minimumSize: MaterialStateProperty.all<Size>(const Size(340, 65)),


        ),
        label: Text(label),
    );
  }
}
