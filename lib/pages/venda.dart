import 'package:flutter/material.dart';
import 'package:varejoMais/components/home_page_button.dart';
import 'package:varejoMais/platform_channel/platform_channel.dart';

class Venda extends StatefulWidget {
  const Venda({super.key});

  @override
  State<Venda> createState() => _VendaState();
}

class _VendaState extends State<Venda> {
  var exemplePlatformChannel = ExemplePlatformChannel();
  String _result = "";
  int result = 0;

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
                  _result =
                      await exemplePlatformChannel.callSimpleMethodChannel();
                  result =
                  await exemplePlatformChannel.getLongAmount();
                  setState(() {});
                },
                icon: Icons.wallet_outlined,
                label: "Cartão de Crédito"),
                    Text(
                      'Method Channel Result: $result',
                    ),
            Text(
              _result,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
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
