import 'package:flutter/material.dart';

class Tipo {
  final String id;
  final String titulo;
  final Color cor;
  final String imageName;

  const Tipo(
      {@required this.id, @required this.titulo, this.imageName = 'default.jpg', this.cor = Colors.grey});
}
