import 'dart:math';

import 'package:barbershop2/classes/Estabelecimento.dart';
import 'package:barbershop2/classes/cortecClass.dart';
import 'package:barbershop2/classes/horarios.dart';
import 'package:barbershop2/functions/managerScreenFunctions.dart';
import 'package:barbershop2/functions/providerFilterStrings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemComponentHourFuncionario extends StatefulWidget {
  final CorteClass Corte;
  const ItemComponentHourFuncionario({
    super.key,
    required this.Corte,
  });

  @override
  State<ItemComponentHourFuncionario> createState() =>
      _ItemComponentHourState();
}

class _ItemComponentHourState extends State<ItemComponentHourFuncionario> {
  Color _generateRandomLightColor() {
    Random random = Random();
    int minBrightness = 1; // ajuste este valor para controlar o brilho mínimo
    return Color.fromARGB(
      255,
      minBrightness + random.nextInt(200 - minBrightness), // red
      minBrightness + random.nextInt(200 - minBrightness), // green
      minBrightness + random.nextInt(200 - minBrightness), // blue
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetAndConfigprofffilter();
    loadUserNameProfissionalISTA();
    setState(() {});
  }

  // Função para abrir o navegador
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir a URL: $url';
    }
  }

  String? nomeUsuarioParaUsarNaLista;
  Future<void> loadUserNameProfissionalISTA() async {
    String? nomeParaPuxar = await ManagerScreenFunctions()
        .getNomeFuncionarioParaListarFaturamento();

    if (nomeUsuarioParaUsarNaLista != null) {
    } else {
      const Text('N/A');
    }
    print("a lista que devemos puxar é a do: ${nomeParaPuxar}");
    setState(() {
      nomeUsuarioParaUsarNaLista = nomeParaPuxar;
      GetAndConfigprofffilter();
    });
  }

  String proffGet = "";
  void GetAndConfigprofffilter() {
    setState(() {
      proffGet = nomeUsuarioParaUsarNaLista ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    Color _randomColor = _generateRandomLightColor();

    return widget.Corte.isActive == true &&
            widget.Corte.isActive != false &&
            (proffGet.isEmpty || proffGet == widget.Corte.profissionalSelect)
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Container(
              key: Key(widget.Corte.id),
              decoration: BoxDecoration(
                  color: _randomColor, borderRadius: BorderRadius.circular(25)),
              width: MediaQuery.of(context).size.width * 1,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.8,
                            color: Colors.grey.shade100,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Text(
                          "${widget.Corte.profissionalSelect}",
                          style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "${Estabelecimento.nomeLocal}",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(
                          "Cliente:",
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade300,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${widget.Corte.clientName}",
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(
                          "barba:",
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade300,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${widget.Corte.barba == true ? "Inclusa" : "Não Inclusa"}",
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.schedule,
                            size: 25,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${widget.Corte.horarioCorte}h",
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 15),
                            ),
                          )
                        ],
                      ),
                      widget.Corte.numeroContato.isEmpty
                          ? Container()
                          : InkWell(
                              onTap: () {
                                _launchURL(
                                    "https://api.whatsapp.com/send?phone=55${widget.Corte.numeroContato}");
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 1),
                                decoration: BoxDecoration(
                                    color: Colors.green.shade600,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Entrar em contato",
                                      style: GoogleFonts.openSans(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.08,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.08,
                                      child: Image.asset(
                                          "imagesOfApp/whatsaaplogo.png"),
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
          )
        : SizedBox.shrink(
            key: Key(widget.Corte.id),
          );
  }
}
