
import 'package:cloud_firestore/cloud_firestore.dart';

class Participantes {

  String _id;
  String _nomeParticipante;
  String _nomeConvidados;
  String _statusEventoConvidado;
  String _statusParticipacao;
  String _statusConvidadoP;
  String _statusBebida;
  num _valor;

  Participantes();

  Participantes.fromDocumentSnapshot(DocumentSnapshot snapshot){
    this._id = snapshot.documentID;
    this._nomeParticipante = snapshot["nomeParticipante"];
    this._nomeConvidados = snapshot["nomeConvidado"];
    this._valor = snapshot["valor"] as num;
    this._statusEventoConvidado = snapshot["statusEventoConvidado"];
    this._statusParticipacao = snapshot["statusParticipacao"];
    this._statusConvidadoP = snapshot["statusConvidadoP"];
    this._statusBebida = snapshot["statusBebida"];
  }

  Participantes.gerarId(){

    Firestore db = Firestore.instance;
    CollectionReference participacao = db.collection("parcicipacoes");
    this.id = participacao.document().documentID;


  }


  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "id": this._id,
      "nomeParticipante": this.nomeParticipante,
      "nomeConvidado": this.nomeConvidados,
      "statusEventoConvidado": this.statusEventoConvidado,
      "statusParticipacao": this.statusParticipacao,
      "statusConvidadoP": this._statusConvidadoP,
      "valor": this.valor,
      "statusBebida": this._statusBebida
    };
    return map;
  }


  String get statusBebida => _statusBebida;

  set statusBebida(String value) {
    _statusBebida = value;
  }

  String get statusEventoConvidado => _statusEventoConvidado;

  set statusEventoConvidado(String value) {
    _statusEventoConvidado = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get nomeParticipante => _nomeParticipante;


  num get valor => _valor;

  set valor(num value) {
    _valor = value;
  }

  String get statusConvidadoP => _statusConvidadoP;

  set statusConvidadoP(String value) {
    _statusConvidadoP = value;
  }

  String get statusParticipacao => _statusParticipacao;

  set statusParticipacao(String value) {
    _statusParticipacao = value;
  }

  String get nomeConvidados => _nomeConvidados;

  set nomeConvidados(String value) {
    _nomeConvidados = value;
  }

  set nomeParticipante(String value) {
    _nomeParticipante = value;
  }
}