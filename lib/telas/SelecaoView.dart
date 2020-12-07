import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/SelecionadoModel.dart';
import '../Produto.dart';
import '../telas/SelecaoItemView.dart';

class SelecaoView extends StatefulWidget {
  SelecaoView();

  @override
  _SelecaoViewState createState() => _SelecaoViewState();
}

class _SelecaoViewState extends State<SelecaoView> {
  @override
  Widget build(BuildContext context) {
    List<Produto> _listSelecionados =
        Provider.of<SelecionadoModel>(context).itens.toList();

    if (_listSelecionados.isEmpty) {
      return Center(
        child: Text('Nenhum produto selecionado!'),
      );
    } else {
      return ListView.builder(
        itemCount: _listSelecionados.length,
        itemBuilder: (ctx, index) {
          return SelecaoItemView(_listSelecionados[index]);
        },
      );
    }
  }
}
