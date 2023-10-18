
import 'package:flutter/material.dart';
import 'package:varejoMais/data/models/produto_model.dart';

class CarrinhoController extends ChangeNotifier{
  Map<ProdutoModel, int> _produtosNoCarrinho = {};

  Map<ProdutoModel, int> get produtos => _produtosNoCarrinho;

  void adicionarProduto(ProdutoModel produto) {
    if (_produtosNoCarrinho.containsKey(produto)) {
      _produtosNoCarrinho.forEach((key, value) {
        if(key.id == produto.id){
          _produtosNoCarrinho[produto] = (_produtosNoCarrinho[produto] ?? 0) + 1;
        }
      });
    } else {
      _produtosNoCarrinho[produto] = 1;
    }
    notifyListeners();
  }

  void removerProduto(ProdutoModel produto) {
    if (_produtosNoCarrinho.containsKey(produto)) {
      if ((_produtosNoCarrinho[produto] ?? 0) > 1) {
        _produtosNoCarrinho[produto] = (_produtosNoCarrinho[produto] ?? 0) - 1;
      } else {
        _produtosNoCarrinho.remove(produto);
      }
      notifyListeners();
    }
  }

  double calcularTotal() {
    double total = 0;
    _produtosNoCarrinho.forEach((produto, quantidade) {
      total += double.parse(produto.valor_venda) * quantidade;
    });
    return total;
  }
}