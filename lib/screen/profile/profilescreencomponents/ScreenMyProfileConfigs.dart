
import 'package:barbershop2/classes/Estabelecimento.dart';
import 'package:barbershop2/functions/userLogin.dart';
import 'package:barbershop2/rotas/Approutes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ScreenComponentsMyProfile extends StatefulWidget {
  const ScreenComponentsMyProfile({super.key});

  @override
  State<ScreenComponentsMyProfile> createState() =>
      _ScreenComponentsMyProfileState();
}

class _ScreenComponentsMyProfileState extends State<ScreenComponentsMyProfile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadUrlImageUserdb();
    userName;
    print("o username do cara é: ${userName}");
  }

  String? userName;
  Future<void> LoadUrlImageUserdb() async {
 //   String? descUser = await MyProfileScreenFunctions().getNameUser();

    setState(() {
 //     userName = descUser;
    });
  }

  final nomeControler = TextEditingController();
  final phoneNumberControler = TextEditingController();
  Future<void> setNameInControler() async {

    setState(() {
      nomeControler.text = userName ?? "Carregando...";
    });
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
              height: 300,
              color: Estabelecimento.primaryColor,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(50, 50),
                  topRight: Radius.elliptical(50, 50),
                ),
              ),
              width: widhScren,
              height: heighScreen / 1.5,
            ),
          ),
          Positioned(
            top: 120,
            right: 130,
            left: 130,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: Image.network(
                  "https://forbes.com.br/wp-content/uploads/2024/04/mark-zuckerberg-768x512.jpeg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 255,
            right: 40,
            left: 40,
            child: Container(
              padding: EdgeInsets.only(bottom: 10),
              width: double.infinity,
              height: heighScreen,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //inicio -> FORMULARIO COM O NOME
                  Text(
                    "Seu Nome",
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade800,
                    )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        width: 0.5,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: nomeControler,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.edit,
                          size: 20,
                          color: Estabelecimento.primaryColor,
                        ),
                      ],
                    ),
                  ),
                  //Fim -> FORMULARIO COM O NOME
                  SizedBox(
                    height: 10,
                  ),
                  //inicio -> FORMULARIO COM O TELEFONE
                  Text(
                    "Número WhatsApp",
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade800,
                    )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        width: 0.5,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: phoneNumberControler,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.edit,
                          size: 20,
                          color: Estabelecimento.primaryColor,
                        ),
                      ],
                    ),
                  ),
                  //Fim -> FORMULARIO COM O TELEFONE
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: (){
                      Provider.of<UserLoginApp>(context,listen: false).deslogar();
                      Navigator.of(context).pushReplacementNamed(AppRoutesApp.VerificationLoginScreen01);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Estabelecimento.primaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Deslogar",
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Estabelecimento.contraPrimaryColor,
                            )),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.logout,
                            size: 22,
                            color: Estabelecimento.contraPrimaryColor,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
