import 'package:flutter/material.dart';
import 'package:varejoMais/pages/Cancelamento/cancelamento.dart';
import 'package:varejoMais/pages/HomePage/home_page.dart';
import 'package:varejoMais/pages/Login/auth/auth.dart';
import 'package:varejoMais/pages/pagamento/components/pix_datapay.dart';
import 'package:varejoMais/pages/carrinho/carrinho.dart';
import 'package:varejoMais/pages/coletor.dart';
import 'package:varejoMais/pages/estoque.dart';
import 'package:varejoMais/pages/reimpressao.dart';
import 'package:varejoMais/pages/Venda/venda.dart';
import 'package:varejoMais/pages/Login/login_page.dart';
import 'package:varejoMais/pages/VendaFinalizada/venda_finalizada.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

    return MaterialApp(
      scaffoldMessengerKey: scaffoldKey,
      title: "Varejo+",
      initialRoute: '/',
      debugShowCheckedModeBanner: false, //show debug banner
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => HomePage(),
        '/venda': (context) => Venda(),
        '/reimpressao': (context) => const Reimpressao(),
        '/cancelamento': (context) => const Cancelamento(),
        '/estoque': (context) => const Estoque(),
        '/coletor': (context) => const Coletor(),
        '/carrinho': (context) => const Carrinho(),
        '/vendaFinalizada': (context) => const VendaFinalizada(),
        '/auth': (context) => const AuthPage(),
      },
    );
  }
}
