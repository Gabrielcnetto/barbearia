import 'package:barbershop2/classes/Estabelecimento.dart';
import 'package:barbershop2/functions/managerScreenFunctions.dart';
import 'package:barbershop2/screen/manager/agenda_7dias/streamLoad7Diascortes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Agenda7DiasScreenManager extends StatefulWidget {
  const Agenda7DiasScreenManager({super.key});

  @override
  State<Agenda7DiasScreenManager> createState() =>
      _Agenda7DiasScreenManagerState();
}

class _Agenda7DiasScreenManagerState extends State<Agenda7DiasScreenManager> {
  List<int> lastSevenDays = [];
  List<String> lastSevenMonths = [];
  setDaysAndMonths() {
    initializeDateFormatting('pt_BR');
    DateTime now = DateTime.now();
    for (int i = 0; i < 7; i++) {
      DateTime date = now.subtract(Duration(days: i));
      int dayOfMonth = int.parse(DateFormat('d').format(date));
      String monthName = DateFormat('MMMM', 'pt_BR').format(date);
      lastSevenDays.add(dayOfMonth);
      lastSevenMonths.add(monthName);
    }
    lastSevenDays = lastSevenDays.reversed.toList();
    lastSevenMonths = lastSevenMonths.reversed.toList();
  }

  Future<void> attViewSchedule(
      {required int dia,
      required String mes,
      required String proffName}) async {
    print("dia selecionado:${dia} e o mês é o: ${mes}");
    Provider.of<ManagerScreenFunctions>(context, listen: false).loadAfterSetDay(
        selectDay: dia, selectMonth: mes, proffName: proffName);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setDaysAndMonths();
    attViewSchedule;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                  Text(
                    "Horários Fechados",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(lastSevenDays.length, (index) {
                    int day = lastSevenDays[index];
                    String month = lastSevenMonths[index];
                    String firstLetterOfMonth = month.substring(0, 1);
                    return InkWell(
                      onTap: () {
                        attViewSchedule(
                            dia: day, mes: month, proffName: "Marcelo%20D");
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.115,
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Estabelecimento.primaryColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "$day",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Estabelecimento.contraPrimaryColor,
                                ),
                              ),
                            ),
                            Text(
                              "${firstLetterOfMonth.toUpperCase()}",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11,
                                  color: Estabelecimento.contraPrimaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(height: MediaQuery.of(context).size.height * 0.06, width: 30, color: Colors.red,)
                ],
              ),
              SizedBox(
                height: 20,
              ),
              StreamLoad7dias(),
            ],
          ),
        ),
      ),
    );
  }
}
