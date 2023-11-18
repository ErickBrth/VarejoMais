import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:varejoMais/data/controllers/carrinho_controller.dart';
import 'package:varejoMais/pages/HomePage/home_page.dart';
import 'package:varejoMais/shared/components/bottom_button.dart';

class VendaFinalizada extends StatelessWidget {
  const VendaFinalizada({super.key});

  @override
  Widget build(BuildContext context) {
    final carrinho = Provider.of<CarrinhoController>(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Material(
        child: SafeArea(
            child: Scaffold(
          body: Center(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 297,
                      height: 120,
                    ),
                    Container(
                      alignment: AlignmentDirectional.center,
                      child: const Text(
                        "VENDA FINALIZADA COM SUCESSO!!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 23,
                          fontFamily: "Arista-Pro-Bold-trial",
                          color: Color.fromRGBO(248, 67, 21, 1.0),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsetsDirectional.only(
                              bottom: 35, end: 25),
                          alignment: AlignmentDirectional.bottomCenter,
                          child: FloatingActionButton(
                            onPressed: () {},
                            backgroundColor: Color.fromRGBO(248, 67, 21, 1.0),
                            child: Icon(Icons.receipt_long_outlined),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        carrinho.produtos.clear();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage()),
                          (route) => false,
                        );
                      },
                      child: const BottomButton(text: "TELA INICIAL"),
                    ),
                  ],
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
