import 'dart:math';

import 'package:barbershop2/classes/Estabelecimento.dart';
import 'package:barbershop2/classes/cortecClass.dart';
import 'package:barbershop2/classes/horarios.dart';
import 'package:barbershop2/classes/profissionais.dart';
import 'package:barbershop2/functions/CorteProvider.dart';
import 'package:barbershop2/functions/profileScreenFunctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userName;
    loadUserName();

    phoneNumber;
    loadUserPhone();
  }

  bool sobrancelha = true;

  void sobrancelhaTrue() {
    if (sobrancelha == false) {
      setState(() {
        sobrancelha = true;
      });
    }
  }

  void sobrancelhaFalse() {
    if (sobrancelha == true) {
      setState(() {
        sobrancelha = false;
      });
    }
  }

  final List<Profissionais> _profList = profList;
  bool isMarcelo = false;
  bool isGabriel = false;
  bool isLucas = false;

  void setMarcelo() {
    if (isMarcelo == true) {
      null;
    } else {
      setState(() {
        isMarcelo = true;
        isGabriel = false;
        isLucas = false;
      });
    }
  }

  void setGabriel() {
    if (isGabriel == true) {
      null;
    } else {
      setState(() {
        isGabriel = true;
        isMarcelo = false;

        isLucas = false;
      });
    }
  }

  void setLucas() {
    if (isLucas == true) {
      null;
    } else {
      setState(() {
        isLucas = true;
        isGabriel = false;
        isMarcelo = false;
      });
    }
  }

  DateTime? dataSelectedInModal;
  Future<void> ShowModalData() async {
    setState(() {
      dataSelectedInModal = null;
    });
    showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(days: 14),
      ),
    ).then((selectUserDate) {
      try {
        setState(() {
          dataSelectedInModal = selectUserDate;
          loadListCortes();
        });
      } catch (e) {
        return showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text('Erro'),
              content: Text("${e}"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Fecha o modal
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  int selectedIndex = -1;
  Map<int, Color> itemColors = {};
  Map<int, Color> _textColor = {};

  //controlers
  final nomeControler = TextEditingController();
  final numberControler = TextEditingController();

  String? userName;
  Future<void> loadUserName() async {
    String? usuario = await MyProfileScreenFunctions().getUserName();

    if (userName != null) {
    } else {
      const Text('N/A');
    }

    setState(() {
      userName = usuario;
      setDataControlers();
    });
  }

  //
  String? phoneNumber;
  Future<void> loadUserPhone() async {
    String? number = await MyProfileScreenFunctions().getPhone();

    if (phoneNumber != null) {
    } else {
      const Text('N/A');
    }

    setState(() {
      phoneNumber = number;
      setPhone();
    });
  }

  void setPhone() {
    numberControler.text = phoneNumber!;
  }

  void setDataControlers() {
    setState(() {
      nomeControler.text = userName!;
    });
  }

  String? hourSetForUser;

  Future<void> CreateAgendamento() async {
    Provider.of<CorteProvider>(context, listen: false)
        .AgendamentoCortePrincipalFunctions(
      CorteClass(
        clientName: nomeControler.text,
        id: Random().nextDouble().toString(),
        numeroContato: numberControler.text,
        sobrancelha: sobrancelha,
        diaCorte: dataSelectedInModal!,
        horarioCorte: hourSetForUser!,
      ),
    );
  }

  //Fazendo o filtro para exibir quais horarios estao disponíveis
  List<Horarios> _horariosLivres = hourLists;
  List<Horarios> horarioFinal = [];
  //Aqui pegamos o dia selecionado, e usamos para buscar os dados no banco de dados
  //a funcao abaixo é responsavel por pegar o dia, entrar no provider e pesquisar os horarios daquele dia selecionado
  Future<void> loadListCortes() async {
    List<Horarios> listaTemporaria = List.from(_horariosLivres);
    //pega o dia selecionado pelo cliente

    DateTime? mesSelecionado = dataSelectedInModal;

    //se o dia selecionado nao conter erro, executa a busca
    if (mesSelecionado != null) {
      try {
        await Provider.of<CorteProvider>(context, listen: false)
            .loadCortesDataBaseFuncionts(
          mesSelecionado,
          mesSelecionado.day,
        );
        List<Horarios> listaCort =
            await Provider.of<CorteProvider>(context, listen: false)
                .horariosListLoad;

        for (var horario in listaCort) {
          print("horarios do provider: ${horario.horario}");
          listaTemporaria.removeWhere((atributosFixo) {
            return atributosFixo.horario == horario.horario;
          });
        }
        setState(() {
          horarioFinal = List.from(listaTemporaria);
        });
        setState(() {});

        print("este e o tamanho da lista final: ${horarioFinal.length}");
      } catch (e) {
        print("nao consegu realizar, erro: ${e}");
      }
    } else {
      print("problemas na hora ou dia");
    }
  }

  @override
  Widget build(BuildContext context) {
    final widhScren = MediaQuery.of(context).size.width;
    final heighScreen = MediaQuery.of(context).size.height;
    return Container(
      width: widhScren,
      height: heighScreen,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              width: widhScren,
              height: 180,
              child: Image.asset(
                Estabelecimento.bannerInitial,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 25, left: 25, right: 25),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.elliptical(50, 50),
                    topRight: Radius.elliptical(50, 50),
                  ),
                ),
                width: widhScren,
                height: heighScreen / 1.35,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Agendamento de Horários",
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Preencha os dados abaixo para efetuar o seu agendamento",
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Estabelecimento.secondaryColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //CONTAINER DO NOME inicio
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Estabelecimento.secondaryColor
                                          .withOpacity(0.4)),
                                  child: Text("1"),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Nome do Cliente",
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey.shade200,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 15),
                              child: TextFormField(
                                controller: nomeControler,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            //CONTAINER DO NOME fim
                            //CONTAINER DO NUMERO
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Estabelecimento.secondaryColor
                                          .withOpacity(0.4)),
                                  child: Text("2"),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Telefone de contato",
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey.shade200,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 15),
                              child: TextFormField(
                                controller: numberControler,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            //CONTAINER DO NUMERO
                            //CONTAINER BOOL DA SOBRANCELHA - INICIO
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Estabelecimento.secondaryColor
                                          .withOpacity(0.4)),
                                  child: Text("3"),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Deseja fazer sobrancelha?",
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: widhScren,
                              height: heighScreen * 0.07,
                              child: Stack(
                                children: [
                                  Positioned(
                                    right: 0,
                                    child: InkWell(
                                      onTap: sobrancelhaFalse,
                                      child: Container(
                                        padding: EdgeInsets.only(right: 30),
                                        alignment: Alignment.centerRight,
                                        height: heighScreen * 0.07,
                                        width: !sobrancelha
                                            ? widhScren / 1.8
                                            : widhScren / 3,
                                        decoration: BoxDecoration(
                                          color: Estabelecimento.secondaryColor,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(5),
                                            bottomRight: Radius.circular(5),
                                          ),
                                        ),
                                        child: Text(
                                          "Não",
                                          style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                                fontSize:
                                                    !sobrancelha ? 17 : 14,
                                                fontWeight: !sobrancelha
                                                    ? FontWeight.w800
                                                    : FontWeight.w400,
                                                color: Estabelecimento
                                                    .primaryColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    child: InkWell(
                                      onTap: sobrancelhaTrue,
                                      child: Container(
                                        padding: EdgeInsets.only(left: 30),
                                        alignment: Alignment.centerLeft,
                                        height: heighScreen * 0.07,
                                        width: sobrancelha
                                            ? widhScren / 1.8
                                            : widhScren / 3,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(5),
                                              topLeft: Radius.circular(5),
                                              topRight:
                                                  Radius.elliptical(20, 20),
                                              bottomRight:
                                                  Radius.elliptical(20, 20),
                                            ),
                                            color:
                                                Estabelecimento.primaryColor),
                                        child: Text(
                                          "Sim",
                                          style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                                fontSize: sobrancelha ? 17 : 14,
                                                fontWeight: sobrancelha
                                                    ? FontWeight.w800
                                                    : FontWeight.w400,
                                                color: Estabelecimento
                                                    .contraPrimaryColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //CONTAINER BOOL DA SOBRANCELHA - FIM
                            SizedBox(
                              height: 25,
                            ),
                            //CONTAINER DO PROFISSIONAL - INICIO
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Estabelecimento.secondaryColor
                                          .withOpacity(0.4)),
                                  child: Text("4"),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Profissional de preferência",
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: setMarcelo,
                                      child: Container(
                                        width: widhScren * 0.25,
                                        height: 130,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              top: 0,
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.asset(
                                                  _profList[0].assetImage,
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                            ),
                                            if (isMarcelo)
                                              Positioned(
                                                top: 0,
                                                bottom: 0,
                                                left: 0,
                                                right: 0,
                                                child: Container(
                                                  child: Icon(
                                                    Icons.check_circle,
                                                    color: Colors.white,
                                                    size: 35,
                                                  ),
                                                  width: widhScren * 0.25,
                                                  height: 130,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      _profList[0].nomeProf,
                                      style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: setGabriel,
                                      child: Container(
                                        width: widhScren * 0.25,
                                        height: 130,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              top: 0,
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.asset(
                                                  _profList[1].assetImage,
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                            ),
                                            if (isGabriel)
                                              Positioned(
                                                top: 0,
                                                bottom: 0,
                                                left: 0,
                                                right: 0,
                                                child: Container(
                                                  child: Icon(
                                                    Icons.check_circle,
                                                    color: Colors.white,
                                                    size: 35,
                                                  ),
                                                  width: widhScren * 0.25,
                                                  height: 130,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      _profList[1].nomeProf,
                                      style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: setLucas,
                                      child: Container(
                                        width: widhScren * 0.25,
                                        height: 130,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              top: 0,
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.asset(
                                                  _profList[2].assetImage,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            if (isLucas)
                                              Positioned(
                                                top: 0,
                                                bottom: 0,
                                                left: 0,
                                                right: 0,
                                                child: Container(
                                                  child: Icon(
                                                    Icons.check_circle,
                                                    color: Colors.white,
                                                    size: 35,
                                                  ),
                                                  width: widhScren * 0.25,
                                                  height: 130,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      _profList[2].nomeProf,
                                      style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            //CONTAINER DO PROFISSIONAL - FIM
                            //CONTAINER DA DATA - INICIO
                            SizedBox(
                              height: 25,
                            ),
                            //CONTAINER DO PROFISSIONAL - INICIO
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Estabelecimento.secondaryColor
                                          .withOpacity(0.4)),
                                  child: Text("5"),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Selecione uma data",
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () {
                                ShowModalData();
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Estabelecimento.secondaryColor
                                      .withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 0.5,
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      dataSelectedInModal != null
                                          ? "${DateFormat("dd/MM/yyyy").format(dataSelectedInModal!)}"
                                          : "Escolha uma data",
                                      style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.calendar_today,
                                      size: 15,
                                      color: Colors.grey.shade500,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            //CONTAINER DA DATA - FIM
                            //CONTAINER DA HORA - INICIO
                            if (dataSelectedInModal != null)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Estabelecimento.secondaryColor
                                            .withOpacity(0.4)),
                                    child: Text("6"),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Selecione um horário",
                                    style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            if (dataSelectedInModal != null)
                              Container(
                                width: double.infinity,
                                //  height: heighScreen * 0.64,
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: horarioFinal.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 2.3,
                                    childAspectRatio: 2.3,
                                  ),
                                  itemBuilder: (BuildContext ctx, int index) {
                                    Color color = selectedIndex == index
                                        ? Colors.amber
                                        : Estabelecimento.primaryColor;
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = selectedIndex == index
                                              ? -1
                                              : index;

                                          hourSetForUser =
                                              horarioFinal[index].horario;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 3),
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft:
                                                  Radius.elliptical(20, 20),
                                              bottomRight:
                                                  Radius.elliptical(20, 20),
                                              topLeft:
                                                  Radius.elliptical(20, 20),
                                              topRight:
                                                  Radius.elliptical(20, 20),
                                            ),
                                            color: color,
                                          ),
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            "${horarioFinal[index].horario}",
                                            style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 15,
                                            )),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            //CONTAINER DA HORA - FIM
                            //botao do agendar - inicio

                            if (hourSetForUser != null)
                              InkWell(
                                onTap: CreateAgendamento,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Estabelecimento.primaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Agendar",
                                          style: GoogleFonts.openSans(
                                              textStyle: TextStyle(
                                            color: Estabelecimento
                                                .contraPrimaryColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          )),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: Estabelecimento
                                              .contraPrimaryColor,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            SizedBox(
                              height: 25,
                            ),
                            //botao do agendar - fim
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
