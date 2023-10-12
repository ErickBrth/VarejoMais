import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({required this.label, required this.onPressed, Key? key})
      : super(key: key);

  final String label;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color.fromRGBO(239, 240, 242, 1.0),
        ),
        elevation: MaterialStateProperty.all(8),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        fixedSize: MaterialStateProperty.all(const Size(30, 45)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              label,
              style: const TextStyle(
                  fontFamily: "Arista-Pro-Bold-trial",
                  color: Color.fromRGBO(248, 67, 21, 1.0),
                  fontSize: 20),
            ),
          ),
          Container(
            padding: const EdgeInsetsDirectional.only(start: 14),
            child: const Icon(
              Icons.sync_sharp,
              size: 35,
              color: Color.fromRGBO(248, 67, 21, 1.0),
            ),
          ),
        ],
      ),
    );
  }
}
