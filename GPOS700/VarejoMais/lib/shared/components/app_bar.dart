import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:varejoMais/data/controllers/carrinho_controller.dart';

class App_Bar extends StatelessWidget {
  const App_Bar({super.key, required this.leading, required this.title});
  final Widget leading;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          //leadingWidth: 30,
          backgroundColor: Colors.white,
          leading: IconButton(
            padding: const EdgeInsetsDirectional.only(top: 20, start: 20),
            icon: leading,
            onPressed: () {
              Navigator.of(context).pop(); // Navegar de volta
            },
            iconSize: 35.0,
            color: const Color.fromRGBO(248, 67, 21, 1.0),

          ),
          title: Container(
            //color: Colors.blue,
            padding: const EdgeInsetsDirectional.only(top: 20, end: 25),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                    fontFamily: "Arista-Pro-Bold-trial",
                    color: Color.fromRGBO(248, 67, 21, 1.0),
                    fontSize: 40),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
