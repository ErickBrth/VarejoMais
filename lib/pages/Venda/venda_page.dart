import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:varejoMais/data/controllers/carrinho_controller.dart';
import 'package:varejoMais/data/providers/cart_provider.dart';
import 'package:varejoMais/data/repositories/produto_repository.dart';
import 'package:varejoMais/data/http/http_client.dart';
import 'package:varejoMais/data/models/produto_model.dart';
import 'package:varejoMais/data/stores/produto_store.dart';
import 'package:varejoMais/pages/carrinho/carrinho.dart';
import 'package:varejoMais/shared/components/action_button.dart';
import 'package:varejoMais/shared/components/search.dart';

class VendaPage extends StatefulWidget {
  const VendaPage({super.key});

  @override
  State<VendaPage> createState() => _VendaPageState();
}

class _VendaPageState extends State<VendaPage> {
  bool shadowColor = false;
  double? scrolledUnderElevation;
  String idEmpresa = "";
  final ProdutoStore store =
  ProdutoStore(repository: ProdutoRepository(client: HttpClient()));
  final List<ProdutoModel> _produtos = <ProdutoModel>[];
  List<ProdutoModel> _produtosDisplay = <ProdutoModel>[];

  // final carrinhoController = CarrinhoController();

  // get _carrinhoItems => carrinhoController.carrinho.value;
  // get _carrinhoLength => carrinhoController.carrinho.value.length;

  final ProdutoRepository produtoRepository =
  ProdutoRepository(client: HttpClient());
  int itemCount = 0;

  @override
  void initState() {
    super.initState();
    store.getProdutos();
    ProdutoRepository(client: HttpClient()).getProdutos().then((value) {
      setState(() {
        _produtos.addAll(value);
        _produtosDisplay = _produtos;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final carrinho = Provider.of<CarrinhoController>(context);
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
              "Produtos",
              style: TextStyle(
                  fontFamily: "Arista-Pro-Bold-trial",
                  color: Color.fromRGBO(248, 67, 21, 1.0),
                  fontSize: 40),
            ),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          AnimatedBuilder(
              animation: Listenable.merge([
                store.isLoading,
                store.erro,
                store.state,
              ]),
              builder: (BuildContext context, Widget? child) {
                if (store.isLoading.value) {
                  return const SizedBox(
                    height: 700,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [CircularProgressIndicator()]),
                  );
                }

                if (store.erro.value.isNotEmpty) {
                  return Center(
                    child: Text(
                      store.erro.value,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                if (store.state.value.isEmpty) {
                  return const Center(
                    child: Text(
                      'Nenhum item na lista',
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: MySearch(
                          onChanged: (searchText) {
                            searchText = searchText.toLowerCase();
                            setState(() {
                              _produtosDisplay = _produtos.where((u) {
                                var nome = u.nome.toLowerCase();
                                return nome.contains(searchText);
                              }).toList();
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 450,
                        child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: _produtosDisplay.length,
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
                              final item = _produtosDisplay[index];
                              return Column(children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _adicionarProdutoAoCarrinho(item);
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
                                                    "${itemCount}",
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
                                                // Cor de fundo do Container
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(
                                                      8),
                                                  // Raio do canto inferior esquerdo
                                                  bottomRight: Radius.circular(
                                                      8), // Raio do canto inferior direito
                                                ), // Raio de arredondamento
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
                            }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 10, top: 10),
                            child: FloatingActionButton(
                              onPressed: () =>
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Carrinho(),
                                    ),
                                  ),
                              backgroundColor:
                              const Color.fromRGBO(248, 67, 21, 1.0),
                              child: const Icon(Icons.shopping_cart_outlined),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 231,
                            child: ActionButton(
                              label: "ADICIONAR ITEM",
                              onPressed: () {},
                              icon: Icons.add,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              }),
        ]),
      ),
    );
  }

  void _adicionarProdutoAoCarrinho(ProdutoModel produto) {
    final carrinho = Provider.of<CarrinhoController>(context, listen: false);
    carrinho.adicionarProduto(produto);
  }
}