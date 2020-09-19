class Registro {
  String _idProtocolo;
  String _idUsuario;
  bool _febre;
  bool _diarreia;
  bool _coriza;
  bool _tosse;
  bool _espirro;
  double _temp;
  String descProblema;


  Registro();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "idUsuario": this._idUsuario,
      "febre": this.febre,
      "diarreia": this.diarreia,
      "coriza": this.coriza,
      "tosse": this.tosse,
      "espirro": this.espirro,
      "temp": this.temp,
      "descProblema": this.descProblema
    };
    return map;
  }


  String get idProtocolo => _idProtocolo;

  set idProtocolo(String value) {
    _idProtocolo = value;
  }


  String get idUsuario => _idUsuario;

  set idUsuario(String value) {
    _idUsuario = value;
  }

  bool get febre => _febre;

  set febre(bool value) {
    _febre = value;
  }

  bool get diarreia => _diarreia;

  double get temp => _temp;

  set temp(double value) {
    _temp = value;
  }

  bool get espirro => _espirro;

  set espirro(bool value) {
    _espirro = value;
  }

  bool get tosse => _tosse;

  set tosse(bool value) {
    _tosse = value;
  }

  bool get coriza => _coriza;

  set coriza(bool value) {
    _coriza = value;
  }

  set diarreia(bool value) {
    _diarreia = value;
  }
}