import 'package:barbershop2/classes/cortecClass.dart';
import 'package:barbershop2/functions/CorteProvider.dart';
import 'package:barbershop2/screen/home/home_components/header/header.dart';
import 'package:barbershop2/screen/home/home_components/header/homeHeaderSemItens.dart';
import 'package:barbershop2/screen/home/home_components/header/home_noItenswithLoading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StreamHaveItens extends StatefulWidget {
  final double widhTela;
  final double heighTela;

  const StreamHaveItens(
      {super.key, required this.heighTela, required this.widhTela});

  @override
  State<StreamHaveItens> createState() => _StreamHaveItensState();
}

class _StreamHaveItensState extends State<StreamHaveItens> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CorteProvider>(context, listen: false).loadHistoryCortes();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of<CorteProvider>(context, listen: true).cortesStream,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Home_noItensWithLoadin(
            heighTela: widget.heighTela,
            widhTela: widget.widhTela,
          );
        } else if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}');
        } else {
          final List<CorteClass>? cortes = snapshot.data;

          if (cortes != null && cortes.isNotEmpty) {
            // Se houver itens na lista, mostre o widget correspondente
            return HomePageHeader(
              heighTela: widget.heighTela,
              widhTela: widget.widhTela,
            );
          } else {
            // Se a lista estiver vazia, mostre o widget correspondente
            return HomeHeaderSemLista(
              heighTela: widget.heighTela,
              widhTela: widget.widhTela,
            );
          }
        }
      },
    );
  }
}
