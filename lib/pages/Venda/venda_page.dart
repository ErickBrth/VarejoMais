import 'package:flutter/material.dart';

final List<int> _items = List<int>.generate(51, (int index) => index);

class VendaPage extends StatefulWidget {
  const VendaPage({super.key});

  @override
  State<VendaPage> createState() => _VendaPageState();
}

class _VendaPageState extends State<VendaPage> {
  bool shadowColor = false;
  double? scrolledUnderElevation;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          //titleSpacing: 10,
          // leading: Container(
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     border: Border.all(color: Colors.black),
          //   ),
          //   child: Center(
          //     child: BackButton(
          //       color: Colors.black,
          //     ),
          //   ),
          // ),

          title: Image.asset('assets/images/logoSmall.png', width: 230),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,

          scrolledUnderElevation: scrolledUnderElevation,
          shadowColor:
              shadowColor ? Theme.of(context).colorScheme.shadow : null,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          //const Padding(padding: EdgeInsets.only(top: 10)),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              style: TextStyle(fontSize: 25, color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Buscar',
                suffixIcon: Icon(Icons.search),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                // enabledBorder: UnderlineInputBorder(
                //   borderSide: BorderSide(color: Colors.black),
                // ),
                // focusedBorder: UnderlineInputBorder(
                //   borderSide: BorderSide(color: Colors.black),
                // ),
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _items.length,
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Column(children: [
                Container(
                    alignment: Alignment.center,
                    height: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: _items[index].isOdd ? oddItemColor : evenItemColor,
                    ),
                    child: Text('Item $index')),
                const SizedBox(
                  child: Text("Nome produto"),
                )
              ]);
            },
          ),
        ]),
      ),
    );
  }
}
