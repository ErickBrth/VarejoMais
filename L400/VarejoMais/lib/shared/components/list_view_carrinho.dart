import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:varejoMais/data/controllers/carrinho_controller.dart';

class ListCarrinho extends StatefulWidget {
  const ListCarrinho({super.key});

  @override
  State<ListCarrinho> createState() => _ListCarrinhoState();
}

class _ListCarrinhoState extends State<ListCarrinho> {
  @override
  Widget build(BuildContext context) {
    final carrinho = Provider.of<CarrinhoController>(context);

    return ListView.separated(
        separatorBuilder: (context, index) => Container(
              height: 15,
            ),
        padding: const EdgeInsets.all(16),
        itemCount: carrinho.produtos.length,
        itemBuilder: (_, index) {
          final produto = carrinho.produtos.keys.elementAt(index);
          final quantidade = carrinho.produtos[produto];
          final totalProduto = double.parse(produto.valor_venda) * quantidade!;

          return Column(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(
                          color: Colors.black,
                          width: 1.0),// Define a borda aqui
                    ),
                  ),
                  elevation: const MaterialStatePropertyAll(15),
                  backgroundColor: const MaterialStatePropertyAll(
                    Colors.white,
                  ),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  minVerticalPadding: 0,
                  leading: Image.network(
                    "https://datapaytecnologia.com.br/erp/sistema/images/produtos/${produto.imagem}",
                    alignment: Alignment.topCenter,
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsetsDirectional.only(end: 0),
                          width: 150,
                          child: Text(
                            "${produto.nome}",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Arista-Pro-Bold-trial",
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.centerEnd,
                        height: 25,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              carrinho.removerProduto(produto);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(248, 67, 21, 1.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            minimumSize: Size.zero,
                          ),
                          child: const Text(
                            "Remover",
                            style: TextStyle(color: Colors.white),
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
                          style: const TextStyle(
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
                                'R\$ ${totalProduto.toStringAsFixed(2)}',
                                style: const TextStyle(
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
        });
  }
}
