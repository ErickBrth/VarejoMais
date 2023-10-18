import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';



import 'package:varejoMais/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String id = "";
  String idEmpresa = "";


  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    verifyToken().then((value) {
      if (value) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Material(
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
                            bool loginState = await login();
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            if (loginState) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
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
          )),
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

  Future<void> storeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String> getToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String minhaString = prefs.getString('idEmpresa') ?? 'Valor Padrão';
    return minhaString;
  }


  Future<bool> verifyToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString("token").toString().isNotEmpty) {
      return false; // O usuário não está logado.
    } else {
      return true; // O usuário está logado.
    }
  }
  Future<void> storeIdEmpresa(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('idEmpresa', token);

  }

  Future<bool> login() async {
    try {
      Response response = await post(
        Uri.parse(
            "https://www.datapaytecnologia.com.br/erp/apiErp/login/login.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': emailController.text,
          'senha': passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());

        id = data['result'][0]['id'].toString(); //id do usuario
        idEmpresa = data['result'][0]['empresa'].toString();
        storeToken(id);
        storeIdEmpresa(idEmpresa);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

}
