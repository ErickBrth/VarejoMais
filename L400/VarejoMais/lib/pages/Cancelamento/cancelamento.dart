import 'package:flutter/material.dart';
import 'package:varejoMais/data/controllers/pixController.dart';
import 'package:varejoMais/data/models/pix_model.dart';
import 'package:varejoMais/shared/components/app_bar.dart';
import 'package:varejoMais/shared/components/loading.dart';

class Cancelamento extends StatefulWidget {
  const Cancelamento({super.key});

  @override
  State<Cancelamento> createState() => _CancelamentoState();
}

class _CancelamentoState extends State<Cancelamento> {
  final PixController pixController = PixController();
  Map<String, dynamic>  refund = {};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: App_Bar(
            leading: Icon(Icons.arrow_back),
            title: "Cancelar",
          ),
        ),
        body: FutureBuilder<PixModel>(
            future: _getLastOrder(),
            builder: (BuildContext context, AsyncSnapshot<PixModel> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: MyLoading(),
                );
              } else if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              } else {
                return Material(
                  child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                        //Image.asset('assets/images/logo.png', width: 297, height: 120),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Última Transação Pix',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 30,
                            fontFamily: "Arista-Pro-Bold-trial",
                            //color: Color.fromRGBO(248, 67, 21, 1.0),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              ListTile(
                                shape: const RoundedRectangleBorder(side:BorderSide(width: 2,color: Color.fromRGBO(248, 67, 21, 1.0)) ,borderRadius: BorderRadius.all(Radius.circular(8))),
                                leading: const Icon(Icons.arrow_circle_right, color: Color.fromRGBO(248, 67, 21, 1.0) ),
                                title: Text('id : ${snapshot.data?.order_id}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20,
                                    )),
                              ),const SizedBox(height: 5,),
                              ListTile(
                                shape: const RoundedRectangleBorder(side:BorderSide(width: 2,color: Color.fromRGBO(248, 67, 21, 1.0)) ,borderRadius: BorderRadius.all(Radius.circular(8))),
                                leading: const Icon(Icons.arrow_circle_right, color: Color.fromRGBO(248, 67, 21, 1.0) ),
                                title: Text(
                                    'Valor Total : ${snapshot.data?.total_order}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20,
                                    )),
                              ),const SizedBox(height: 5,),
                              ListTile(
                                shape: const RoundedRectangleBorder(side:BorderSide(width: 2,color: Color.fromRGBO(248, 67, 21, 1.0)) ,borderRadius: BorderRadius.all(Radius.circular(8))),
                                leading: const Icon(Icons.arrow_circle_right, color: Color.fromRGBO(248, 67, 21, 1.0) ),
                                title: Text('Data Pagamento: ${snapshot.data?.payment_date}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20,
                                    )),
                              ),
                              const SizedBox(height: 5,),
                              ListTile(
                                shape: const RoundedRectangleBorder(side: BorderSide(width: 2,color: Color.fromRGBO(248, 67, 21, 1.0)) , borderRadius: BorderRadius.all(Radius.circular(8))),
                                leading: const Icon(Icons.arrow_circle_right, color: Color.fromRGBO(248, 67, 21, 1.0)),
                                title: Text('Status Pagamento: ${snapshot.data?.status}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20,
                                    )),
                              ),
                            ],
                          ),
                        ),
                            Flexible(
                              fit: FlexFit.loose,
                              child: Container(
                                alignment: AlignmentDirectional.center,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    refund = await pixController.refundPix();
                                    final message = refund["message"];
                                    final status = refund["status"];
                                    await Future.delayed(const Duration(seconds: 1));
                                    showCustomSnackbar('$message');
                                    if(status == "refund_pending"){
                                      showCustomSnackbar('$message');
                                      await Future.delayed(const Duration(seconds: 1));
                                      Navigator.of(context)
                                          .pushNamed('/home');
                                    }
                                  },
                                  style: const ButtonStyle(
                                    padding: MaterialStatePropertyAll(EdgeInsetsDirectional.all(10)),
                                    backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(248, 67, 21, 1.0)),
                                  ),
                                  child: const Text(
                                    "Estornar Pagamento",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      ])),
                );
              }
            }),
      ),
    );
  }

  Future<PixModel> _getLastOrder() async {
    PixModel lastOrder = await pixController.getLastOrderPix();
    return lastOrder;
  }

  void showCustomSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(
          message,
         textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18
        ),
      ),
      backgroundColor: Colors.blueAccent,
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
