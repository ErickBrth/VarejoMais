
import 'package:flutter/material.dart';

class Estoque extends StatelessWidget{
  const Estoque({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Material(
          child: Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/logo.png'),
                    Text('Estoque'),
                  ]
              )
          ),
        ),
      ),
    );
  }

}