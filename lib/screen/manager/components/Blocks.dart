import 'package:barbershop2/classes/cortecClass.dart';
import 'package:barbershop2/functions/managerScreenFunctions.dart';
import 'package:barbershop2/functions/profileScreenFunctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../classes/GeralUser.dart';

class BlocksManagerComponent extends StatefulWidget {
  const BlocksManagerComponent({super.key});

  @override
  State<BlocksManagerComponent> createState() => _BlocksManagerComponentState();
}

class _BlocksManagerComponentState extends State<BlocksManagerComponent> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ManagerScreenFunctions>(context,listen:false);
    loadTotalClientes();
    totalCortesNomES;
    loadTotalcortesmes();
    totalClientes;
    mesAtual;
    loadAtualMonth();

  }

  int? totalClientes;
  void loadTotalClientes() async {
    List<GeralUser> listClientes =
        await Provider.of<ManagerScreenFunctions>(context, listen: false)
            .clientesLista;

    setState(() {
      totalClientes = listClientes.length;
    });
  }
  //

  int? totalCortesNomES;
  void loadTotalcortesmes() async {
    List<CorteClass> listCortesfinal =
        await Provider.of<ManagerScreenFunctions>(context, listen: false)
            .listaCortes;

    setState(() {
      totalCortesNomES = listCortesfinal.length;
    });
  }

  String? mesAtual;
  Future<void> loadAtualMonth() async {
    final DateTime dataAtual = DateTime.now();
    await initializeDateFormatting('pt_BR');

    String monthName = DateFormat('MMMM', 'pt_BR').format(dataAtual);

    setState(() {
      mesAtual = monthName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        //  color: Colors.red,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.35,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(45),
                          ),
                          child: Icon(
                            Icons.people,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${totalClientes}",
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "Clientes",
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black45,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(45),
                                  ),
                                  child: Icon(
                                    Icons.cut,
                                    color: Colors.grey.shade700,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  totalCortesNomES! > 1
                                      ? "${totalCortesNomES} cortes"
                                      : "${totalCortesNomES} corte",
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Agendados em ${mesAtual ?? "Carregando..."}",
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black54,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(45),
                                  ),
                                  child: Icon(
                                    Icons.paid,
                                    color: Colors.grey.shade700,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  totalCortesNomES! >= 1
                                      ? "R\$${totalCortesNomES! * 35},00"
                                      : "R\$0,00",
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Faturamento esperado",
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black54,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
