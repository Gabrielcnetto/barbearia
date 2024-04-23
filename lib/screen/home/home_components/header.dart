import 'package:barbershop2/classes/Estabelecimento.dart';
import 'package:barbershop2/functions/profileScreenFunctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'circularProgressIndicLevel.dart';

class HomePageHeader extends StatefulWidget {
  final double widhTela;
  final double heighTela;
  const HomePageHeader({
    super.key,
    required this.heighTela,
    required this.widhTela,
  });

  @override
  State<HomePageHeader> createState() => _HomePageHeaderState();
}

class _HomePageHeaderState extends State<HomePageHeader> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    urlImagePhoto;
    userName;
    urlImageFuncion();
  }

  String? urlImagePhoto;
  Future<void> urlImageFuncion() async {
    String? number = await MyProfileScreenFunctions().getUserImage();

    if (urlImagePhoto != null) {
    } else {
      const Text('N/A');
    }

    setState(() {
      urlImagePhoto = number;
      loadUserName();
    });
  }

  String? userName;
  Future<void> loadUserName() async {
    String? usuario = await MyProfileScreenFunctions().getUserName();

    if (userName != null) {
    } else {
      const Text('N/A');
    }

    setState(() {
      userName = usuario;
      splitName();
    });
  }

  String? finalName;
  Future<void> splitName() async {
    List<String> partes = userName!.split(" ");
    String userFirst = partes[0];

    setState(() {
      finalName = userFirst;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tamanhoTela = MediaQuery.of(context).size;

    double heighTelaFinal = tamanhoTela.height;

    final double setHeigh = heighTelaFinal > 800
        ? heighTelaFinal / 2.3
        : heighTelaFinal < 500
            ? heighTelaFinal / 2.1
            : heighTelaFinal / 1.9;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: setHeigh,
        maxHeight: setHeigh,
        minWidth: widget.widhTela,
        maxWidth: widget.widhTela,
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 5),
        child: Stack(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: setHeigh * 0.85,
                maxHeight: setHeigh * 0.85,
                minWidth: widget.widhTela,
                maxWidth: widget.widhTela,
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Estabelecimento.secondaryColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.elliptical(60, 60),
                    bottomRight: Radius.elliptical(60, 60),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 45, right: 15),
              child: Positioned(
                top: 0,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          Estabelecimento.nomeLocal,
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Estabelecimento.secondaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Bem-vindo(a), ${finalName ?? "..."}",
                                style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Text(
                                "Você Possui 13 Pontos",
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade700,
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            ],
                          ),
                          CircularProgressWithImage(
                            progress: 0.8,
                            imageSize: widget.widhTela / 5.5,
                            widghTela: widget.widhTela,
                            imageUrl: urlImagePhoto != null
                                ? urlImagePhoto!
                                : Estabelecimento.defaultAvatar,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 2,
                child: Container(
                  width: widget.widhTela,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  height: widget.widhTela / 2.3,
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
                          Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(90),
                              child: Container(
                                width: 90,
                                height: 90,
                                child: Image.network(
                                  "https://img.odcdn.com.br/wp-content/uploads/2024/03/mark-zuckerberg.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            width: widget.widhTela / 4,
                            height: widget.heighTela / 1.5 * 0.2,
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
                                    "Eduardo",
                                    style: GoogleFonts.openSans(),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Com Sobrancelha",
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
                                "15 fev - 17:50",
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.green.shade200
                                          .withOpacity(0.4),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Text(
                                      "R\$50,00",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Ver Código",
                                          style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 13,
                                                color: Estabelecimento
                                                    .contraPrimaryColor),
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
            )
          ],
        ),
      ),
    );
  }
}
