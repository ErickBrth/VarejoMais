import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:varejoMais/data/controllers/carrinho_controller.dart';
import 'my_app.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CarrinhoController(),
      child: MyApp(),
    ),
  );
}
