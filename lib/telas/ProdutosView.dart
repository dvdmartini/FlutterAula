import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ProdutoModel.dart';
import '../Produto.dart';

import '../tipo.dart';
import 'ProdutosViewItem.dart';

class ProdutosView extends StatefulWidget {
  ProdutosView();

  @override
  _ProdutosViewState createState() => _ProdutosViewState();
}

class _ProdutosViewState extends State<ProdutosView> {

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<ProdutoModel>(context, listen: false).carregaProdutos().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final tipo = ModalRoute.of(context).settings.arguments as Tipo;

    List<Produto> listNovo =
        Provider.of<ProdutoModel>(context).itens.where((prod) {
      return prod.tipoIds.contains(tipo.id);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: listNovo.length,
              itemBuilder: (ctx, index) {
                return ProdutosViewItem(listNovo[index]);
              }),
    );
  }
}
