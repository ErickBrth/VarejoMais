
import 'package:flutter/material.dart';

class Venda extends StatelessWidget{
  const Venda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
              children: [
              Image.asset('assets/images/logo.png')
          ]
          )
        ),
      ),
    );
  }

}