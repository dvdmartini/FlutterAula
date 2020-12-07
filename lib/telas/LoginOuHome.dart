import 'package:provider/provider.dart';

import '../providers/AutenticaModel.dart';
import 'package:flutter/material.dart';

 
import 'Login.dart';
import 'TabsView.dart';

class LoginOuHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    AutenticaModel autentica = Provider.of(context);
    return FutureBuilder(
      //future: autentica.tryAutoLogin(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.error != null) {
          return Center(child: Text('Ocorreu um erro!'));
        } else {
          return autentica.isAuth ? TabsView() : Login();
        }
      },
    );
  }
}
