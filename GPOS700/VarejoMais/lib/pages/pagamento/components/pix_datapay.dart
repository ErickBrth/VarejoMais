


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:varejoMais/data/controllers/pagamento_controller.dart';
import 'package:varejoMais/data/controllers/pixController.dart';
import 'package:varejoMais/shared/components/loading.dart';


class QrCodePix extends StatefulWidget {
  const QrCodePix({super.key, required this.valorAPagar, required this.pagamentoController, required this.pixController, required this.valorTotalPago});
  final double valorAPagar;

  final double valorTotalPago;
  final PagamentoController pagamentoController;
  final PixController pixController;


  @override
  State<QrCodePix> createState() => _QrCodePixState();
}

class _QrCodePixState extends State<QrCodePix> {

  final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');


  @override
  void initState() {
    super.initState();
    widget.pixController.verificaStatusPix();
    //to listen when pixStatus is approved and go to final page
      widget.pixController.pixStatus.addListener(() {
         String pixStatus = widget.pixController.getPixStatus;
        if (pixStatus == 'approved') {
          widget.pagamentoController.calculaValorRestante(widget.valorAPagar, widget.valorTotalPago);
          double valorRestante = widget.pagamentoController.getValorRestante;
          if(valorRestante == 0){
            Navigator.pushNamed(context, "/vendaFinalizada");
          }else{
            Navigator.of(context).pop();
          }
        }else if(pixStatus == "cancelled"){
          widget.pixController.pixStatus.removeListener(() { }); // remover listeners ao mudar de context
          if(mounted){
            Navigator.of(context).pop();
          }
        }
      });
  }

  @override
  Widget build(BuildContext context) {
      return SafeArea(
          child: Scaffold(
            body: FutureBuilder<Image>(
              future: _getQrCodePix(),
              builder: (BuildContext context, AsyncSnapshot<Image> snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: MyLoading(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Erro: ${snapshot.error}');
                } else {
                  return AlertDialog(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    title: const Text(
                      'Pix Datapay',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Arista-Pro-Bold-trial",
                        fontSize: 23,
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Valor: ${currencyFormat.format(widget.valorAPagar)}",
                          style: const TextStyle(
                            color: Color.fromRGBO(248, 67, 21, 1.0),
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Container(
                          child: snapshot.data,
                        ),
                        ElevatedButton(
                          onPressed: (){
                            widget.pixController.cancelarPix();
                            widget.pixController.stopCheckingStatus();
                            Navigator.of(context).pop();
                          },
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              Color.fromRGBO(248, 67, 21, 1.0),
                            ),
                          ),
                          child: const Text(
                              "Cancelar"
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }
            ),
          )
      );
    }

    Future<Image> _getQrCodePix() async {
    Image image = await widget.pixController.getQrCodePix(widget.valorAPagar.toStringAsFixed(2));
     return image;
    }
  }


