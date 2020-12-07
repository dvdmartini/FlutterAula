import 'package:flutter/material.dart';

import 'tipo.dart';

class Produto {
  final String id;
  final List<String> tipoIds;
  final String titulo;
  final String descricao;
  final double preco;
  final String imageUrl;

  final bool temBorda;

  const Produto(
      {this.id,
      @required this.tipoIds,
      @required this.titulo,
      this.descricao = "",
      this.preco = 0.0,
      this.imageUrl = "imagens/default.jpg",
      this.temBorda = true});
}
