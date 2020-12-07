import '../providers/SelecionadoModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/TotalizaProvider.dart';
import '../tipoitem.dart';
import '../dados.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Card(
          child: Container(
            color: Colors.red[300],
            child: Text(
              'Cardápio D&S Pizzaria',
              style: Theme.of(context)
                  .textTheme
                  .caption, //TextStyle(fontSize: 40, color: Colors.white),
            ),
          ),
        ),
        Expanded(
          child: GridView(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            children: TIPOS_PRODUTOS.map((t) {
              return TipoItem(t);
            }).toList(),
          ),
        ),
        Container(
          // child: Text("produtos selecionados: " + TotalizaProvider.of(context).total.toString(),
          child: Text(
              "Total: " +
                  Provider.of<SelecionadoModel>(context)
                      .getValorTotal()
                      .toStringAsFixed(2),
              style: TextStyle(fontSize: 30, color: Colors.black)),
        )
      ],
    ));
  }
}
