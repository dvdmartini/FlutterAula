import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart';

class AutenticaModel extends ChangeNotifier {
  String _userId;
  String _token;

  bool get isAuth {
    return token != null;
  }

  String get userId {
    return isAuth ? _userId : null;
  }

  String get token {
    if (_token != null) {
      return _token;
    } else {
      return null;
    }
  }

  Future<void> registrar(String email, String password) async {
    return autenticar(email, password, "signUp");
  }

  Future<void> logar(String email, String password) async {
    return autenticar(email, password, "signInWithPassword");
  }

  Future<void> autenticar(String email, String senha, String funcao) async {
    final chaveApiKey = "AIzaSyCbuJXcbj27wXuRiiEOBBFXUYjLMAc1ssM";
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:${funcao}?key=${chaveApiKey}';

    final response = await post(
      url,
      body: json.encode({
        "email": email,
        "password": senha,
        "returnSecureToken": true,
      }),
    );

    final responseBody = json.decode(response.body);
    print(responseBody);
    if (responseBody["error"] != null) {
      throw Exception(responseBody['error']['message']);
    } else {
      _token = responseBody["idToken"];
      _userId = responseBody["localId"];

      notifyListeners();
    }

    return Future.value();
  }
}
