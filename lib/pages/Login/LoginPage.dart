import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // final _formKey = GlobalKey<FormState>();
  // final _scaffoldKey = GlobalKey<ScaffoldState>();
  //
  // bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
    child: Scaffold(
      body: Material(
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/logo.png', width: 297, height: 120),

                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Usuário",
                        ),
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Senha",
                        ),
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return 'Por favor, insira sua senha';
                        //   }
                        //   return null;
                        // },
                      ),
                      SizedBox(height: 15,),
                      ElevatedButton(
                          onPressed: () {
                            login(emailController.text.toString(), passwordController.text.toString());
                          },
                          style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(248, 67, 21, 1.0))),
                          child: const Text("Entrar")),
                    ]
                ),
              ),
            )
        ),
    ),
    );
  }

  void login(String email, String password) async {
    try{
      Response response = await post(
        Uri.parse("https://www.datapaytecnologia.com.br/erp/apiErp/login/login.php"),
        body: {
          'email' : email,
          'senha' : password,
        }
      );
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print(data);
        print('ok');
      }else{
        print('failed');
      }
    }catch(e){
      print(e.toString());
    }
  }

}
