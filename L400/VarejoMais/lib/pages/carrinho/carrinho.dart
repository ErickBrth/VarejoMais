import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:varejoMais/data/controllers/carrinho_controller.dart';
import 'package:varejoMais/data/controllers/pagamento_controller.dart';
import 'package:varejoMais/pages/pagamento/pagamento.dart';
import 'package:varejoMais/shared/components/app_bar.dart';
import 'package:varejoMais/shared/components/bottom_button.dart';
import 'package:varejoMais/shared/components/list_view_carrinho.dart';

class Carrinho extends StatefulWidget {
  const Carrinho({super.key});

  @override
  State<Carrinho> createState() => _CarrinhoState();
}

class _CarrinhoState extends State<Carrinho> {

  final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
  final pagamentoController = PagamentoController();

  @override
  void initState() {
    super.initState();
    pagamentoController.valorRestate.addListener(() {
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final carrinho = Provider.of<CarrinhoController>(context);
    var total = carrinho.calcularTotal();
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: App_Bar(
            leading: Icon(Icons.arrow_back),
            title: "Carrinho",
          ),
        ),
        body: Material(
          child: Column(
            children: [
              const Expanded(
                child: ListCarrinho(),
              ),
              const Divider(height: 2,color: Colors.black38, thickness: 2,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 35,
                    alignment: AlignmentDirectional.bottomEnd,
                    child: const Text(
                      "SUB TOTAL ",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Arista-Pro-Bold-trial",
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Text(
                      currencyFormat.format(total),
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(248, 67, 21, 1.0),
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  if(total > 0){
                    pagamentoController.setValorRestante(total);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Pagamento(totalCompra: total, pagamentoController: pagamentoController),
                      ),
                    );
                  }
                },
                  child: const BottomButton(text: "FINALIZAR PEDIDO")
              ),
           ]
          ),
        ),
      ),
    );
  }
}
