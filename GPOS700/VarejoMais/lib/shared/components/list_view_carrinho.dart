import 'package:flutter/material.dart';
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
          height: 10,
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
                style: const ButtonStyle(
                  elevation: MaterialStatePropertyAll(10),
                  backgroundColor: MaterialStatePropertyAll(
                    Colors.white,
                  ),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  minVerticalPadding: 0,
                  leading: Image.network(
                    "https://datapaytecnologia.com.br/erp/sistema/images/produtos/${produto.imagem}",
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Container(
                          // /padding: EdgeInsetsDirectional.only(top: 10),
                          // color: Colors.blue,
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
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              Color.fromRGBO(248, 67, 21, 1.0),
                            ),
                          ),
                          child: const Text("Remover"),
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
