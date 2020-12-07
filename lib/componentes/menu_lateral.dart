import 'dart:io';

import '../app_rotas.dart';

import 'package:flutter/material.dart';

class MenuLateral extends StatelessWidget {
  // _navegaHome(BuildContext ctx) {

  //   Navigator.of(ctx).pushReplacement(
  //     MaterialPageRoute(builder: (ctx) {
  //       return TabsView();
  //     }),
  //   );
  // }

  // _navegaConfiguracao(BuildContext ctx) {
  //   Navigator.of(ctx).pushReplacement(
  //     MaterialPageRoute(builder: (ctx) {
  //       return ConfiguracaoView();
  //     }),
  //   );
  // }

  Widget _createItem(IconData icon, String label, Function onTap) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            alignment: Alignment.bottomRight,
            child: Text(
              'D&S Pizzaria Menu',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Theme.of(context).textTheme.caption.color,
              ),
            ),
          ),
          SizedBox(height: 20),
          _createItem(
            Icons.airplay,
            'Cardápio D&S Pizzaria',
            () => Navigator.of(context).pushReplacementNamed(AppRotas.HOME),
          ),
          _createItem(
            Icons.apps,
            'Produtos',
            () => Navigator.of(context).pushNamed(AppRotas.PRODUTO_CADASTRO),
          ),
          _createItem(
            Icons.settings,
            'Configurações',
            () => Navigator.of(context).pushReplacementNamed(AppRotas.CONFIG),
          ),
          _createItem(
            Icons.power_settings_new,
            'Logout',
            () => Navigator.of(context).pushReplacementNamed(AppRotas.LOGIN),
          ),
        ],
      ),
    );
  }
}
