import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    // carregar o certificado
    rootBundle.load('assets/ca/lets-encrypt-r3.pem').then((bytes) {
      context?.setTrustedCertificatesBytes(bytes.buffer.asUint8List());
    });

    return super.createHttpClient(context);
  }
}