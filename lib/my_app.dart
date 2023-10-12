import 'package:flutter/material.dart';
import 'package:varejoMais/home_page.dart';
import 'package:varejoMais/pages/Cancelamento.dart';
import 'package:varejoMais/pages/coletor.dart';
import 'package:varejoMais/pages/estoque.dart';
import 'package:varejoMais/pages/reimpressao.dart';
import 'package:varejoMais/pages/Venda/venda.dart';
import 'package:varejoMais/pages/Login/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

    return MaterialApp(
      scaffoldMessengerKey: scaffoldKey,
      title: "Varejo+",
      initialRoute: '/',
      debugShowCheckedModeBanner: false, //shows debug banner
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => HomePage(),
        '/venda': (context) => Venda(),
        '/reimpressao': (context) => const Reimpressao(),
        '/cancelamento': (context) => const Cancelamento(),
        '/estoque': (context) => const Estoque(),
        '/coletor': (context) => const Coletor(),
      },
    );
  }
}
