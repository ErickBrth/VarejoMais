import 'package:flutter/material.dart';
import 'package:varejoMais/pages/Venda/venda_page.dart';

import 'package:varejoMais/shared/platform_channel/platform_channel.dart';

class Venda extends StatelessWidget {
  Venda({super.key});

  final platformChannel = PlatformChannel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: VendaPage(),
      ),
    );
  }
}
