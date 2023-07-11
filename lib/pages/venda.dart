import 'package:flutter/material.dart';
import 'package:varejoMais/components/home_page_button.dart';
import 'package:varejoMais/platform_channel/platform_channel.dart';

class Venda extends StatefulWidget {
  const Venda({super.key});

  @override
  State<Venda> createState() => _VendaState();
}

class _VendaState extends State<Venda> {
  var platformChannel = PlatformChannel();
  String _result = "";
  int result = 0;
  String creditoParcelado = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Material(
          child: Center(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Image.asset('assets/images/logo.png'),
            HomeButton(
                onPressed: () async {
                  await platformChannel.creditoParceladoEmissor();
                  setState(() {});
                },
                icon: Icons.wallet_outlined,
                label: "Crédito Parcelado"),

            // Text(
            //   'Method Channel Result: $result',
            // ),
            // Text(
            //   creditoParcelado,
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            const Padding(padding: EdgeInsets.only(bottom: 15)),

            HomeButton(
                onPressed: () async {
                  await platformChannel.creditoVista();
                  setState(() {});
                },
                icon: Icons.wallet_outlined,
                label: "Crédito à Vista"),

            const Padding(padding: EdgeInsets.only(bottom: 15)),

            HomeButton(
                onPressed: () async {
                  await platformChannel.debito();
                  setState(() {});
                },
                icon: Icons.wallet_outlined,
                label: "Débito"),

            const Padding(padding: EdgeInsets.only(bottom: 15)),

            HomeButton(
                onPressed: () async {
                  await platformChannel.voucher();
                  setState(() {});
                },
                icon: Icons.wallet_outlined,
                label: "Voucher"),

            const Padding(padding: EdgeInsets.only(bottom: 15)),

            HomeButton(
                onPressed: () async {
                  await platformChannel.estorno();
                  setState(() {});
                },
                icon: Icons.wallet_outlined,
                label: "Estorno"),

            const Padding(padding: EdgeInsets.only(bottom: 15)),

            HomeButton(
                onPressed: () async {
                  await platformChannel.reprint();
                  setState(() {});
                },
                icon: Icons.local_print_shop_outlined,
                label: "Relatório de Vendas"),
            // Text(
            //     'Method Channel Result: $result',
            // ),
            // Text(
            //   _result,
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            const Padding(padding: EdgeInsets.only(bottom: 15)),
          ])),
        ),
      ),
    );
  }
}




// class Venda extends StatelessWidget {
//   const Venda({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Material(
//           child: Center(
//               child:
//                   Column(mainAxisAlignment: MainAxisAlignment.start, children: [
//             Image.asset('assets/images/logo.png'),
//             Text('Venda'),
//           ])),
//         ),
//       ),
//     );
//   }
// }
