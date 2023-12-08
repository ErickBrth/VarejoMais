import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varejoMais/data/controllers/carrinho_controller.dart';
import 'package:varejoMais/pages/HomePage/components/suporte.dart';
import 'package:varejoMais/shared/components/action_button.dart';
import 'package:varejoMais/shared/components/home_page_button.dart';
import 'package:varejoMais/shared/platform_channel/platform_channel.dart';

import 'components/reimpressao_dialog.dart';

class HomePage extends StatelessWidget{
  HomePage({super.key});

  final platformChannel = PlatformChannel();

  @override
  Widget build(BuildContext context) {
    final carrinho = Provider.of<CarrinhoController>(context);
    return Material(
      child: SafeArea(
        child: Scaffold(
          body: Material(
            child: Column(
                children: [
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                            width: 297,
                            height: 120,
                          )
                        ]),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      alignment: AlignmentDirectional.centerEnd,
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  HomeButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed('/venda');
                                      },
                                      icon: Icons.wallet_outlined,
                                      label: "Venda"),
                                  const Padding(padding: EdgeInsets.only(left: 10)),
                                  HomeButton(
                                      onPressed: () async {
                                        DialogReimpressao().showReimpressaoDialog(context);
                                      },
                                      icon: Icons.local_print_shop_outlined,
                                      label: "Reimpressão"),
                                ],
                              ),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Padding(padding: EdgeInsets.only(bottom: 10)),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          HomeButton(
                                              onPressed: () async {
                                                Navigator.of(context).pushNamed('/auth');
                                              },
                                              icon: Icons.cancel_outlined,
                                              label: "Cancelamento"),
                                          const Padding(
                                              padding: EdgeInsets.only(left: 10)),
                                          HomeButton(
                                              onPressed: () {
                                                // Navigator.of(context)
                                                //     .pushNamed('/estoque');
                                              },
                                              icon: Icons.smartphone,
                                              label: "Resgate PDV"),
                                        ]),
                                  ]),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Padding(padding: EdgeInsets.only(bottom: 10)),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          HomeButton(
                                              onPressed: () {
                                              },
                                              icon: Icons.settings,
                                              label: "Configurações"),

                                        ]),
                                  ]),
                              const SizedBox(height: 12,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 80, vertical: 2),
                                    child: ActionButton(
                                      label: "Trocar Conta",
                                      onPressed: () async {
                                        bool saiu = await sair();
                                        if (saiu) {
                                          carrinho.produtos.clear();
                                          Navigator.of(context).pushReplacementNamed("/");
                                        }
                                      },
                                      icon: Icons.sync,
                                    ),
                                  ),
                                  Row(
                                    //mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        child: Container(
                                          //color: Colors.greenAccent,
                                          alignment: AlignmentDirectional.centerEnd,
                                          child: Image.asset(
                                            'assets/images/DataPayLogo.png',
                                            width: 121,
                                            height: 30,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Container(
                                          //color: Colors.red,
                                          alignment: AlignmentDirectional.centerEnd,
                                          padding:  const EdgeInsetsDirectional.only(end: 10),
                                          child: Column(
                                            children: [
                                              FloatingActionButton(
                                                  backgroundColor: const Color.fromRGBO(248, 67, 21, 1.0),
                                                  child: const Icon(Icons.support_agent_outlined,size: 40),
                                                  onPressed: () {
                                                    Suporte().showSuporteDialog(context);
                                                  }),
                                              const SizedBox(height: 5),
                                              const Text(
                                                "SUPORTE",
                                                style: TextStyle(
                                                  color: Color.fromRGBO(248, 67, 21, 1.0),
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w800,
                                                  fontFamily: "Arista-Pro-Bold-trial",
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                            ],
                                          ),
                                        ),
                                      ),

                                    ],
                                  )
                                  //const Padding(padding: EdgeInsets.only(bottom: 40)),
                                ],
                              )
                            ]),
                      ),
                    ),
                  ),

                ]),
          ),
        ),
      ),
    );
  }
}

Future<bool> sair() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  return true;
}
