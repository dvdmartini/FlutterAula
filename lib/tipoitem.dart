import 'app_rotas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'tipo.dart';

class TipoItem extends StatelessWidget {
  final Tipo tipo;

  TipoItem(this.tipo);

  _selecionaTipo(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      AppRotas.PRODUTOS_VIEW,
      arguments: tipo,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selecionaTipo(context),
      splashColor: Colors.red,
      child: Container(
          child: Card(
              elevation: 5,
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'images/${tipo.imageName}',
                    fit: BoxFit.cover,
                  ),
                  Text(tipo.titulo)
                ],
              ))),
    );
  }
}
