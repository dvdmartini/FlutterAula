import '../providers/ProdutoModel.dart';
import 'package:provider/provider.dart';

import '../componentes/menu_lateral.dart';
import 'package:flutter/material.dart';

import '../Config.dart';

class ConfiguracaoView extends StatefulWidget {
  final Config config;
  final Function(Config) quandoConfigMudou;

  const ConfiguracaoView(this.config, this.quandoConfigMudou);

  @override
  _ConfiguracaoViewState createState() => _ConfiguracaoViewState();
}

class _ConfiguracaoViewState extends State<ConfiguracaoView> {
  Config config;

  @override
  void initState() {
    super.initState();
    config = widget.config;
  }

  Widget _createSwitch(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile.adaptive(
        title: Text(title),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.black),
        ),
        value: value,
        onChanged: (value) {
          onChanged(value);
          widget.quandoConfigMudou(config);
        });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ProdutoModel>(context).bTemBorda = config.temBorda;

    return Scaffold(
      appBar: AppBar(title: Text("Configurações")),
      drawer: MenuLateral(),
      body: Column(children: <Widget>[
        Container(
          color: Colors.red,
          padding: EdgeInsets.all(20),
          child: Text(
            'Configurações',
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              _createSwitch(
                'Tem Borda',
                'Só exibe produtos que tenham borda!',
                config.temBorda,
                (value) => setState(() => config.temBorda = value),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
