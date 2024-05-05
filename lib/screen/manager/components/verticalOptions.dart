import 'dart:ffi';

import 'package:barbershop2/classes/Estabelecimento.dart';
import 'package:barbershop2/functions/CorteProvider.dart';
import 'package:barbershop2/rotas/Approutes.dart';
import 'package:barbershop2/screen/manager/ManagerScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ManagerVerticalOptions extends StatefulWidget {
  const ManagerVerticalOptions({super.key});

  @override
  State<ManagerVerticalOptions> createState() => _ManagerVerticalOptionsState();
}

class _ManagerVerticalOptionsState extends State<ManagerVerticalOptions> {
  final num1 = TextEditingController();
  final num2 = TextEditingController();
  final num3 = TextEditingController();
  final num4 = TextEditingController();
  final num5 = TextEditingController();

  String? ramdomcodeUse;
  void setandocode() {
    setState(() {
      ;
    });
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text("Código Validado"),
          content: Text("Presença do Cliente Confirmada"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => ManagerScreenView(),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: Text("Fechar"),
            ),
          ],
        );
      },
    );
  }

  Future<void> setAndMyCortesIsActive() async {
    final String codeForUse =
        await num1.text + num2.text + num3.text + num4.text + num5.text;
    print("o codigo do barberiro foi ${codeForUse}");
    final database = FirebaseFirestore.instance;
    //=> Puxando os id´s do usuário
    QuerySnapshot querySnapshot = await database.collection("usuarios").get();
    //=> Dividindo os dados do firebase em snapshots
    List<DocumentSnapshot> docs = querySnapshot.docs;
    if (docs.isEmpty) {
      print("Nenhum documento encontrado");
    } else {
      for (var userDoc in docs) {
        try {
          //=> Acessando o item de todos os usuário(histórico)
          //a partir dos id´s coletados, entra em cada 1 e atualiza os atributos na pasta interna
          QuerySnapshot open = await database
              .collection("meusCortes")
              .doc(userDoc.id)
              .collection("lista")
              .get();

          //=> Dividindo os dados do firebase em snapshots(histórico)
          List<DocumentSnapshot> openDocs = open.docs;
          if (openDocs.isEmpty) {
            print("Nenhum documento encontrado na lista de cortes");
          } else {
            for (var itemDoc in openDocs) {
              print('entrei no for');
              Map<String, dynamic> data =
                  itemDoc.data() as Map<String, dynamic>;
              if (data != null) {
                print('Data não é nulo');
                // Convertendo o ramdomNumber para String antes da comparação
                if (data['ramdomNumber'].toString() == codeForUse) {
                  print('Encontrei o corte correspondente');
                  // Atualizando o documento no Firestore
                  await database
                      .collection("meusCortes")
                      .doc(userDoc.id)
                      .collection("lista")
                      .doc(itemDoc.id)
                      .update({'isActive': false});
                  Future.delayed(Duration.zero, () {
                    _showErrorDialog(context);
                  });
                  print('função de troca bool executada');
                  break;
                } else if (data['ramdomNumber'].toString() != codeForUse) {
                  print('O ramdomNumber não corresponde');
            
                }
              } else {
                print('Data é nulo');
              }
            }
          }
        } catch (e) {
          print("Erro ao atualizar o documento: $e");
        }
      }
    }
  }

  void showVerificationModalManager() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 10, right: 20, left: 20),
          child: Column(
            children: [
              Container(
                width: 80,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Código Único",
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Digite o código do corte do seu cliente, disponível na tela do app do seu Cliente",
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //DIGITO 1 - INICIO
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 2),
                      child: Container(
                        alignment: Alignment.center,
                        width: 62,
                        height: 72,
                        padding: EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Estabelecimento.primaryColor.withOpacity(0.3),
                        ),
                        child: TextFormField(
                          controller: num1,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    //DIGITO 1 - FIM
                    //DIGITO 2 - INICIO
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Container(
                        alignment: Alignment.center,
                        width: 62,
                        height: 72,
                        padding: EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Estabelecimento.primaryColor.withOpacity(0.3),
                        ),
                        child: TextFormField(
                          controller: num2,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    //DIGITO 2 - FIM

                    //DIGITO 3 - INICIO
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Container(
                        alignment: Alignment.center,
                        width: 62,
                        height: 72,
                        padding: EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Estabelecimento.primaryColor.withOpacity(0.3),
                        ),
                        child: TextFormField(
                          controller: num3,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    //DIGITO 3 - FIM
                    //DIGITO 4 - INICIO
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Container(
                        alignment: Alignment.center,
                        width: 62,
                        height: 72,
                        padding: EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Estabelecimento.primaryColor.withOpacity(0.3),
                        ),
                        child: TextFormField(
                          controller: num4,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    //DIGITO 4 - FIM

                    //DIGITO 5 - INICIO
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Container(
                        alignment: Alignment.center,
                        width: 62,
                        height: 72,
                        padding: EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Estabelecimento.primaryColor.withOpacity(0.3),
                        ),
                        child: TextFormField(
                          controller: num5,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    //DIGITO 5 - FIM
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: setAndMyCortesIsActive,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 1.3,
                  height: 50,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Estabelecimento.primaryColor,
                  ),
                  child: Text(
                    "Registrar ",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Estabelecimento.contraPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Opcões Avançadas",
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //VERIFICAR O CODIGO - INICIO
            InkWell(
              onTap: showVerificationModalManager,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(32, 32, 32, 0.1),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromRGBO(32, 32, 32, 0.2),
                          ),
                          child: Icon(Icons.qr_code),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Verificar Código do Cliente",
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                "Código disponível no Dispositivo de seu cliente.",
                                overflow: TextOverflow.visible,
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade500,
                                      fontSize: 13),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Container(
                      child: Icon(
                        Icons.chevron_right,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //VERIFICAR O CODIGO - FIM
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
