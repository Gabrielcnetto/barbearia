import 'package:barbershop2/classes/cortecClass.dart';
import 'package:barbershop2/functions/CorteProvider.dart';
import 'package:barbershop2/screen/home/home_components/StreamHaveItems.dart';
import 'package:barbershop2/screen/home/home_components/homeHeaderSemItens.dart';
import 'package:barbershop2/screen/home/home_components/home_noItenswithLoading.dart';
import 'package:barbershop2/screen/home/home_components/profissionaisList.dart';
import 'package:barbershop2/screen/home/home_components/promotionBanner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_components/header.dart';

class HomeOnlyWidgets extends StatefulWidget {
  const HomeOnlyWidgets({super.key});

  @override
  State<HomeOnlyWidgets> createState() => _HomeOnlyWidgetsState();
}

class _HomeOnlyWidgetsState extends State<HomeOnlyWidgets> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CorteProvider>(context, listen: false).userCortesTotal;
    print("carreguei a geral dos widgets home");
  }

  @override
  Widget build(BuildContext context) {
    double widhtTela = MediaQuery.of(context).size.width;
    double heighTela = MediaQuery.of(context).size.height;
    bool existList = Provider.of<CorteProvider>(context, listen: false)
                .userCortesTotal
                .length >=
            1
        ? true
        : false;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
               StreamHaveItens(
            
                 heighTela: heighTela,
                 widhTela: widhtTela,
               ),
          
            ProfissionaisList(
              heighScreen: heighTela,
              widhScreen: widhtTela,
            ),
            PromotionBannerComponents(
              widhtTela: widhtTela,
            ),
          ],
        ),
      ),
    );
  }
}
