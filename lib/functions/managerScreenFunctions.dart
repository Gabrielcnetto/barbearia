import 'dart:async';

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

  final StreamController<List<CorteClass>> _CorteslistaManager =
      StreamController<List<CorteClass>>.broadcast();

  Stream<List<CorteClass>> get CorteslistaManager => _CorteslistaManager.stream;

  List<CorteClass> _managerListCortes = [];
  List<CorteClass> get managerListCortes => [..._managerListCortes];
  Future<void> loadAfterSetDay({
    required int selectDay,
    required String selectMonth,
    required String proffName,
  }) async {
    print("tela do manager, 7 dias corte funcao executada");
    QuerySnapshot querySnapshot =
        await database.collection('agenda/${selectMonth}/${selectDay}/${"Marcelo%20D."}/all').get();
      print('agenda/${selectMonth}/${selectDay}/${"Marcelo%20D."}/all');
    _managerListCortes = querySnapshot.docs.map((doc) {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

      Timestamp? timestamp;
      if (data != null) {
        timestamp = data['dataCreateAgendamento'] as Timestamp?;
      }

      DateTime diaCorte = timestamp?.toDate() ?? DateTime.now();
      //CONVERTENDO O DIA DO CORTE AGORA
      Timestamp? diafinalCorte;
      if (data != null) {
        timestamp = data['diaCorte'] as Timestamp?;
      }

      DateTime diaCorteFinal = diafinalCorte?.toDate() ?? DateTime.now();
      // Acessando os atributos diretamente usando []
      return CorteClass(
        isActive: data?["isActive"],
        DiaDoCorte: data?["diaDoCorte"],
        NomeMes: data?["monthName"],
        dateCreateAgendamento: diaCorte,
        clientName: data?['clientName'],
        id: data?['id'],
        numeroContato: data?['numeroContato'],
        profissionalSelect: data?['profissionalSelect'],
        diaCorte: diaCorteFinal, // Usando o atributo diaCorte
        horarioCorte: data?['horarioCorte'],
        sobrancelha: data?['sobrancelha'],
        ramdomCode: data?['ramdomNumber'],
      );
    }).toList();
    _CorteslistaManager.add(_managerListCortes);

    // Ordenar os dados pela data
    _managerListCortes.sort((a, b) {
      return b.dateCreateAgendamento.compareTo(a.dateCreateAgendamento);
    });
    _managerListCortes.sort((a, b) {
      // Aqui, estamos comparando os horários de corte como strings
      return a.horarioCorte.compareTo(b.horarioCorte);
    });

    notifyListeners();
  }
}
