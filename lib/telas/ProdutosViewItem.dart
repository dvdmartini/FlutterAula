import 'package:Cardapio/providers/SelecionadoModel.dart';

import 'package:provider/provider.dart';

import '../Produto.dart';
import 'package:flutter/material.dart';

class ProdutosViewItem extends StatelessWidget {
  final Produto produto;

  ProdutosViewItem(this.produto);

  @override
  Widget build(BuildContext context) {
    // utilizar abaixo para verificar se item já foi adicionado e mostrar o texto "Remove"
    bool foiAdicionado = Provider.of<SelecionadoModel>(context, listen: false)
        .foiAdicionado(produto);

    SelecionadoModel selecModel =
        Provider.of<SelecionadoModel>(context, listen: false);

    return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.network(produto.imageUrl,
                      height: 200, width: double.infinity, fit: BoxFit.cover),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                      color: Colors.black54,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        produto.titulo,
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                      width: (MediaQuery.of(context).size.width - 80) * 0.5,
                      child: Text(produto.descricao, softWrap: true)),
                  Text('R\$ ' + produto.preco.toStringAsFixed(2)),
                  RaisedButton(
                    color: Colors.red[400],
                    onPressed: () {
                      selecModel.adicionaItem(produto);
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Produto adicionado com sucesso",
                            style: TextStyle(fontSize: 20)),
                        duration: Duration(seconds: 3),
                        action: SnackBarAction(
                          label: 'Desfazer',
                          onPressed: () {
                            selecModel.removeItem(produto);
                          },
                        ),
                      ));
                    }, //this.adicionaItem( produto ),
                    child: Consumer<SelecionadoModel>(
                      builder: (context, value, child) =>
                          Provider.of<SelecionadoModel>(context, listen: false)
                                  .foiAdicionado(produto)
                              ? Text('Remover')
                              : Text('Adicionar'),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
