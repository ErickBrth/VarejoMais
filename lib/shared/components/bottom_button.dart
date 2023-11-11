import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 58,
      width: double.infinity,
      child: Container(
        color: const Color.fromRGBO(248, 67, 21, 1.0),
        child: Container(
          alignment: AlignmentDirectional.center,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: "Arista-Pro-Bold-trial",
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}
