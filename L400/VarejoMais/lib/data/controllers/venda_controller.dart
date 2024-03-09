import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:varejoMais/data/http/exceptions.dart';

class VendaController {

  Future<String> cancelaVenda() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? clientId = prefs.getString('token');
    String? idEmpresa = prefs.getString('idEmpresa');
    String? idPedido = prefs.getString('idPedido');

    String apiUrl =
        "https://datapaytecnologia.com.br/erp/apiErp/vendas/cancelar.php";

    final Map<String, dynamic> requestBody = {
      "client_id": clientId,

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

      return body;
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não é válida");
    } else {
      throw NotFoundException("Não foi possível cancelar a venda");
    }
  }
}
