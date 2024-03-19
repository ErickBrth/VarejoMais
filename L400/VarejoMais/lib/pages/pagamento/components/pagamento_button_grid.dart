import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:varejoMais/data/controllers/carrinho_controller.dart';
import 'package:varejoMais/data/controllers/pagamento_controller.dart';
import 'package:varejoMais/data/controllers/pixController.dart';
import 'package:varejoMais/data/models/produto_model.dart';
import 'package:varejoMais/pages/pagamento/pagamento.dart';
import 'package:varejoMais/pages/pagamento/pix/alert_dialog_pix.dart';
import 'package:varejoMais/shared/components/pagamento_button.dart';
import 'package:varejoMais/shared/components/show_dialog_price/dialog_price.dart';
import 'package:varejoMais/shared/platform_channel/platform_channel.dart';

class ButtonGrid extends StatefulWidget {
  const ButtonGrid(
      {super.key, required this.totalVenda, required this.pagamentoController});

  final double totalVenda;
  final PagamentoController pagamentoController;
  @override
  State<ButtonGrid> createState() => _ButtonGridState();
}

class _ButtonGridState extends State<ButtonGrid> {
  int parcelas = 0;
  TextEditingController parcelasController = TextEditingController();
  double valorAPagar = 0.0;
  final _formKey = GlobalKey<FormState>();
  final platformChannel = PlatformChannel();
  double valorTotalPago = 0.0;
  PixController pixController = PixController();

  late NavigatorState _navigator;

  @override
  void didChangeDependencies() {
  super.didChangeDependencies();
  _navigator = Navigator.of(context);
  }

  void vendaFinalizada() {
  _navigator.pushReplacementNamed('/vendaFinalizada');
  }

