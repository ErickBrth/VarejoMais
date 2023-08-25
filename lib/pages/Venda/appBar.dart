import 'package:flutter/material.dart';

class AppBarStatic extends StatefulWidget{
  const AppBarStatic(
      {super.key});

  @override
  State<AppBarStatic> createState() => _AppBarStaticState();

}

class _AppBarStaticState extends State<AppBarStatic> {
  bool shadowColor = false;
  double? scrolledUnderElevation;


  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,

        scrolledUnderElevation: scrolledUnderElevation,
        shadowColor: shadowColor ? Theme.of(context).colorScheme.shadow : null,
      ),
      body:
      TextField(
        //TODO
      ),
    );
  }
}