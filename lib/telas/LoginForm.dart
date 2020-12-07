import 'package:Cardapio/providers/AutenticaModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthMode { Registrar, Login }

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> _form = GlobalKey();
  bool _isLoading = false;

  AuthMode _authMode = AuthMode.Login;
  final _passwordController = TextEditingController();

  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Ocorreu um erro!'),
        content: Text(msg),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Fechar'),
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_form.currentState.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    _form.currentState.save();

    AutenticaModel autentica = Provider.of(context, listen: false);

    try {
      if (_authMode == AuthMode.Registrar) {
        await autentica.registrar(_authData["email"], _authData["password"]);
      } else {
        await autentica.logar(_authData["email"], _authData["password"]);
      }
    } on Exception catch (error) {
      _showErrorDialog(error.toString());
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Registrar;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        height: _authMode == AuthMode.Login ? 290 : 371,
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty || !value.contains('@')) {
                    return "Informe um e-mail válido!";
                  }
                  return null;
                },
                onSaved: (value) => _authData['email'] = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Senha'),
                controller: _passwordController,
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty || value.length < 5) {
                    return "Informe uma senha válida!";
                  }
                  return null;
                },
                onSaved: (value) => _authData['password'] = value,
              ),
              (_authMode == AuthMode.Registrar)
                  ? TextFormField(
                      decoration: InputDecoration(labelText: 'Confirmar Senha'),
                      obscureText: true,
                      validator: _authMode == AuthMode.Registrar
                          ? (value) {
                              if (value != _passwordController.text) {
                                return "Senha são diferentes!";
                              }
                              return null;
                            }
                          : null,
                    )
                  : Spacer(),
              Spacer(),
              (_isLoading)
                  ? CircularProgressIndicator()
                  : RaisedButton(
                      color: Colors.red[800],
                      textColor:
                          Theme.of(context).primaryTextTheme.button.color,
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 8.0,
                      ),
                      child: Text(
                        _authMode == AuthMode.Login ? 'ENTRAR' : 'REGISTRAR',
                      ),
                      onPressed: _submit,
                    ),
              FlatButton(
                onPressed: _switchAuthMode,
                child: Text(
                  "ALTERNAR P/ ${_authMode == AuthMode.Login ? 'REGISTRAR' : 'LOGIN'}",
                ),
                textColor: Colors.red[900],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
