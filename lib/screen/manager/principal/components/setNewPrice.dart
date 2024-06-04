import 'package:barbershop2/classes/Estabelecimento.dart';
import 'package:barbershop2/functions/managerScreenFunctions.dart';
import 'package:barbershop2/rotas/Approutes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SetNewPrice extends StatefulWidget {
  const SetNewPrice({super.key});

  @override
  State<SetNewPrice> createState() => _SetNewPriceState();
}

class _SetNewPriceState extends State<SetNewPrice> {
  final newpriceControler = TextEditingController();
  @override
  void initState() {
    super.initState();
    LoadPrice();
    newpriceControler.addListener(() {
      if (newpriceControler.text.length == 2) {
        // Fecha o teclado após 2 caracteres
        FocusScope.of(context).requestFocus(FocusNode());
      }
    });
  }

  @override
  void dispose() {
    // Limpa o controlador ao descartar o widget para evitar vazamentos de memória
    newpriceControler.dispose();
    super.dispose();
  }

  void showDialogAndSubmit() {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Atualizar o preço?"),
            content:
                Text("Este valor é exibido após o cliente agendar um horário"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancelar",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w300, color: Colors.grey),
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  int intvalue = int.tryParse(newpriceControler.text) ?? 0;
                  Provider.of<ManagerScreenFunctions>(context, listen: false)
                      .setNewprice(newprice: intvalue);
                  Navigator.of(context)
                      .pushReplacementNamed(AppRoutesApp.ManagerScreenView);
                },
                child: Text(
                  "Salvar preço",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.black),
                  ),
                ),
              ),
            ],
          );
        });
  }

  int? atualPrice;

  Future<void> LoadPrice() async {
    int? priceDB = await ManagerScreenFunctions().getPriceCorte();
    print("pegamos a data do databse");

    setState(() {
      atualPrice = priceDB!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 20,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.97,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //INICIO ATUALIZE O PRECO
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Atualize o preço do Estabelecimento e porcentagem dos funcionários.",
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Configure o preço dos cortes",
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.black45),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                //preco cabelo - inicio

                Row(
                  children: [
                    Text(
                      "Preço Atual:",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "R\$${atualPrice ?? 0}",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black38,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Preço novo:",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "R\$",
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black38,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          alignment: Alignment.topCenter,
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: 50,
                          child: Flexible(
                            child: TextFormField(
                              controller: newpriceControler,
                              textAlignVertical: TextAlignVertical.top,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              decoration: InputDecoration(
                                constraints: BoxConstraints(
                                  maxHeight: 30,
                                  minHeight: 30,
                                ),
                                border: InputBorder.none,
                              ),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                //cabelo fim
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 2,
                  decoration: BoxDecoration(color: Colors.grey.shade300),
                ),
                SizedBox(
                  height: 10,
                ),
                //barba inicio
                Text(
                  "Valor Adicional barba",
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.black45),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Preço Atual:",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "R\$${atualPrice ?? 0}",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black38,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Preço novo:",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "R\$",
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black38,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          alignment: Alignment.topCenter,
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: 50,
                          child: Flexible(
                            child: TextFormField(
                              controller: newpriceControler,
                              textAlignVertical: TextAlignVertical.top,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              decoration: InputDecoration(
                                constraints: BoxConstraints(
                                  maxHeight: 30,
                                  minHeight: 30,
                                ),
                                border: InputBorder.none,
                              ),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                //barba fim
              ],
            ),
            //FIM DO ATUALIZACAO DO PRECO
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 2,
              decoration: BoxDecoration(color: Colors.grey.shade300),
            ),
            SizedBox(
              height: 20,
            ),
            //INICIO ATUALIZACAO %
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Configure a porcentagem dos funcionários",
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.black45),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Porcentagem Atual:",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "%${atualPrice ?? 0}",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black38,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Porcentagem nova:",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "R\$",
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black38,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          alignment: Alignment.topCenter,
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: 50,
                          child: Flexible(
                            child: TextFormField(
                              controller: newpriceControler,
                              textAlignVertical: TextAlignVertical.top,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              decoration: InputDecoration(
                                constraints: BoxConstraints(
                                  maxHeight: 30,
                                  minHeight: 30,
                                ),
                                border: InputBorder.none,
                              ),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: showDialogAndSubmit,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Estabelecimento.primaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      "Atualizar Preço",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Estabelecimento.contraPrimaryColor),
                      ),
                    ),
                  ),
                ),
                //FIM DO PRECO
              ],
            ),
          ],
        ),
      ),
    );
  }
}
