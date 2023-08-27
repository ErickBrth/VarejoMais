import 'package:flutter/material.dart';
import 'package:varejoMais/components/home_page_button.dart';
import 'package:varejoMais/pages/Venda/vendaPage.dart';

import 'package:varejoMais/platform_channel/platform_channel.dart';

class Venda extends StatelessWidget {
  Venda({super.key});

  final platformChannel = PlatformChannel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
                child: Material(
                            child: VendaPage(
                            ),
                ),
    );
  }
}




