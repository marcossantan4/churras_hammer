
class Usuario {

  String _id;
  String _nome;
  String _email;
  String _senha;
  String _statusEvento;
  String _statusConvidado;
  String _valor;

  Usuario();

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "id": this.id,
      "nome" : this.nome,
      "email" : this.email,
    };
    return map;
  }


  String get valor => _valor;

  set valor(String value) {
    _valor = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get nome => _nome;

  String get statusConvidado => _statusConvidado;

  set statusConvidado(String value) {
    _statusConvidado = value;
  }

  String get statusEvento => _statusEvento;

  set statusEvento(String value) {
    _statusEvento = value;
  }

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  set nome(String value) {
    _nome = value;
  }
}