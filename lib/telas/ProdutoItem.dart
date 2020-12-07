import 'dart:io';

import '../Produto.dart';
import '../providers/ProdutoModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_rotas.dart';

class ProdutoItem extends StatelessWidget {
  Produto produto;

  ProdutoItem(this.produto);

  @override
  Widget build(BuildContext context) {

    final scaffold = Scaffold.of(context);

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(produto.imageUrl),
      ),
      title: Text(produto.titulo),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AppRotas.PRODUTO_FORM, arguments: produto);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () async {
                try {
                  await Provider.of<ProdutoModel>(context, listen: false).excluir(produto.id);                      
                } on HttpException catch (error) {
                    scaffold.showSnackBar(
                      SnackBar(
                        content: Text(error.toString()),
                      ),
                    );                  
                }                
              },
            ),
          ],
        ),
      ),
    );
  }
}
