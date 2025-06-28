import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:varejoMais/data/repositories/produto_repository.dart';
import 'package:varejoMais/data/http/exceptions.dart';
import 'package:varejoMais/data/models/produto_model.dart';

class ProdutoStore {
  final IProdutoRepository repository;

  //variavel reativa para o loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  //variavel reativa para o state
  final ValueNotifier<List<ProdutoModel>> state =
      ValueNotifier<List<ProdutoModel>>([]);

  //variavel reativa para o erro
  final ValueNotifier<String> erro = ValueNotifier<String>("");

  ProdutoStore({required this.repository});

  Future getProdutos() async {
    isLoading.value = true;
    try {
      final result = await repository.getProdutos();

      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }
}
