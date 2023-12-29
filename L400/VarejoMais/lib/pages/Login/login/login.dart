
import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login{
  String idUsuario = "";
  String idEmpresa = "";

  Future<void> storeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<bool> verifyToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('token') != null) {
      return true; // O usuário está logado.
    } else {
      return false; // O usuário nao está logado.
    }
  }
  Future<void> storeIdEmpresa(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('idEmpresa', token);
  }

  Future<bool> login(String email, String senha) async {
    try {
      Response response = await post(
        Uri.parse(
            "https://www.datapaytecnologia.com.br/erp/apiErp/login/login.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'senha': senha,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());

        idUsuario = data['result'][0]['id'].toString(); //id do usuario
        idEmpresa = data['result'][0]['empresa'].toString();
        await storeToken(idUsuario);
        await storeIdEmpresa(idEmpresa);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}