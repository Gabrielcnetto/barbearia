import 'package:barbershop2/classes/Estabelecimento.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class RankingHome extends StatelessWidget {
  final double widhScreen;
  final double heighScreen;
  const RankingHome({
    super.key,
    required this.heighScreen,
    required this.widhScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
      child: Container(
        width: widhScreen,
        height: heighScreen * 0.65,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Ranking ${Estabelecimento.nomeLocal}",
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            //TOP 3 RANKING
            Stack(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  width: double.infinity,
                  height: heighScreen * 0.65,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      //AQUI O TOP 2
                      Container(
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: widhScreen / 3.5,
                              height: heighScreen * 0.325,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.elliptical(45, 45),
                                  topRight: Radius.elliptical(45, 45),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.2, right: 2, left: 2),
                              child: Container(
                                padding: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade500,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.elliptical(45, 45),
                                    bottomLeft: Radius.elliptical(45, 45),
                                    topRight: Radius.elliptical(45, 45),
                                    bottomRight: Radius.elliptical(45, 45),
                                  ),
                                ),
                                width: widhScreen / 3.8,
                                height: heighScreen * 0.14,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.elliptical(45, 45),
                                    bottomLeft: Radius.elliptical(45, 45),
                                    topRight: Radius.elliptical(45, 45),
                                    bottomRight: Radius.elliptical(45, 45),
                                  ),
                                  child: Image.network(
                                    "https://hips.hearstapps.com/hmg-prod/images/of-facebook-mark-zuckerberg-walks-to-lunch-following-a-news-photo-1683662107.jpg?crop=0.665xw:0.476xh;0.162xw,0.101xh&resize=1200:*",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 60,
                              child: Container(
                                alignment: Alignment.center,
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "2º",
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 105,
                              child: Column(
                                children: [
                                  Text(
                                    "Wellington",
                                    style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "14 Cortes",
                                    style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey.shade700,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      //FIM DO TOP 2
                      // INICIO DO TOP 1 (MID)
                      Container(
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: widhScreen / 3.5,
                              height: heighScreen * 0.35,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(251, 188, 0, 0.15),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.elliptical(45, 45),
                                  topRight: Radius.elliptical(45, 45),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.2, right: 2, left: 2),
                              child: Container(
                                padding: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(251, 188, 0, 1),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.elliptical(45, 45),
                                    bottomLeft: Radius.elliptical(45, 45),
                                    topRight: Radius.elliptical(45, 45),
                                    bottomRight: Radius.elliptical(45, 45),
                                  ),
                                ),
                                width: widhScreen / 3.8,
                                height: heighScreen * 0.14,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.elliptical(45, 45),
                                    bottomLeft: Radius.elliptical(45, 45),
                                    topRight: Radius.elliptical(45, 45),
                                    bottomRight: Radius.elliptical(45, 45),
                                  ),
                                  child: Image.network(
                                    "https://hips.hearstapps.com/hmg-prod/images/of-facebook-mark-zuckerberg-walks-to-lunch-following-a-news-photo-1683662107.jpg?crop=0.665xw:0.476xh;0.162xw,0.101xh&resize=1200:*",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 5,
                              child: Container(
                                alignment: Alignment.center,
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "1º",
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 5,
                              top: 1,
                              child: Container(
                                alignment: Alignment.center,
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(251, 188, 0, 1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  width: 17,
                                  height: 17,
                                  child: Image.asset(
                                    "imagesOfApp/coroa.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 105,
                              child: Column(
                                children: [
                                  Text(
                                    "Wellington",
                                    style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "14 Cortes",
                                    style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey.shade700,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      //FIM DO TOP 1 (MID)
                      //INICIO TOP 3
                      Container(
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: widhScreen / 3.5,
                              height: heighScreen * 0.3,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(177, 79, 50, 0.3),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.elliptical(45, 45),
                                  topRight: Radius.elliptical(45, 45),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.2, right: 2, left: 2),
                              child: Container(
                                padding: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(177, 79, 50, 1),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.elliptical(45, 45),
                                    bottomLeft: Radius.elliptical(45, 45),
                                    topRight: Radius.elliptical(45, 45),
                                    bottomRight: Radius.elliptical(45, 45),
                                  ),
                                ),
                                width: widhScreen / 3.8,
                                height: heighScreen * 0.14,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.elliptical(45, 45),
                                    bottomLeft: Radius.elliptical(45, 45),
                                    topRight: Radius.elliptical(45, 45),
                                    bottomRight: Radius.elliptical(45, 45),
                                  ),
                                  child: Image.network(
                                    "https://hips.hearstapps.com/hmg-prod/images/of-facebook-mark-zuckerberg-walks-to-lunch-following-a-news-photo-1683662107.jpg?crop=0.665xw:0.476xh;0.162xw,0.101xh&resize=1200:*",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 5,
                              top: 65,
                              child: Container(
                                alignment: Alignment.center,
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "3º",
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 105,
                              child: Column(
                                children: [
                                  Text(
                                    "Wellington",
                                    style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "14 Cortes",
                                    style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey.shade700,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      //FIM TOP 3
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Card(
                    elevation: 2,
                    child: Container(
                      width: double.infinity,
                      height: heighScreen * 0.2,
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
