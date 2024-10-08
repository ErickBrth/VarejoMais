import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varejoMais/pages/HomePage/components/cancelamento_dialog.dart';

import '../login/login.dart';

class AuthPage extends StatelessWidget {
   const AuthPage({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    return Material(
      child: SafeArea(
        child: Scaffold(
          body: Form(
            key: _formKey,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/logo.png',
                          width: 297, height: 120),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (email) {
                          if (email == null || email.isEmpty) {
                            return "Digite seu email";
                          } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(emailController.text)) {
                            return 'Por favor, digite um e-mail correto';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Usuário",
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      //password
                      TextFormField(
                        controller: passwordController,
                        keyboardType: const TextInputType.numberWithOptions(),
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Senha",
                        ),
                        validator: (senha) {
                          if (senha == null || senha.isEmpty) {
                            return 'Digite uma senha válida';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if (_formKey.currentState!.validate()) {
                              bool loginState = await Login().login(emailController.text, passwordController.text);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              if (loginState) {
                                Navigator.of(context).pushReplacementNamed('/home');
                                DialogCancelamento().showCancelamentoDialog(context);
                              } else {
                                passwordController.clear();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            }
                          },
                          style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromRGBO(248, 67, 21, 1.0))),
                          child: const Text("Entrar")),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );

  }

   final snackBar = const SnackBar(
     content: Text(
       "Email ou Senha invalidos",
       textAlign: TextAlign.center,
     ),
     backgroundColor: Colors.redAccent,
   );

}

