import 'package:Cardapio/app_rotas.dart';
import '../componentes/menu_lateral.dart';
import '../providers/ProdutoModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ProdutoItem.dart';

class ProdutoCadastro extends StatelessWidget {
  Future<void> _atualizaProdutos(BuildContext context) {
    return Provider.of<ProdutoModel>(context, listen: false).carregaProdutos();
  }

  @override
  Widget build(BuildContext context) {
    final listProdutos = Provider.of<ProdutoModel>(context).itens.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Produtos"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRotas.PRODUTO_FORM);
            },
          )
        ],
      ),
      drawer: MenuLateral(),
      body: RefreshIndicator(
          onRefresh: () => _atualizaProdutos(context),
          child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: listProdutos.length,
            itemBuilder: (ctx, i) => Column(
              children: <Widget>[
                ProdutoItem(listProdutos[i]),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
