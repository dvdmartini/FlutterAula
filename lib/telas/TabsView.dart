import '../componentes/menu_lateral.dart';
import 'package:flutter/material.dart';

import 'Home.dart';
import 'SelecaoView.dart';

class TabsView extends StatefulWidget {
  //final List<Produto> selecionados;
  //final Function(Produto) adicionaItem;
  //final bool Function(Produto) foiAdicionado;

  const TabsView();

  @override
  _TabsViewState createState() => _TabsViewState();
}

class _TabsViewState extends State<TabsView> {
  int _selecionadoIndice = 0;

  List<Widget> listTelas;

  @override
  void initState() {
    super.initState();
    listTelas = [Home(), SelecaoView()];
  }

  _selecionaTela(int indice) {
    setState(() {
      _selecionadoIndice = indice;
    });
  }

  @override
  Widget build(BuildContext context) {
    //TotalizaProvider.of(context).total = widget.selecionados.length;

    return Scaffold(
      appBar: AppBar(
        title: Text("D&S Pizzaria"),
      ),
      drawer: MenuLateral(),
      body: listTelas[_selecionadoIndice],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.black,
          currentIndex: _selecionadoIndice,
          onTap: _selecionaTela,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.apps), title: Text("Cardápio")),
            BottomNavigationBarItem(
                icon: Icon(Icons.apps), title: Text("Meu Pedido")),
          ]),

      /*
      floatingActionButton: FloatingActionButton(
        child:  Consumer<SelecionadoModel>( 
        builder: (ctx, provider, _) => 
            Text(provider.getTotalItens().toString()) 
        ),                
        onPressed: () => { } ,
      ),
      */
    );
  }
}
