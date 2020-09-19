import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prova_dartora/model/registro.dart';
import 'package:prova_dartora/model/usuario.dart';

class AbaSintomas extends StatefulWidget {
  @override
  _AbaSintomasState createState() => _AbaSintomasState();
}

class _AbaSintomasState extends State<AbaSintomas> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _febre = false;
  bool _diarreia = false;
  bool _coriza = false;
  bool _tosse = false;
  bool _espirro = false;

  TextEditingController _controllerRegistro = TextEditingController();

  TextEditingController _controllerDescrProblema = new TextEditingController();
  double _temp = 30;
  String _result = "";



  _validaCampos() async {
    String _descProblema = _controllerDescrProblema.text.toString();
    if (_descProblema.isNotEmpty) {
      FirebaseUser userLogado = await auth.currentUser();
      Registro reg = new Registro();
      reg.idUsuario = userLogado.uid;
      reg.febre = _febre;
      reg.coriza = _coriza;
      reg.diarreia = _diarreia;
      reg.tosse = _tosse;
      reg.espirro = _espirro;
      reg.temp = _temp;
      reg.descProblema = _descProblema;
      //saveLog(reg);
      _salvarRegistro(reg);
    } else {
      _result = "Informe a descrição dos sintomas!";
    }
  }

  void saveLog(Registro reg) {
    print(
          "idProtocolo: " + reg.idProtocolo
          + " | idUsuario: " + reg.idUsuario
          + " | febre: " + reg.febre.toString()
          + " | coriza: " + reg.coriza.toString()
          + " | diarreia: " + reg.diarreia.toString()
          + " | tosse: " + reg.tosse.toString()
          + " | tosse: " + reg.tosse.toString()
          + " | espirro: " + reg.espirro.toString()
    );
  }

  _limpaCampos() {
    _febre = false;
    _diarreia = false;
    _coriza = false;
    _tosse = false;
    _espirro = false;
    _controllerDescrProblema.text = "";
    _temp = 30;
  }

  _salvarRegistro(Registro reg) async {
    Firestore db = Firestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    await db.collection("registros")
            .document(reg.idProtocolo)
            .setData(reg.toMap());
    _controllerRegistro.clear();
    _limpaCampos(); 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CheckboxListTile(
                    title: Text("Febre"),
                    activeColor: Color(0xff800000),
                    value: _febre,
                    onChanged: (bool valor) {
                      setState(() {
                        _febre = valor;
                      });
                    }),
                CheckboxListTile(
                    title: Text("Diarréia"),
                    activeColor: Color(0xff800000),
                    value: _diarreia,
                    onChanged: (bool valor) {
                      setState(() {
                        _diarreia = valor;
                      });
                    }),
                CheckboxListTile(
                    title: Text("Coriza"),
                    activeColor: Color(0xff800000),
                    value: _coriza,
                    onChanged: (bool valor) {
                      setState(() {
                        _coriza = valor;
                      });
                    }),
                CheckboxListTile(
                    title: Text("Tosse"),
                    activeColor: Color(0xff800000),
                    value: _tosse,
                    onChanged: (bool valor) {
                      setState(() {
                        _tosse = valor;
                      });
                    }),
                CheckboxListTile(
                    title: Text("Espirro"),
                    activeColor: Color(0xff800000),
                    value: _espirro,
                    onChanged: (bool valor) {
                      setState(() {
                        _espirro = valor;
                      });
                    }),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextFormField(
                    controller: _controllerDescrProblema,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Descrição",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                Slider(
                    value: _temp,
                    min: 30,
                    max: 50,
                    label: _temp.toStringAsPrecision(3),
                    divisions: 100,
                    activeColor: Color(0xff800000),
                    inactiveColor: Color(0xffFA8072),
                    onChanged: (double temp){
                      setState(() {
                        _temp = temp;
                      });
                    }),
                Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 16),
                  child: RaisedButton(
                      child: Text(
                        "Registrar",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Colors.red,
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      onPressed: () {
                        _validaCampos();
                      }),
                ),
                Center(
                  child: Text(
                    _result,
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
