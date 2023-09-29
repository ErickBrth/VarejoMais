import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


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
                        keyboardType: TextInputType.emailAddress,
                        validator: (email){
                          if(email == null || email.isEmpty){
                            return "digite seu email";
                          }else if(!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(emailController.text)) {
                              return 'Por favor, digite um e-mail correto';

                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Usuário",
                        ),
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: const TextInputType.numberWithOptions(),
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
                            // if(isUserLoggedIn()){
                              login(emailController.text.toString(), passwordController.text.toString());
                           // }
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

  // Future<void> storeToken(String token) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('auth_token', token);
  // }
  //
  //  getToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('auth_token');
  //   return token;
  // }

  Future<bool>verifyToken() async{
    SharedPreferences token = await SharedPreferences.getInstance();;
    if (token.getString('id') != null) {
      return true;  // O usuário está logado.
    } else {
      return false; // O usuário não está logado.
    }
  }
  
  @override
  void initState(){
    super.initState();
    verifyToken().then((value) {
      if(value){
        Navigator.of(context).pushReplacementNamed('/home');
      }else{
        print("usuario nao logado");
      }
    });
  }
  
  
  void login(String email, String password) async {
    try{
      Response response = await post(
        Uri.parse("https://www.datapaytecnologia.com.br/erp/apiErp/login/login.php"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'email': email,
            'senha': password,
          }),
      );

      if(response.statusCode == 200){

        var data = jsonDecode(response.body.toString());

        String id = data['result'][0]['id']; //id do usuario



      }else{
        print('failed');
      }
    }catch(e){
      print(e.toString());
    }
  }

}
