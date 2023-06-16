import 'package:flutter/material.dart';
import 'package:varejo_mais/MenuButtons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Material(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [

                ElevatedButton(
                  onPressed: _handleButtonPress,
                  // style: ButtonStyle(
                  //   backgroundColor: MaterialStateProperty.resolveWith<Color?>
                  //     ((states) {
                  //       return Colors.red;
                  //   })
                  // ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.wallet_outlined), // Ícone a ser exibido
                      SizedBox(width: 8), // Espaçamento entre o ícone e o rótulo (opcional)
                      Text('Venda'),
                    ],
                  ),
                ),

                ElevatedButton(
                  onPressed: _handleButtonPress,

                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.local_print_shop_outlined), // Ícone a ser exibido
                      SizedBox(width: 8), // Espaçamento entre o ícone e o rótulo (opcional)
                      Text('Reimpressão'),
                    ],
                  ),
                ),

                ElevatedButton(
                  onPressed: _handleButtonPress,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.cancel_outlined), // Ícone a ser exibido
                      SizedBox(width: 8), // Espaçamento entre o ícone e o rótulo (opcional)
                      Text("Cancelamento"),
                    ],
                  ),
                ),

                ElevatedButton(
                  onPressed: _handleButtonPress,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.trolley), // Ícone a ser exibido
                      SizedBox(width: 8), // Espaçamento entre o ícone e o rótulo (opcional)
                      Text("Estoque"),
                    ],
                  ),
                ),

                ElevatedButton(
                  onPressed: _handleButtonPress,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.content_paste), // Ícone a ser exibido
                      SizedBox(width: 8), // Espaçamento entre o ícone e o rótulo (opcional)
                      Text("Coletor"),
                    ],
                  ),
                ),

                ElevatedButton(
                  onPressed: _handleButtonPress,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.delivery_dining_outlined), // Ícone a ser exibido
                      SizedBox(width: 8), // Espaçamento entre o ícone e o rótulo (opcional)
                      Text("Delivery"),
                    ],
                  ),
                ),
              ]
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        tooltip: 'settings',
        shape: RoundedRectangleBorder(),

        backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
        foregroundColor: Color.fromRGBO(33, 133, 175, 1.0),
        child: Icon(Icons.settings),
        onPressed: _handleButtonPress,
      ),
    );
  }
}
void _handleButtonPress() {
   print("clicou");
}
const height = 48;