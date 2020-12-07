import 'providers/AutenticaModel.dart';

import 'telas/LoginOuHome.dart';
import 'package:provider/provider.dart';

import 'Config.dart';
import 'providers/ProdutoModel.dart';
import 'providers/SelecionadoModel.dart';
import 'providers/TotalizaProvider.dart';
import 'telas/ConfiguracaoView.dart';
import 'telas/ProdutoCadastro.dart';
import 'telas/ProdutosView.dart';
import 'telas/ProdutoForm.dart';

import 'app_rotas.dart';
import 'telas/TabsView.dart';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Config config = new Config();
  //List<Produto> produtosDisponiveis = PRODUTOS_DADOS;
  //List<Produto> selecionados = [];

  void _aplicaConfiguracao(Config config) {
    setState(() {
      this.config = config;

/*
      produtosDisponiveis = PRODUTOS_DADOS.where((produto) {
        final filtraSalmao = config.temSalmao && produto.temSalmao;
        return filtraSalmao;
      }).toList();
*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AutenticaModel>.value(
          value: AutenticaModel(),
        ),
        //ChangeNotifierProvider<ProdutoModel>.value( value: ProdutoModel(), ),
        ChangeNotifierProvider<SelecionadoModel>.value(
          value: SelecionadoModel(),
        ),

        ChangeNotifierProxyProvider<AutenticaModel, ProdutoModel>(
          create: (_) => new ProdutoModel(),
          update: (ctx, auth, previousProducts) => new ProdutoModel(
            auth.token,
            auth.userId,
            previousProducts.itens,
          ),
        ),
      ],
      child: TotalizaProvider(
        child: MaterialApp(
          title: 'D&S Pizzaria',
          theme: ThemeData(
            primarySwatch: Colors.red,
            textSelectionColor: Colors.white,
            textTheme: ThemeData.light().textTheme.copyWith(
                caption: TextStyle(fontSize: 40, color: Colors.white)),
          ),
          //home: TabsView(),
          routes: {
            AppRotas.LOGIN: (ctx) => LoginOuHome(),
            AppRotas.HOME: (ctx) => TabsView(),
            AppRotas.PRODUTOS_VIEW: (ctx) => ProdutosView(),
            AppRotas.CONFIG: (ctx) =>
                ConfiguracaoView(this.config, _aplicaConfiguracao),
            AppRotas.PRODUTO_CADASTRO: (ctx) => ProdutoCadastro(),
            AppRotas.PRODUTO_FORM: (ctx) => ProdutoForm()
          },
        ),
      ),
    );
  }
}
