import 'package:flutter/material.dart';

import '../Produto.dart';
import '../dados.dart';

class SelecionadoModel with ChangeNotifier {
  List<Produto> _selecionados = [];

  // retorna uma copia da lista
  List<Produto> get itens {
    return []..addAll(_selecionados);
  }

  int getTotalItens() {
    return _selecionados.length;
  }

  double getValorTotal() {
    double total = 0;
    _selecionados.forEach((prod) {
      total += prod.preco;
    });
    return total;
  }

  void removeItem(Produto produto) {
    if (_selecionados.contains(produto)) {
      _selecionados.remove(produto);
    }
    notifyListeners();
  }

  void adicionaItem(Produto produto) {
    if (_selecionados.contains(produto) == false) {
      _selecionados.add(produto);
    } else {
      _selecionados.remove(produto);
    }

    // atualiza os componentes que consomem a lista de selecionados
    notifyListeners();
  }

  bool foiAdicionado(Produto item) {
    return _selecionados.contains(item);
  }
}
