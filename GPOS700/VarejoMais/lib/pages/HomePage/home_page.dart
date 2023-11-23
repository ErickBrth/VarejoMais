import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varejoMais/data/controllers/carrinho_controller.dart';
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
                                                Navigator.of(context)
                                                    .pushNamed('/estoque');
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
                                                // Navigator.of(context)
                                                //     .pushReplacementNamed('/');
                                              },
                                              icon: Icons.settings,
                                              label: "Configurações"),
                                        ]),
                                  ]),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                //crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 80, vertical: 30),
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
                                  Image.asset(
                                    'assets/images/DataPayLogo.png',
                                    width: 121,
                                    height: 30,
                                  ),
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
