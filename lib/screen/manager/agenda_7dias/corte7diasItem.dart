import 'package:barbershop2/classes/cortecClass.dart';
import 'package:flutter/material.dart';

class Corte7DiasItem extends StatelessWidget {
  final List<CorteClass> corte;
  const Corte7DiasItem({super.key, required this.corte});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: corte.map((item) {
        return Text("${item.clientName}");
      }).toList(),
    );
  }
}
