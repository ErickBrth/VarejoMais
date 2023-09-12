import 'package:flutter/material.dart';
import 'package:varejoMais/HomePage.dart';
import 'package:varejoMais/pages/Cancelamento.dart';
import 'package:varejoMais/pages/coletor.dart';
import 'package:varejoMais/pages/estoque.dart';
import 'package:varejoMais/pages/reimpressao.dart';
import 'package:varejoMais/pages/Venda/venda.dart';
import 'package:varejoMais/pages/Login/LoginPage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Varejo+",
      initialRoute: '/',
      debugShowCheckedModeBanner: false, //shows debug banner
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/venda': (context) => Venda(),
        '/reimpressao': (context) => const Reimpressao(),
        '/cancelamento': (context) => const Cancelamento(),
        '/estoque': (context) => const Estoque(),
        '/coletor': (context) => const Coletor(),
        //'/login': (context) => const LoginPage(),
      },
    );
  }
}
