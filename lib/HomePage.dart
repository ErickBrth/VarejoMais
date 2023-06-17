import 'package:flutter/material.dart';
import 'package:varejo_mais/MenuButtons.dart';
import 'package:varejo_mais/components/home_page_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
              children: [
            Image.asset('assets/images/logo.png'),

                HomeButton(
                  onPressed: () {},
                  icon: Icons.wallet_outlined,
                  label: "Venda"),

            const Padding(padding: EdgeInsets.only(bottom: 15)),

                HomeButton(
                  onPressed: () {},
                  icon: Icons.local_print_shop_outlined,
                  label: "Reimpressao"),

            const Padding(padding: EdgeInsets.only(bottom: 15)),
                HomeButton(
                  onPressed: () {},
                  icon: Icons.cancel_outlined,
                  label: "Cancelamento"),

            const Padding(padding: EdgeInsets.only(bottom: 15)),

                 HomeButton(
                     onPressed: () {},
                     icon: Icons.trolley,
                     label: "Estoque"
                 ),
            const Padding(padding: EdgeInsets.only(bottom: 15)),

              HomeButton(
                  onPressed: () {}, icon: Icons.content_paste, label: "Coletor"),

            const Padding(padding: EdgeInsets.only(bottom: 15)),
                HomeButton(
                  onPressed: () {},
                  icon: Icons.delivery_dining_outlined,
                  label: "Delivery"),

            // const MyButton()
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'settings',
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
        foregroundColor: Color.fromRGBO(33, 133, 175, 1.0),
        onPressed: _handleButtonPress,
        child: Icon(Icons.settings),
      ),
    );
  }
}

void _handleButtonPress() {
  print("clicou");
}
