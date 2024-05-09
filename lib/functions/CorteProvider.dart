import 'dart:async';

import 'package:barbershop2/classes/cortecClass.dart';
import 'package:barbershop2/classes/horarios.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class CorteProvider with ChangeNotifier {
  final database = FirebaseFirestore.instance;
  final authSettings = FirebaseAuth.instance;

  //ENVIANDO O CORTE PARA AS LISTAS NO BANCO DE DADOS - INICIO
  Future<void> AgendamentoCortePrincipalFunctions(
      {required CorteClass corte, required DateTime selectDateForUser}) async {
    print("entrei na funcao");

    await initializeDateFormatting('pt_BR');
    int diaCorteSelect = corte.diaCorte.day;
    String monthName =
        await DateFormat('MMMM', 'pt_BR').format(selectDateForUser);
    print(monthName);
    print("entrei na funcao");
    try {
      //adicionado lista principal de cortes do dia
      final addOnDB = await database
          .collection("agenda")
          .doc(monthName)
          .collection("${diaCorteSelect}")
          .doc(corte.horarioCorte)
          .set({
        'isActive': corte.isActive,
        "diaDoCorte": corte.DiaDoCorte,
        "id": corte.id,
        "dataCreateAgendamento": corte.dateCreateAgendamento,
        "clientName": corte.clientName,
        "numeroContato": corte.numeroContato,
        "sobrancelha": corte.sobrancelha,
        "diaCorte": corte.diaCorte,
        "horarioCorte": corte.horarioCorte,
        "profissionalSelect": corte.profissionalSelect,
        "ramdomNumber": corte.ramdomCode,
        "monthName": monthName,
      });

      //adicionado allcuts
      final addAllcuts = await database.collection("allCuts").doc(monthName).collection("all").add({
        "id": corte.id,
        'isActive': corte.isActive,
        "diaDoCorte": corte.DiaDoCorte,
        "dataCreateAgendamento": corte.dateCreateAgendamento,
        "clientName": corte.clientName,
        "numeroContato": corte.numeroContato,
        "sobrancelha": corte.sobrancelha,
        "diaCorte": corte.diaCorte,
        "horarioCorte": corte.horarioCorte,
        "profissionalSelect": corte.profissionalSelect,
        "ramdomNumber": corte.ramdomCode,
        "monthName": monthName,
      });
      final userId = await authSettings.currentUser!.uid;
      final myCortes = await database
          .collection("meusCortes")
          .doc(userId)
          .collection("lista")
          .add({
        "id": corte.id,
        'isActive': corte.isActive,
        "diaDoCorte": corte.DiaDoCorte,
        "clientName": corte.clientName,
        "numeroContato": corte.numeroContato,
        "sobrancelha": corte.sobrancelha,
        "diaCorte": corte.diaCorte,
        "dataCreateAgendamento": corte.dateCreateAgendamento,
        "horarioCorte": corte.horarioCorte,
        "profissionalSelect": corte.profissionalSelect,
        "ramdomNumber": corte.ramdomCode,
        "monthName": monthName,
      });

      //adicionado aos meus cortes
      final updateLenghCortesInProfile =
          await database.collection("usuarios").doc(userId).update({
        "totalCortes": FieldValue.increment(
            1), //update do int para +1 atualizando ototal de cortes
      });
    } catch (e) {
      print("ocorreu isto:${e}");
    }
    notifyListeners();
  }
  //ENVIANDO O CORTE PARA AS LISTAS NO BANCO DE DADOS - FIM

  //CARREGANDO OS CORTES E FAZENDO A VERIFICACAO - INICIO


  List<Horarios> _horariosListLoad = [];
  List<Horarios> get horariosListLoad => [..._horariosListLoad];
  //
  Future<void> loadCortesDataBaseFuncionts(
  
      DateTime mesSelecionado, int DiaSelecionado) async {
   
    _horariosListLoad.clear();
    await initializeDateFormatting('pt_BR');

    String monthName = DateFormat('MMMM', 'pt_BR').format(mesSelecionado);

    QuerySnapshot querySnapshot = await database
        .collection("agenda")
        .doc(monthName)
        .collection("${DiaSelecionado}")
        .get();
    List<DocumentSnapshot> docs = querySnapshot.docs;
    try {
      if (docs.isEmpty) {
        print("nao tem dados no docs procurado");
      } else {
        _horariosListLoad.clear();
        for (var doc in docs) {
          String documentName = doc.id;
          _horariosListLoad.add(
            Horarios(horario: documentName, id: ""),
          );
         
        }
        DiaSelecionado = 0;
      }
    } catch (e) {
      print(e);
    }
    print("o tamanho da lista é de provider ${_horariosListLoad.length}");

    notifyListeners();
  }
  //CARREGANDO OS CORTES E FAZENDO A VERIFICACAO - FIM

  //load dos cortes do usuario, e eadicionando a uma list - INICIO

  final StreamController<List<CorteClass>> _cortesController =
      StreamController<List<CorteClass>>.broadcast();

  Stream<List<CorteClass>> get cortesStream => _cortesController.stream;

  List<CorteClass> _historyList = [];
  List<CorteClass> get userCortesTotal => [..._historyList];
  Future<void> loadHistoryCortes() async {
    try {
      // Emite a lista atualizada através do StreamController

      QuerySnapshot querySnapshot = await database
          .collection('meusCortes/${authSettings.currentUser!.uid}/lista')
          .get();

      _historyList = querySnapshot.docs.map((doc) {
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
      _cortesController.add(_historyList);
      // Ordenar os dados pela data
      _historyList.sort((a, b) {
        return b.dateCreateAgendamento.compareTo(a.dateCreateAgendamento);
      });

      notifyListeners();
    } catch (e) {
      print('Erro ao carregar os dados do Firebase: $e');
    }
  }

  //ATUALIZANDO O ITEM ISACTIVE(TELA DO MANAGER)
  
}

//load dos cortes do usuario, e eadicionando a uma list - FIM
