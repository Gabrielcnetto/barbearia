import 'dart:math';

class Horarios {
  final String horario;
  final String id;
  Horarios({
    required this.horario,
    required this.id,
  });
}

List<Horarios> hourLists = [
  Horarios(
    horario: "09:00",
    id: Random().nextDouble().toString(),
  ),
  Horarios(
    horario: "10:00",
    id: Random().nextDouble().toString(),
  ),
   Horarios(
    horario: "11:00",
    id: Random().nextDouble().toString(),
  ),
    Horarios(
    horario: "13:00",
    id: Random().nextDouble().toString(),
  ),
    Horarios(
    horario: "14:00",
    id: Random().nextDouble().toString(),
  ),
    Horarios(
    horario: "15:00",
    id: Random().nextDouble().toString(),
  ),
    Horarios(
    horario: "16:00",
    id: Random().nextDouble().toString(),
  ),
    Horarios(
    horario: "17:00",
    id: Random().nextDouble().toString(),
  ),
   Horarios(
    horario: "18:00",
    id: Random().nextDouble().toString(),
  ),
   Horarios(
    horario: "19:00",
    id: Random().nextDouble().toString(),
  ),
    Horarios(
    horario: "20:00",
    id: Random().nextDouble().toString(),
  ),
   Horarios(
    horario: "21:00",
    id: Random().nextDouble().toString(),
  ),
];
