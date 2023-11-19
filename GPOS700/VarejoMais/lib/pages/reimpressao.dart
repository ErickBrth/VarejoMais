
import 'package:flutter/material.dart';

class Reimpressao extends StatelessWidget{
  const Reimpressao({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Material(
          child: Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/logo.png'),
                    Text('Reimpressao'),
                  ]
              )
          ),
        ),
      ),
    );
  }

}