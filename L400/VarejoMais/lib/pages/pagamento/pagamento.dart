import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:varejoMais/data/controllers/pagamento_controller.dart';
import 'package:varejoMais/pages/Venda/components/app_bar_pagamentos.dart';
import 'package:varejoMais/shared/components/bottom_button.dart';
import 'package:varejoMais/pages/pagamento/components/pagamento_button_grid.dart';

class Pagamento extends StatefulWidget {
  const Pagamento(
      {super.key, required this.totalCompra, required this.pagamentoController});
  final double totalCompra;
  final PagamentoController pagamentoController;


  @override
  State<Pagamento> createState() => _PagamentoState();
}

class _PagamentoState extends State<Pagamento> {
  bool voltar = true;
  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: ValueListenableBuilder(
          valueListenable: widget.pagamentoController.valorRestate,
          builder: (context, valor, child){
            if(valor != widget.totalCompra){
                voltar = false;
            }
            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(70),
                  child: AppBarPagamento(
                      leading: const Icon(Icons.arrow_back),
                      title: "Pagamentos", voltar: voltar,)
              ),
              body: Material(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      //flex: 1,
                      child: Center(
                        child: SizedBox(
                          //height: MediaQuery.of(context).size.height,
                          child: ButtonGrid(totalVenda: widget.totalCompra, pagamentoController: widget.pagamentoController),
                        ),
                      ),
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Divider(height: 2,color: Colors.black38, thickness: 2,),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              //height: 20,
                              padding: const EdgeInsetsDirectional.only(top: 3),
                              alignment: AlignmentDirectional.centerEnd,
                              child: const Text(
                                "TOTAL ",
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Arista-Pro-Bold-trial",
                                ),
                              ),
                            ),
                            Container(
                              //height: 30,
                              alignment: AlignmentDirectional.topEnd,
                              child: Text(
                                currencyFormat.format(widget.totalCompra),
                                style: const TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w500,
                                  //fontFamily: "Arista-Pro-Bold-trial",
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsetsDirectional.only(top: 3),
                              alignment: AlignmentDirectional.bottomEnd,
                              child: const Text(
                                "RESTANTE ",
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Arista-Pro-Bold-trial",
                                ),
                              ),
                            ),
                            Container(
                              alignment: AlignmentDirectional.bottomEnd,
                              child: Text(
                                currencyFormat.format(valor),
                                style: const TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w500,
                                  //fontFamily: "Arista-Pro-Bold-trial",
                                  color: Color.fromRGBO(248, 67, 21, 1.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BottomButton(text: "PAGAMENTOS"),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}


