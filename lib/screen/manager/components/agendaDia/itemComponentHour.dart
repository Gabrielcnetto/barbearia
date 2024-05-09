import 'package:barbershop2/classes/cortecClass.dart';
import 'package:barbershop2/classes/horarios.dart';
import 'package:flutter/material.dart';

class ItemComponentHour extends StatelessWidget {
  final CorteClass Corte;
  const ItemComponentHour({
    super.key,
    required this.Corte,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("${Corte.clientName}"),
    );
  }
}
