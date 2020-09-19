import 'package:flutter/material.dart';
import 'package:prova_dartora/cadastro.dart';
import 'package:prova_dartora/home.dart';
import 'package:prova_dartora/login.dart';
import 'package:prova_dartora/mensagens.dart';
import 'package:prova_dartora/model/conversa.dart';
import 'package:prova_dartora/telas/aba-conversas.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    final args = settings.arguments;

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => Login());
      case "/login":
        return MaterialPageRoute(builder: (_) => Login());
      case "/cadastro":
        return MaterialPageRoute(builder: (_) => Cadastro());
      case "/home":
        return MaterialPageRoute(builder: (_) => Home());
      case "/conversa":
        return MaterialPageRoute(builder: (_) => Mensagens(args));
      default:
        _erroRota();
    }
  }

  static Route<dynamic> _erroRota() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Tela não encontrada!"),
        ),
        body: Center(
          child: Text("Tela não encontrada!"),
        ),
      );
    });
  }
}
