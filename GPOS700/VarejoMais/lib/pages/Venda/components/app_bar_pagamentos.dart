import 'package:flutter/material.dart';
import 'package:varejoMais/pages/Venda/components/dialog_arrow_back.dart';

class AppBarPagamento extends StatelessWidget {

  final Widget leading;
  final String title;
  final bool voltar;

  const AppBarPagamento({super.key, required this.leading, required this.title, required this.voltar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(

          backgroundColor: Colors.white,
          leading: IconButton(
            padding: const EdgeInsetsDirectional.only(top: 20, start: 20),
            icon: leading,
            onPressed: () async{
              if(voltar){
                await AlertDialogVenda().showVendaDialog(context);
              }
            },
            iconSize: 35.0,
            color: const Color.fromRGBO(248, 67, 21, 1.0),

          ),
          title: Container(
            //color: Colors.blue,
            padding: const EdgeInsetsDirectional.only(top: 20, end: 25),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                    fontFamily: "Arista-Pro-Bold-trial",
                    color: Color.fromRGBO(248, 67, 21, 1.0),
                    fontSize: 40),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