  @override
  Widget build(BuildContext context) {
    final produtosCarrinho = Provider.of<CarrinhoController>(context).produtos;
    return PopScope(
      //impede de voltar a pagina com o botão do android
      canPop: false,
      child: ValueListenableBuilder(
          valueListenable: widget.pagamentoController.valorRestate,
          builder: (context, valor, child) {
            return GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              //número de colunas desejado
              mainAxisSpacing: 10.0,
              // Espaçamento vertical entre os botões
              crossAxisSpacing: 10.0,
              // Espaçamento horizontal entre os botões
              padding: const EdgeInsets.all(20.0),
              // Espaçamento externo do grid
              children: [
                PagamentoButton(
                  icon: Icons.credit_card_outlined,
                  label: "Cartão Crédito",
                  onPressed: () {
                    setState(() {
                      mostrarAlertDialog(valor, produtosCarrinho);
                    });
                  },
                ),
                PagamentoButton(
                  icon: Icons.wallet_outlined,
                  label: "Cartão Débito",
                  onPressed: () async {
                    valorAPagar =
                    (await DialogPrice().showInputDialog(context, valor))!;
                    valorTotalPago = valor;
                    String result = "";
                    if (valorAPagar > 0.0) {
                      result = await platformChannel.debito(valorAPagar);
                      if (result == "ok!") {
                        String retorno = await widget.pagamentoController.registraPagamento("DEBITO", produtosCarrinho, valorAPagar);
                        if(retorno == "ok!"){
                          double valorRestante = double.parse(widget
                              .pagamentoController.valorRestate.value
                              .toStringAsFixed(2));
                          widget.pagamentoController
                              .calculaValorRestante(valorAPagar, valorRestante);
                          valorRestante = double.parse(widget
                              .pagamentoController.valorRestate.value
                              .toStringAsFixed(2));
                          if (valorRestante == 0.0) {
                            vendaFinalizada();
                          }
                        }
                      }
                    }
                  },
                ),
                PagamentoButton(
                  icon: Icons.monetization_on_outlined,
                  label: "Dinheiro",
                  onPressed: () async {
                    valorAPagar =
                        (await DialogPrice().showInputDialog(context, valor))!;
                    valorTotalPago = valor;
                    String result = "";
                    if (valorAPagar > 0.0) {
                    result = await widget.pagamentoController.registraPagamento("DINHEIRO", produtosCarrinho, valorAPagar);
                    if (result == "ok!") {
                    double valorRestante = double.parse(widget
                        .pagamentoController.valorRestate.value
                        .toStringAsFixed(2));
                    widget.pagamentoController
                        .calculaValorRestante(valorAPagar, valorRestante);
                    valorRestante = double.parse(widget
                        .pagamentoController.valorRestate.value
                        .toStringAsFixed(2));
                    if (valorRestante == 0.0) {
                    Navigator.pushReplacementNamed(
                    context, '/vendaFinalizada');
                    }
                    }
                    }
                  },
                ),
                PagamentoButton(
                  icon: Icons.pix_outlined,
                  label: "PIX",
                  onPressed: () async {
                    DialogPix().showInputDialogPix(
                        context,
                        valor,
                        valorAPagar,
                        valorTotalPago,
                        widget.pagamentoController,
                        widget.totalVenda, produtosCarrinho);
                  },
                ),
              ],
            );
          }),
    );
  }

  void mostrarAlertDialog(double valor, Map<ProdutoModel, int> produtosCarrinho) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          title: const Text(
            'Escolha a opção de crédito',
            style: TextStyle(
              fontFamily: "Arista-Pro-Bold-trial",
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () async {
                        valorAPagar =
                        (await DialogPrice().showInputDialog(context, valor))!;
                        valorTotalPago = valor;
                        String result = "";
                        if (valorAPagar > 0.0) {
                          result = await platformChannel.creditoVista(valorAPagar);
                          Navigator.of(context).pop();
                          if (result == "ok!") {
                            await widget.pagamentoController.registraPagamento("CREDITO AVISTA", produtosCarrinho, valorAPagar);
                            double valorRestante = double.parse(widget
                                .pagamentoController.valorRestate.value
                                .toStringAsFixed(2));
                            widget.pagamentoController
                                .calculaValorRestante(valorAPagar, valorRestante);
                            valorRestante = double.parse(widget
                                .pagamentoController.valorRestate.value
                                .toStringAsFixed(2));
                            if (valorRestante == 0.0) {
                                vendaFinalizada();
                            }
                          }
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: const MaterialStatePropertyAll(
                            Color.fromRGBO(248, 67, 21, 1.0)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          )
                        ),
                      ), 
                      child: const Column(
                        children: [
                          Icon(
                            Icons.payments_outlined,
                            size: 45,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'À Vista',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontFamily: "Arista-Pro-Bold-trial",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          //Navigator.of(context).pop();
                          digitarNumeroParcelas(
                              widget.totalVenda, parcelas, valor, produtosCarrinho);
                        });
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                        backgroundColor: const MaterialStatePropertyAll(
                            Color.fromRGBO(248, 67, 21, 1.0)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            )
                        ),
                      ),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.credit_card_rounded,
                            color: Colors.white,
                            size: 45,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Parcelado',
                            softWrap: false,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              fontFamily: "Arista-Pro-Bold-trial",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void digitarNumeroParcelas(double totalVenda, int parcelas, double valor, Map<ProdutoModel, int> produtosCarrinho) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Número de Parcelas'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: parcelasController,
                  keyboardType: TextInputType.number,
                  validator: (numParcelas) {
                    if (numParcelas == null ||
                        numParcelas.isEmpty ||
                        parcelas <= 1) {
                      return 'Parcelas inválidas';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    int newParcelas = int.tryParse(value) ?? 0;
                    if (newParcelas <= 0) {
                    } else {
                      parcelas = newParcelas;
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromRGBO(248, 67, 21, 1.0)),
                      ),
                      onPressed: () {
                        parcelasController.clear();
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Cancelar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          fontFamily: "Arista-Pro-Bold-trial",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (_formKey.currentState!.validate()) {
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          if (parcelas <= 0) {
                            parcelasController.clear();
                          } else {
                            parcelasController.clear();
                            valorAPagar =
                            (await DialogPrice().showInputDialog(context, valor))!;
                            valorTotalPago = valor;
                            String result = "";
                            if (valorAPagar > 0.0) {
                              result = await platformChannel.creditoParcelado(valorAPagar, parcelas);
                              // Navigator.of(context).pop();
                              // Navigator.of(context).pop();
                              if (result == "ok!") {
                                await widget.pagamentoController.registraPagamento("PIX REDE", produtosCarrinho, valorAPagar);
                                double valorRestante = double.parse(widget
                                    .pagamentoController.valorRestate.value
                                    .toStringAsFixed(2));
                                widget.pagamentoController
                                    .calculaValorRestante(valorAPagar, valorRestante);
                                valorRestante = double.parse(widget
                                    .pagamentoController.valorRestate.value
                                    .toStringAsFixed(2));
                                if(mounted){
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                }
                                if (valorRestante == 0.0) {
                                  if(mounted){
                                    Navigator.pushNamed(
                                        context, '/vendaFinalizada');
                                  }
                                }
                              }
                            }
                          }
                        }
                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromRGBO(248, 67, 21, 1.0)),
                      ),
                      child: const Text(
                        'OK',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          fontFamily: "Arista-Pro-Bold-trial",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
