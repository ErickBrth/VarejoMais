import 'package:flutter/material.dart';
import 'package:varejoMais/components/home_page_button.dart';
import 'package:varejoMais/platform_channel/platform_channel.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final platformChannel = PlatformChannel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Material(
          child: Center(
            child: Stack(
              children: [
                Column(
                    children: [
                  SizedBox(
                    width: 420,
                      height: 170,
                      child: Image.asset('assets/images/logo.png')
                  ),
                ]),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                await platformChannel.reprint();
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
                                      await platformChannel.estorno();
                                    },
                                    icon: Icons.cancel_outlined,
                                    label: "Cancelamento"
                                ),
                                const Padding(padding: EdgeInsets.only(left: 10)),
                                HomeButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed('/estoque');
                                    },
                                    icon: Icons.smartphone,
                                    label: "Resgate PDV"
                                ),
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
                                      Navigator.of(context).pushNamed('/coletor');
                                    },
                                    icon: Icons.settings,
                                    label: "Configurações"
                                ),
                              ]),
                        ]),
                  ]),
                Column( mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                        width: 121,
                        height: 30,
                        child: Image.asset('assets/images/DataPayLogo.png')
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 50)),
                  ],
                )
            ]),
          ),
        ),
      ),
    );
  }
}
