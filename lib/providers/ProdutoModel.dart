import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../Produto.dart';

class ProdutoModel with ChangeNotifier {
  List<Produto> _listProduto = [];
  bool bTemBorda = false;

  String _token;
  String _userId;

  ProdutoModel([this._token, this._userId, this._listProduto = const []]) {
    carregaProdutos();
  }

  // retorna uma copia da lista
  List<Produto> get itens {
    List<Produto> _temp = []..addAll(_listProduto);

    if (bTemBorda) {
      aplicaFiltro(bTemBorda, _temp);
    }

    return _temp;
  }

  void aplicaFiltro(bool bTemBorda, List<Produto> _itens) {
    if (bTemBorda) {
      _itens = _listProduto.where((produto) {
        return produto.temBorda == true;
      }).toList();
    } else {
      _itens = _listProduto;
    }
  }

  Future<void> carregaProdutos() async {
    final response = await get(
        "https://aulaflutter-david-default-rtdb.firebaseio.com/produtos.json?auth=$_token");
    Map<String, dynamic> data = json.decode(response.body);

    _listProduto.clear();
    if (data != null) {
      data.forEach((idProduto, prodData) {
        var prod = Produto(
          id: idProduto,
          titulo: prodData['titulo'],
          descricao: prodData['descricao'],
          preco: prodData['preco'],
          tipoIds: []..add(prodData['tipoids']),
          imageUrl: prodData['imageUrl'],
        );
        _listProduto.add(prod);
      });
      notifyListeners();
    }
    return Future.value();
  }

  void adicionaItem(Produto prod) {
    // criar a requisição
    const url =
        'https://aulaflutter-david-default-rtdb.firebaseio.com/produtos.json';
    String jsonProduto = json.encode({
      'id': prod.id,
      'titulo': prod.titulo,
      'descricao': prod.descricao,
      'preco': prod.preco,
      'tipoids': prod.tipoIds[0],
      'imageUrl': prod.imageUrl,
    });

    // envia os dados para firebase
    post(url + "?auth=$_token", body: jsonProduto);

    _listProduto.add(Produto(
        id: Random().nextDouble().toString(),
        tipoIds: [prod.tipoIds[0]],
        titulo: prod.titulo,
        descricao: prod.descricao,
        preco: prod.preco,
        imageUrl: prod.imageUrl,
        temBorda: prod.temBorda));

    notifyListeners();
  }

  Future<void> atualiza(Produto prod) async {
    // verifica se foi informado valores
    if (prod == null || prod.id == null) {
      return;
    }
    final indice = _listProduto.indexWhere((p) => p.id == prod.id);
    if (indice >= 0) {
      // salva alterações no banco de dados
      await put(
        "https://aulaflutter-david-default-rtdb.firebaseio.com/produtos/${prod.id}.json?auth=$_token",
        body: json.encode({
          'titulo': prod.titulo,
          'descricao': prod.descricao,
          'preco': prod.preco,
          'tipoids': prod.tipoIds[0],
          'imageUrl': prod.imageUrl,
        }),
      );

      _listProduto[indice] = prod;
      notifyListeners();
    }
  }

  Future<void> excluir(String id) async {
    final index = _listProduto.indexWhere((prod) => prod.id == id);
    final produto = _listProduto[index];

    if (index >= 0) {
      _listProduto.removeWhere((prod) => prod.id == id);
      notifyListeners();

      final response = await delete(
          "https://aulaflutter-david-default-rtdb.firebaseio.com/produtos/${produto.id}.json?auth=$_token");

      if (response.statusCode >= 400) {
        _listProduto.insert(index, produto);
        notifyListeners();
        throw HttpException('Ocorreu um erro na exclusão do produto.');
      }
    }
  }
}
