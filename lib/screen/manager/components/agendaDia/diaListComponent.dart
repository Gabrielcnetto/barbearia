import 'package:barbershop2/classes/cortecClass.dart';
import 'package:barbershop2/classes/horarios.dart';
import 'package:barbershop2/functions/CorteProvider.dart';
import 'package:barbershop2/screen/manager/components/agendaDia/itemComponentHour.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiaListaComponent extends StatefulWidget {
  
  const DiaListaComponent({
  
    super.key,
  });

  @override
  State<DiaListaComponent> createState() => _DiaListaComponentState();
}

class _DiaListaComponentState extends State<DiaListaComponent> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCortesAtualDayForManager();

  }

 

  Future<void> loadCortesAtualDayForManager() async {
    print("Entrei na funcao do load Manager Widget");
    Provider.of<CorteProvider>(context, listen: false)
        .loadHistoryCortesManagerScreen();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Provider.of<CorteProvider>(context, listen: false)
            .CorteslistaManager,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LinearProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text("Erro: ${snapshot.error}");
          } else {
            final List<CorteClass>? cortes = snapshot.data;
            if (cortes != null) {
              return Column(
                children: cortes.map((corte) {
                  return ItemComponentHour(
                    key: Key(corte.id),
                    Corte: corte,
                   
                  );
                }).toList(),
              );
            }
          }
          return Container();
        });
  }
}
