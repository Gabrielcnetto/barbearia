
import 'package:barbershop2/screen/home/home_components/profissionaisList.dart';
import 'package:barbershop2/screen/home/home_components/promotionBanner.dart';
import 'package:flutter/material.dart';

import 'home_components/header.dart';

class HomeOnlyWidgets extends StatelessWidget {
  const HomeOnlyWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final double widhtTela = MediaQuery.of(context).size.width;
    final double heighTela = MediaQuery.of(context).size.height;
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
