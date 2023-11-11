
import 'package:flutter/material.dart';

class PagamentoController{
  var valorRestate = ValueNotifier<double>(0.0);

  get getValorRestante => valorRestate.value;

  void calculaValorRestante(double valorPago, double valorTotal){
    valorRestate.value = valorTotal - valorPago;
  }

  void setValorRestante(double valorInicial){
    valorRestate.value = valorInicial;
  }
}