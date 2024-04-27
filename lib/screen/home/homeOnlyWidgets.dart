import 'package:barbershop2/functions/CorteProvider.dart';
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
    Provider.of<CorteProvider>(context,listen:false).userCortesTotal;
  }
  @override
  Widget build(BuildContext context) {
    double widhtTela = MediaQuery.of(context).size.width;
    double heighTela = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomePageHeader(
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
