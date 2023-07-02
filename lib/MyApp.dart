import 'package:flutter/material.dart';
import 'package:varejoMais/HomeController.dart';
import 'package:varejoMais/HomePage.dart';
import 'package:varejoMais/pages/Cancelamento.dart';
import 'package:varejoMais/pages/coletor.dart';
import 'package:varejoMais/pages/delivery.dart';
import 'package:varejoMais/pages/estoque.dart';
import 'package:varejoMais/pages/reimpressao.dart';
import 'package:varejoMais/pages/venda.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Varejo+",
      initialRoute: '/',
      routes: {
        '/' : (context) => const HomePage(),
        '/venda' : (context) => const Venda(),
        '/reimpressao' : (context) => const Reimpressao(),
        '/cancelamento' : (context) => const Cancelamento(),
        '/estoque' : (context) => const Estoque(),
        '/coletor' : (context) => const Coletor(),
        '/delivery' : (context) => const Delivery(),
      },
    );
  }
}
