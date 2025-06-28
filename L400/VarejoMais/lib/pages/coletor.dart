
import 'package:flutter/material.dart';

class Coletor extends StatelessWidget{
  const Coletor({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Material(
          child: Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/logo.png'),
                    const Text('Coletor'),
                  ]
              )
          ),
        ),
      ),
    );
  }

}