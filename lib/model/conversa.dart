class Conversa {
  String _nome;
  String _mensagem;
  String _caminhoImagem;
  String _idUsuario;

  Conversa();

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }


  String get idUsuario => _idUsuario;

  set idUsuario(String value) {
    _idUsuario = value;
  }

  String get mensagem => _mensagem;

  set mensagem(String value) {
    _mensagem = value;
  }

  String get caminhoImagem => _caminhoImagem;

  set caminhoImagem(String value) {
    _caminhoImagem = value;
  }
}
