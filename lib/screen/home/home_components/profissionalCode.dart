import 'package:barbershop2/classes/Estabelecimento.dart';
import 'package:barbershop2/classes/cortecClass.dart';
import 'package:barbershop2/functions/CorteProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfissionalCode extends StatefulWidget {
  final CorteClass corte;
  const ProfissionalCode({
    super.key,
    required this.corte,
  });

  @override
  State<ProfissionalCode> createState() => _ProfissionalCodeState();
}

class _ProfissionalCodeState extends State<ProfissionalCode> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MonthCorte;
    setDateCort();
    print("o barbeiro selecionado é ${widget.corte.profissionalSelect}");
  }

  String? MonthCorte;
  Future<void> setDateCort() async {
    await initializeDateFormatting('pt_BR');
    String monthName =
        await DateFormat('MMMM', 'pt_BR').format(widget.corte.diaCorte);
    setState(() {
      MonthCorte = monthName;
    });
  }

  @override
  Widget build(BuildContext context) {
    double widhTela = MediaQuery.of(context).size.width;
    double heighTela = MediaQuery.of(context).size.width;

    return Positioned(
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 2,
        child: Container(
          width: widhTela,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          height: widhTela / 2.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            border: Border.all(
              width: 0.2,
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Próximo agendamento",
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                      color: Estabelecimento.secondaryColor,
                      fontWeight: FontWeight.w500,
                    )),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Estabelecimento.secondaryColor,
                    size: 20,
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(120),
                    child: Container(
                      width: 90,
                      height: 90,
                      child: widget.corte.profissionalSelect != "Não Definido"
                          ? Image.asset(
                              widget.corte.profissionalSelect == "Marcelo D."
                                  ? "imagesOfApp/barbeiros/fotobarbeiro1.jpeg"
                                  : widget.corte.profissionalSelect ==
                                          "Gabriel N."
                                      ? "imagesOfApp/barbeiros/foto02.jpg"
                                      : widget.corte.profissionalSelect ==
                                              "Lucas E."
                                          ? "imagesOfApp/barbeiros/foto3.webp"
                                          : "",
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              "imagesOfApp/barbeiros/naodefinidoimage.jpeg",
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Profissional:",
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${widget.corte.profissionalSelect}",
                            style: GoogleFonts.openSans(),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.corte.sobrancelha
                            ? "Com Sobrancelha"
                            : "Sem sobrancelha",
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${widget.corte.DiaDoCorte} de ${widget.corte.NomeMes} - ${widget.corte.horarioCorte}",
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green.shade200.withOpacity(0.4),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Text(
                              "R\$35,00",
                              style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                    color: Colors.green),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Estabelecimento.primaryColor,
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Ver Código",
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                        color:
                                            Estabelecimento.contraPrimaryColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottom: 0,
      left: 25,
      right: 25,
    );
  }
}
