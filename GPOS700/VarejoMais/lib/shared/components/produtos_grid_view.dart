import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:varejoMais/data/controllers/carrinho_controller.dart';
import 'package:varejoMais/data/models/produto_model.dart';

class ProdutosGridview extends StatefulWidget {
  const ProdutosGridview({super.key, required this.produtosDisplay});
  final List<ProdutoModel> produtosDisplay;
  @override
  State<ProdutosGridview> createState() => _ProdutosGridviewState();
}

class _ProdutosGridviewState extends State<ProdutosGridview> {

  @override
  Widget build(BuildContext context) {
    final carrinho = Provider.of<CarrinhoController>(context);
        return GridView.builder(
            shrinkWrap: true,
            itemCount: widget.produtosDisplay.length,
            padding: const EdgeInsets.all(8.0),

            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 25.0,
              mainAxisExtent: 146,
            ),
            itemBuilder: (_, int index) {
              final item = widget.produtosDisplay[index];
              var quantidade = carrinho.produtos[item];

              return Column(children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if(int.parse(item.estoque) >= carrinho.qtdProdutos(item)){
                        _adicionarProdutoAoCarrinho(item);
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "O produto: '${item.nome}' não tem mais estoque",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                      }
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 140,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.black),
                    ),
                    child: Stack(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 35,
                              height: 35,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(
                                    248, 67, 21, 1.0),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(8)),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${quantidade ??= 0}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight:
                                      FontWeight.w800,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Image.network(
                                "https://datapaytecnologia.com.br/erp/sistema/images/produtos/${item
                                    .imagem}",
                                height: 75,
                                width: 75,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                item.nome.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment:
                          MainAxisAlignment.end,
                          children: [
                            Container(
                              alignment: Alignment.bottomCenter,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(
                                    248,
                                    67,
                                    21,
                                    1.0),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(
                                      8),
                                  bottomRight: Radius.circular(
                                      8),
                                ),
                              ),
                              child: Text(
                                "R\$ ${item.valor_venda
                                    .toString()}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]);
            });
      }
  void _adicionarProdutoAoCarrinho(ProdutoModel produto) {
    final carrinho = Provider.of<CarrinhoController>(context, listen: false);
    carrinho.adicionarProduto(produto);
  }
}
