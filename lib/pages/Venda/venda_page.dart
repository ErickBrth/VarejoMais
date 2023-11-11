import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:varejoMais/data/controllers/carrinho_controller.dart';

import 'package:varejoMais/data/repositories/produto_repository.dart';
import 'package:varejoMais/data/http/http_client.dart';
import 'package:varejoMais/data/models/produto_model.dart';
import 'package:varejoMais/data/stores/produto_store.dart';
import 'package:varejoMais/shared/components/action_button.dart';
import 'package:varejoMais/shared/components/app_bar.dart';
import 'package:varejoMais/shared/components/produtos_grid_view.dart';
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

  final ProdutoRepository produtoRepository =
  ProdutoRepository(client: HttpClient());


  @override
  void initState() {
    super.initState();
    store.getProdutos();
     Provider.of<CarrinhoController>(context, listen: false).produtos.clear();
    ProdutoRepository(client: HttpClient()).getProdutos().then((value) {
      setState(() {
        _produtos.addAll(value);
        _produtosDisplay = _produtos;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Material(
        child: SafeArea(
          child: Scaffold(
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(70),
              child: App_Bar(
                title: "Produtos",
                leading: Icon(Icons.arrow_back),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                              // /mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: MySearch(
                                    onChanged: (searchText) {
                                      searchText =
                                          searchText.toLowerCase();
                                      setState(() {
                                        _produtosDisplay =
                                            _produtos.where((u) {
                                              var nome = u.nome.toLowerCase();
                                              return nome
                                                  .contains(searchText);
                                            }).toList();
                                      });
                                    },
                                  ),
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      fit: FlexFit.loose,
                                      child: SizedBox(
                                        height: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height * 0.35),
                                        child: ProdutosGridview(
                                          produtosDisplay: _produtosDisplay,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(

                                      child: SizedBox(
                                        height: 50,
                                        width: 231,
                                        child: ActionButton(
                                          label: "ADICIONAR ITEM",
                                          onPressed: () {
                                            if(Provider.of<CarrinhoController>(context, listen: false).produtos.isNotEmpty){
                                              Navigator.pushNamed(context, "/carrinho");
                                            }
                                          },
                                          icon: Icons.add,
                                        ),
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
          ),
        ),
      ),
    );
  }
}
