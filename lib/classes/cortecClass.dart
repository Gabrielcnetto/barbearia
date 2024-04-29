import 'package:barbershop2/classes/horarios.dart';

class CorteClass {
  final String id;
  final bool isActive;
  final String clientName;
  final String numeroContato;
  final bool sobrancelha;
  final int DiaDoCorte;
  final String NomeMes;
  final DateTime diaCorte;
  final int ramdomCode;
  final String horarioCorte;
  final String profissionalSelect;
  final DateTime dateCreateAgendamento;
  CorteClass({
    required this.isActive,
    required this.DiaDoCorte,
    required this.clientName,
    required this.NomeMes,
    required this.id,
    required this.numeroContato,
    required this.profissionalSelect,
    required this.diaCorte,
    required this.horarioCorte,
    required this.sobrancelha,
    required this.ramdomCode,
    required this.dateCreateAgendamento,
  });
}