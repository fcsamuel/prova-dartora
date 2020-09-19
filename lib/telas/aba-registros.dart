import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prova_dartora/model/registro.dart';

class AbaRegistros extends StatefulWidget {
  @override
  _AbaRegistrosState createState() => _AbaRegistrosState();
}

class _AbaRegistrosState extends State<AbaRegistros> {
  String _idUsuarioLogado;
  String _emailUsuarioLogado;
  String _sintomas = "";

  Future<List<Registro>> _recuperarLaudos() async {
    Firestore db = Firestore.instance;

    QuerySnapshot querySnapshot =
    await db.collection("registros").getDocuments();

    List<Registro> listaLaudos = List();
    for (DocumentSnapshot item in querySnapshot.documents) {
      _sintomas = "";
      var dados = item.data;
      if (dados["idUsuario"] == _idUsuarioLogado) {
        Registro reg = Registro();
        reg.idProtocolo = item.documentID;
        reg.descProblema = dados["descProblema"];
        reg.febre = dados["febre"];
        reg.espirro = dados["espirro"];
        reg.diarreia = dados["diarreia"];
        reg.coriza = dados["coriza"];
        reg.temp = dados["temp"];
        _carregaSintomas(reg);
        listaLaudos.add(reg);
      }
    }
    return listaLaudos;
  }

  _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    _idUsuarioLogado = usuarioLogado.uid;
    _emailUsuarioLogado = usuarioLogado.email;
  }

  _carregaSintomas(Registro reg) {
    _sintomas = "Sintomas: ";
    if (reg.febre) {
      _sintomas += "febre |";
      if (reg.coriza) {
        _sintomas += " coriza |";
        if (reg.diarreia) {
          _sintomas += " diarreia |";
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Registro>>(
      future: _recuperarLaudos(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Column(
                children: <Widget>[
                  Text("Carregando Registros"),
                  CircularProgressIndicator()
                ],
              ),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, indice) {
                  List<Registro> listaItens = snapshot.data;
                  Registro reg = listaItens[indice];

                  return ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, "/detalhes",
                          arguments: reg);
                    },
                    contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    title: Text(
                      reg.descProblema,
                      style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                    ),
                    subtitle: Text(
                      _sintomas,
                      style: TextStyle(fontSize: 12),
                    ),
                  );
                });
            break;
        }
      },
    );
  }
}
