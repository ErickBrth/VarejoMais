import 'package:flutter/material.dart';
import 'package:varejo_mais/HomeController.dart';
import 'package:varejo_mais/HomePage.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Varejo+",
      home: SafeArea(
          child: HomePage()
      ),
    );
  }
}