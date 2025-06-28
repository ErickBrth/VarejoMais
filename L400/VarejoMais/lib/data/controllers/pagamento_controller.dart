import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varejoMais/data/models/produto_model.dart';

import '../http/exceptions.dart';

class PagamentoController{
  var valorRestate = ValueNotifier<double>(0.0);

  get getValorRestante => valorRestate.value;

  void calculaValorRestante(double valorPago, double valorTotal){
    valorRestate.value = valorTotal - valorPago;
  }

  void setValorRestante(double valorInicial){
    valorRestate.value = valorInicial;
  }

  Future<void> storeIdPedido(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('idPedido', token);
  }

  Future<String> registraPagamento(String formaPagamento,Map<ProdutoModel,int> itens, double valorAPagar) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idEmpresa = prefs.getString('idEmpresa');
    String? idUsuario = prefs.getString('token');
    List<Map<String, dynamic>> jsonList = [];
    itens.forEach((produto, quantidade) {
      jsonList.add({
        'id_produto':produto.id,
        'valor':produto.valor_venda,
        'quantidade':quantidade
      });
    });

    String apiUrl =
        'https://ovarejomais.com.br/erp/apiErp/vendas/salvar.php';

    final Map<String, dynamic> requestBody = {
      "id_usuario":idUsuario,
      "id_empresa":idEmpresa,
      "forma_pgto":formaPagamento,
      "totalvenda":valorAPagar,
      "itens":jsonList
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(requestBody),
    );
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      String result = body['resultado'];
      storeIdPedido(result);
      return "ok!";
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não é válida");
    } else {
      throw Exception("Não foi possível realizar a venda");
    }
  }
}