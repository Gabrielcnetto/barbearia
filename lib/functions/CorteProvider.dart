import 'package:barbershop2/classes/cortecClass.dart';
import 'package:barbershop2/classes/horarios.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class CorteProvider with ChangeNotifier {
  final database = FirebaseFirestore.instance;
  final authSettings = FirebaseAuth.instance;

  //ENVIANDO O CORTE PARA AS LISTAS NO BANCO DE DADOS - INICIO
  Future<void> AgendamentoCortePrincipalFunctions({required CorteClass corte, required DateTime selectDateForUser}) async {
    print("entrei na funcao");
    
    await initializeDateFormatting('pt_BR');
    int diaCorteSelect = corte.diaCorte.day;
    String monthName = await DateFormat('MMMM', 'pt_BR').format(selectDateForUser);
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
        "id": corte.id,
        "clientName": corte.clientName,
        "numeroContato": corte.numeroContato,
        "sobrancelha": corte.sobrancelha,
        "diaCorte": corte.diaCorte,
        "horarioCorte": corte.horarioCorte,
        "profissionalSelect": corte.profissionalSelect,
      });

      //adicionado allcuts
      final addAllcuts = await database.collection("allCuts").add({
        "id": corte.id,
        "clientName": corte.clientName,
        "numeroContato": corte.numeroContato,
        "sobrancelha": corte.sobrancelha,
        "diaCorte": corte.diaCorte,
        "horarioCorte": corte.horarioCorte,
        "profissionalSelect": corte.profissionalSelect,
      });
      final userId = await authSettings.currentUser!.uid;
      final myCortes = await database
          .collection("meusCortes")
          .doc(userId)
          .collection("lista")
          .add({
        "id": corte.id,
        "clientName": corte.clientName,
        "numeroContato": corte.numeroContato,
        "sobrancelha": corte.sobrancelha,
        "diaCorte": corte.diaCorte,
        "horarioCorte": corte.horarioCorte,
        "profissionalSelect": corte.profissionalSelect,
      });
      //adicionado aos meus cortes
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
}
