import 'package:flutter/material.dart';

class TotalizaProvider extends InheritedWidget {
  
  int total = 0;
  TotalizaProvider({Widget child}) : super(child: child);

  static TotalizaProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TotalizaProvider>();
  }
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}
