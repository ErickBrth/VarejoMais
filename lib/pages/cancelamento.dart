
import 'package:flutter/material.dart';

class Cancelamento extends StatelessWidget{
  const Cancelamento({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Material(
          child: Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/logo.png', width: 297, height: 120),
                    Text('Cancelamento'),
                  ]
              )
          ),
        ),
      ),
    );
  }

}