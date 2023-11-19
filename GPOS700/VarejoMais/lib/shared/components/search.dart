import 'package:flutter/material.dart';

class MySearch extends StatefulWidget {
  const MySearch({super.key, this.onChanged});
  final void Function(String)? onChanged;

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      style: const TextStyle(
          fontFamily: "Arista-Pro-Bold-trial",
          fontSize: 25,
          color: Colors.black),
      decoration: const InputDecoration(
        hintText: 'Buscar',
        suffixIcon: Icon(Icons.search),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
