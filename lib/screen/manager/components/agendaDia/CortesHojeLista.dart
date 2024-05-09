import 'package:barbershop2/classes/Estabelecimento.dart';
import 'package:barbershop2/classes/horarios.dart';
import 'package:barbershop2/functions/CorteProvider.dart';
import 'package:barbershop2/screen/manager/components/agendaDia/diaListComponent.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CortesHojeLista extends StatefulWidget {
  const CortesHojeLista({super.key});

  @override
  State<CortesHojeLista> createState() => _CortesHojeListaState();
}



class _CortesHojeListaState extends State<CortesHojeLista> {


  @override
  Widget build(BuildContext context) {
    final List<Horarios> _horariosLOad =
        Provider.of<CorteProvider>(context, listen: false).horariosListLoad;
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Agenda do dia",
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Estabelecimento.primaryColor,
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: Text(
                  "Dia 03/04",
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            ],
          ),
          DiaListaComponent()
        ],
      ),
    );
  }
}
