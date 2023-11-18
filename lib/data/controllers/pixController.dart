import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:varejoMais/data/http/exceptions.dart';
import 'package:varejoMais/data/models/pix_model.dart';

abstract class IPixController {
  Future<void> getQrCodePix(String valor);
}

class PixController implements IPixController {
  ValueNotifier<String> pixStatus = ValueNotifier("");

  String pixId = "";
  Timer? _timer;
  Timer? _maxTimer;
  String clientId = "3W4d6Z3XNniP2Sp8UoI4OoKwh910bdXzcrkHv4Tc5dFGCnQ2TprAsRQ2kK4wExQmcptlEMG73tghIS67dneIHJcQ2262uTAn_VeQpplpnAe1bvrU8UL3h0jUt3Mp7h2SlhyglVq3jj6jos66FlsJYI7cba12cBq_42YAS14rHTY";

  get getPixStatus => pixStatus.value;


  Future<dynamic> _getPix(String valor) async {
    String apiUrl =
        "https://pix.datapaytecnologia.com.br/api/client/orders/qrcode";

    double? valorStr = double.tryParse(valor);
    final Map<String, dynamic?> requestBody = {
      "client_id": clientId,
      "item_title": "",
      "total": valorStr,
      "wallet": "DataPayWalletPix"
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      return body;
    } else if (response.statusCode == 404) {
      stopCheckingStatus();
      throw NotFoundException("A url informada não é válida");
    } else {
      stopCheckingStatus();
      throw NotFoundException("Não foi possível carregar o Qr code Pix");
    }
  }

  Future<dynamic> _verifyPix(String id) async {
    String apiUrl =
        "https://pix.datapaytecnologia.com.br/api/client/orders/order/$id";

    final Map<String, dynamic?> requestBody = {
      "client_id": clientId,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body["order"]["status"];
    } else if (response.statusCode == 404) {
      stopCheckingStatus();
      throw NotFoundException("A url informada não é válida");
    } else {
      stopCheckingStatus();
      throw NotFoundException("Não foi possível carregar o Qr code Pix");
    }
  }

  Future<dynamic> getLastOrderPix() async {
    String apiUrl =
        "https://pix.datapaytecnologia.com.br/api/client/orders/orders";

    final Map<String, dynamic?> requestBody = {
      "client_id": clientId,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      List<dynamic> orders = body['orders'];
      Map<String, dynamic> ultimaOrdem = orders.last;
      final lastOrder = PixModel.fromMap(ultimaOrdem);
      return lastOrder;
    } else if (response.statusCode == 404) {
      stopCheckingStatus();
      throw NotFoundException("A url informada não é válida");
    } else {
      stopCheckingStatus();
      throw NotFoundException("Não foi possível carregar o Qr code Pix");
    }
  }

  Future<dynamic> _refundPix(String id) async {
    String apiUrl =
        "https://pix.datapaytecnologia.com.br/api/client/orders/order/$id/refund";

    final Map<String, dynamic?> requestBody = {
      "client_id": clientId,
    };

    final response = await http.delete(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body["order"];
    } else if (response.statusCode == 404) {
      stopCheckingStatus();
      throw NotFoundException("A url informada não é válida");
    } else {
      stopCheckingStatus();
      throw NotFoundException("Não foi possível carregar o Qr code Pix");
    }
  }

  Future<dynamic> refundPix() async{
    PixModel lastOrder = await getLastOrderPix();
    String id = lastOrder.order_id;
    final refundPix = await _refundPix(id);
    return refundPix;
  }


  Future<String> _cancelPix(String id) async {
    String apiUrl =
        "https://pix.datapaytecnologia.com.br/api/client/orders/order/$id";

    final Map<String, dynamic?> requestBody = {
      "client_id": clientId,
    };

    final response = await http.delete(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body["order"]["status"].toString();
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não é válida");
    } else {
      throw NotFoundException("Não foi possível cancelar o Pix");
    }
  }

  Future<void> cancelarPix() async{
    final status = await _cancelPix(pixId);
    if(status == "cancelled"){
      pixStatus.value = status;
    }
  }

  @override
  Future<Image> getQrCodePix(String valor) async {
    final body = await _getPix(valor);
    pixId = body["order"]["order_id"].toString();
    final qrCode = body["order"]["qr_code"].toString();
    final split = qrCode.split(',');
    List<int> imageBytes = base64Decode(split[1]);
    Image image = Image.memory(Uint8List.fromList(imageBytes));
    return image;
  }

  Future<void> verificaStatusPix() async {
    _maxTimer = Timer.periodic(const Duration(seconds: 60), (Timer t) async{
      cancelarPix();
      stopCheckingStatus();
    });
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer t) async {
        final status = await _verifyPix(pixId);
        pixStatus.value = status;
        if(getPixStatus == "cancelled" || getPixStatus == "approved"){
          //se o pagamento for cancelado ou aprovado, cancela o timer
          stopCheckingStatus();
        }
    });

  }

  void stopCheckingStatus() {
    _timer?.cancel();
    _maxTimer?.cancel();
  }
}
