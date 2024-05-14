import 'package:barbershop2/classes/GeralUser.dart';
import 'package:barbershop2/classes/cortecClass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class ManagerScreenFunctions with ChangeNotifier {
  final database = FirebaseFirestore.instance;

  List<GeralUser> _CLIENTESLISTA = [];
  List<GeralUser> get clientesLista => [..._CLIENTESLISTA];
  Future<void> loadClientes() async {
    try {
      print("acessamos o database");
      QuerySnapshot querySnapshot = await database.collection("usuarios").get();

      _CLIENTESLISTA = querySnapshot.docs.map((doc) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        return GeralUser(
          isManager: data?["isManager"],
          listacortes: data?["totalCortes"],
          name: data?["userName"],
          urlImage: data?["urlImagem"],
        );
      }).toList();
      print("o tamanho da lista é ${_CLIENTESLISTA.length}");
    } catch (e) {
      print("houve um erro: ${e}");
    }
    notifyListeners();
  }

  List<CorteClass> _listaCortes = [];
  List<CorteClass> get listaCortes => [..._listaCortes];
  Future<void> loadMonthCortes() async {
    DateTime diaAtual = DateTime.now();
    await initializeDateFormatting('pt_BR');

    String monthName = DateFormat('MMMM', 'pt_BR').format(diaAtual);
    print(monthName);

    QuerySnapshot querySnapshot = await database
        .collection("totalCortes")
        .doc("${monthName}")
        .collection("all")
        .get();
    List<DocumentSnapshot> docs = querySnapshot.docs;

    try {
      if (docs.isEmpty) {
        print("a lista de cortes está vazia");
      } else {
        _listaCortes.clear();
        for (var doc in docs) {
          String documentName = doc.id;
          _listaCortes.add(
            CorteClass(
              isActive: false,
              DiaDoCorte: 0,
              clientName: "",
              NomeMes: "NomeMes",
              id: "id",
              numeroContato: "",
              profissionalSelect: "",
              diaCorte: DateTime.now(),
              horarioCorte: "",
              sobrancelha: false,
              ramdomCode: 0,
              dateCreateAgendamento: DateTime.now(),
            ),
          );
        }
      }
      print("o tamanho da lista pega do firebase é ${_listaCortes.length}");
    } catch (e) {
      print("ocorreu um erro: ${e}");
    }
    notifyListeners();
  }
}
