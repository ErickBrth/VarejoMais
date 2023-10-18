import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:varejoMais/data/controllers/carrinho_controller.dart';

class Carrinho extends StatefulWidget {
  const Carrinho({super.key});

  @override
  State<Carrinho> createState() => _CarrinhoState();
}

class _CarrinhoState extends State<Carrinho> {

  final price = 32.99;
  final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  @override
  Widget build(BuildContext context) {
    final carrinho = Provider.of<CarrinhoController>(context);
    var total = carrinho.calcularTotal();
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              // Ícone de seta de voltar
              onPressed: () {
                Navigator.of(context).pop(); // Navegar de volta
              },
              iconSize: 32.0,
              padding: const EdgeInsets.only(top: 15),
              color: const Color.fromRGBO(248, 67, 21, 1.0),
            ),
            title: Container(
              margin: const EdgeInsets.only(left: 30, top: 20),
              child: const Text(
                "Carrinho",
                style: TextStyle(
                    fontFamily: "Arista-Pro-Bold-trial",
                    color: Color.fromRGBO(248, 67, 21, 1.0),
                    fontSize: 40),
              ),
            ),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          )),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => Container(
                    height: 10,
                  ),
              padding: const EdgeInsets.all(16),
              itemCount: carrinho.produtos.length,
              itemBuilder: (_, index) {
                final produto = carrinho.produtos.keys.elementAt(index);
                final quantidade = carrinho.produtos[produto];
                final totalProduto = (double.parse(produto.valor_venda) * quantidade!).toStringAsFixed(2);

                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(10),
                        backgroundColor: MaterialStatePropertyAll(
                          Colors.white,
                        ),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          width: 50,
                          //alignment: AlignmentDirectional.center,
                          child: Image.network(
                            "https://datapaytecnologia.com.br/erp/sistema/images/produtos/${produto.imagem}",
                          ),
                        ),
                        title: Row(
                          children: [
                             Expanded(
                               child: SizedBox(
                                 height: 40,
                                 child: Text(
                                  "${produto.nome}",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Arista-Pro-Bold-trial",
                                    fontSize: 24,
                                  ),
                            ),
                               ),
                             ),
                            Expanded(
                              child: Container(
                                alignment: AlignmentDirectional.centerEnd,
                                height: 25,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      carrinho.removerProduto(produto);
                                    });
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                      const Color.fromRGBO(248, 67, 21, 1.0),
                                    ),
                                  ),
                                  child: Text("Remover"),
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "$quantidade x ${produto.valor_venda}",
                                style: TextStyle(
                                  color: Color.fromRGBO(248, 67, 21, 1.0),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              // const SizedBox(height: 20),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(top: 5),
                                  child: Container(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: Text(
                                      'R\$ ${totalProduto}',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ],
                );
              }),
          ),
          Divider(height: 2,color: Colors.black38, thickness: 2,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 35,
                child: Text(
                  "SUB TOTAL ",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Arista-Pro-Bold-trial",
                  ),
                ),
                alignment: AlignmentDirectional.bottomEnd,
              ),
              Container(
                height: 40,
                child: Text(
                  currencyFormat.format(total),
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                    //fontFamily: "Arista-Pro-Bold-trial",
                    color: Color.fromRGBO(248, 67, 21, 1.0),
                  ),
                ),
                alignment: AlignmentDirectional.bottomEnd,
              ),
            ],
          ),
          SizedBox(
            height: 60,
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(248, 67, 21, 1.0)),
              ),
                child: Text("FINALIZAR PEDIDO"),
            ),
          )
       ]
      ),
    );
  }
}
