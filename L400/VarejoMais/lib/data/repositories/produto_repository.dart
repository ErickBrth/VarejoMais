import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:varejoMais/data/http/exceptions.dart';
import 'package:varejoMais/data/http/http_client.dart';
import 'package:http/http.dart' as http;
import 'package:varejoMais/data/models/produto_model.dart';

abstract class IProdutoRepository {
  Future<List<ProdutoModel>> getProdutos();
}

class ProdutoRepository implements IProdutoRepository {
  final IHttpClient client;
  ProdutoRepository({required this.client});

  @override
  Future<List<ProdutoModel>> getProdutos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idEmpresa = prefs.getString('idEmpresa');
    String apiUrl =
        'https://ovarejomais.com.br/erp/apiErp/produtos/listar.php';

    final Map<String, dynamic?> requestBody = {
      'empresa': idEmpresa,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      final List<ProdutoModel> produtos = [];

      final body = jsonDecode(response.body);
      body['resultado'].map((item) {
        final ProdutoModel produto = ProdutoModel.fromMap(item);
        produtos.add(produto);
      }).toList();

      return produtos;
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não é válida");
    } else {
      throw NotFoundException("Não foi possível carregar os produtos");
    }
  }
}
