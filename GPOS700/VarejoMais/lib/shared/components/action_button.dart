import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton(
      {required this.label,
      required this.onPressed,
       this.icon,
      Key? key})
      : super(key: key);

  final String label;
  final Function()? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color.fromRGBO(239, 240, 242, 1.0),
        ),
        side: const MaterialStatePropertyAll<BorderSide>(
            BorderSide(color: Color.fromRGBO(248, 67, 21, 1.0), width: 2.0)),
        padding: MaterialStatePropertyAll(EdgeInsetsDirectional.only(top: 5,bottom: 5)),
        elevation: MaterialStateProperty.all(8),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),

        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            //textAlign: TextAlign.center,
            style: const TextStyle(
                fontFamily: "Arista-Pro-Bold-trial",
                color: Color.fromRGBO(248, 67, 21, 1.0),
                fontSize: 22),
          ),
          Container(
            padding: const EdgeInsetsDirectional.only(start: 10),
            child: Icon(
              icon,
              size: 35,
              color: const Color.fromRGBO(248, 67, 21, 1.0),
            ),
          ),
        ],
      ),
    );
  }
}
