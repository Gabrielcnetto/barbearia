import 'package:barbershop2/classes/Estabelecimento.dart';
import 'package:barbershop2/classes/cortecClass.dart';
import 'package:barbershop2/functions/CorteProvider.dart';
import 'package:barbershop2/functions/profileScreenFunctions.dart';
import 'package:barbershop2/screen/home/home_components/profissionalCode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
    valorPoints;
    ajustePoints();
    userProfileIsOk;
    urlImagePhoto;
    VerifyImageUser();
    userName;
    urlImageFuncion();
    Provider.of<CorteProvider>(context, listen: false).userCortesTotal;
    Provider.of<CorteProvider>(context, listen: false).loadHistoryCortes;
  }

  String? urlImagePhoto;
  Future<void> urlImageFuncion() async {
    String? number = await MyProfileScreenFunctions().getUserImage();

    if (urlImagePhoto != null) {
      print("imagem do usuario nao definidida");
    } else {
      const Text('N/A');
    }

    setState(() {
      urlImagePhoto = number;
      loadUserName();
    });
  }

  bool? userProfileIsOk;
  void VerifyImageUser() {
    if (urlImagePhoto != null) {
      setState(() {
        userProfileIsOk = true;
      });
    } else {
      setState(() {
        userProfileIsOk = false;
      });
    }
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

  CorteClass? _listaCortesUsuario;

  double valorPoints = 0;
  Future<void> ajustePoints() async {
    int PointOfClient = Provider.of<CorteProvider>(context, listen: false)
        .userCortesTotal
        .length;
    setState(() {
      valorPoints = PointOfClient.toDouble();
      valorPoints = valorPoints % 12;
    });
  }

  double calcularProgresso() {
    // Calcula o progresso com base nos pontos acumulados
    return valorPoints / 12.0;
  }

  @override
  Widget build(BuildContext context) {
    CorteClass _listaCortesUsuario =
        Provider.of<CorteProvider>(context, listen: false).userCortesTotal[0];

    List<CorteClass> listaGeral =
        Provider.of<CorteProvider>(context, listen: false).userCortesTotal;
    final tamanhoTela = MediaQuery.of(context).size;
    print(_listaCortesUsuario == null ? "o item é null" : "nao é null");
    double heighTelaFinal = tamanhoTela.height;

    final double setHeigh = heighTelaFinal > 800
        ? heighTelaFinal / 2.3
        : heighTelaFinal < 500
            ? heighTelaFinal / 2.1
            : heighTelaFinal / 1.9;

    //PEGANDO O CODIGO ATIVO

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
                                "Você Possui ${(valorPoints * 3).toStringAsFixed(0)} Pontos",
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
                            totalCortes: Provider.of<CorteProvider>(context,
                                    listen: false)
                                .userCortesTotal
                                .length,
                            progress: calcularProgresso(),
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
            ProfissionalCode(
              corte: CorteClass(
                isActive: _listaCortesUsuario.isActive,
                DiaDoCorte: _listaCortesUsuario.DiaDoCorte,
                NomeMes: _listaCortesUsuario.NomeMes,
                dateCreateAgendamento:
                    _listaCortesUsuario.dateCreateAgendamento,
                clientName: "${_listaCortesUsuario.clientName}",
                id: "${_listaCortesUsuario.id}",
                numeroContato: "${_listaCortesUsuario.numeroContato}",
                profissionalSelect: "${_listaCortesUsuario.profissionalSelect}",
                diaCorte: _listaCortesUsuario.diaCorte,
                horarioCorte: "${_listaCortesUsuario.horarioCorte}",
                sobrancelha: _listaCortesUsuario.sobrancelha,
                ramdomCode: _listaCortesUsuario.ramdomCode,
              ),
            )
          ],
        ),
      ),
    );
  }
}
