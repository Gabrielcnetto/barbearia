import 'package:barbershop2/classes/horarios.dart';

class CorteClass {
  final String id;
  final String clientName;
  final String numeroContato;
  final bool sobrancelha;
  final DateTime diaCorte;
  final String horarioCorte;
  final String profissionalSelect;
  CorteClass({
    required this.clientName,
    required this.id,
    required this.numeroContato,
    required this.profissionalSelect,
    required this.diaCorte,
    required this.horarioCorte,
    required this.sobrancelha,
  });
}