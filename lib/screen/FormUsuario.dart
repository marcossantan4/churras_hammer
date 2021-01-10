import 'package:churras_hammer/configuracoes/Configuracoes.dart';
import 'package:churras_hammer/configuracoes/UsuarioFirebase.dart';
import 'package:churras_hammer/model/InputCustomizado.dart';
import 'package:churras_hammer/model/Participantes.dart';
import 'package:churras_hammer/model/Usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:validadores/Validador.dart';

class FormUsuario extends StatefulWidget {
  @override
  _FormUsuarioState createState() => _FormUsuarioState();
}

class _FormUsuarioState extends State<FormUsuario> {

  List<DropdownMenuItem<String>> _listaItensDropConvidados = List();
  String _itemSelecionadoConvidado;
  List<DropdownMenuItem<String>> _listaItensDropBebida = List();
  final _formKey = GlobalKey<FormState>();
  String _itemSelecionadoBebida;
  String _nomeUsuario = "";
  Usuario usuario;
  Participantes _participantes;
  double _valor = 00.00;
  Color _color = Color(0xFF06C572);
  String nomeButton = "CONFIRMAR";
  VoidCallback _funcaoBotao;
  bool boleanRadios1, boleanRadios2 = false;
  int selectRadio;


  setSelectRadio(int val){
    setState(() {
      selectRadio = val;
    });
  }

  _funcaoButton() async{
      setState(() {
        _color = Colors.red;
        nomeButton = "CANCELAR PARTICIPAÇÃO";
        _funcaoBotao = (){
          showDialog(
            context:  context,
            builder: (context){
              return AlertDialog(
                title: Text("Deseja realmente cancelar a participação?"),
                content: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          _removerParticipacaoConvidado();
                        },
                        child: Container(
                          width: double.infinity,
                          height: 30,
                          child: Center(
                            child: Text("CANCELAR CONVIDADO", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Color(0xFF23456E)
                            ),),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(width: 2)
                          ),
                        ),
                      ),
                      SizedBox(height: 8,
                      ),
                      GestureDetector(
                        onTap: (){
                          _removerParticipacao();
                        },
                        child: Container(
                          width: double.infinity,
                          child: Center(
                            child: Text("CANCELAR INSCRIÇÃO", style: TextStyle(
                            fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Color(0xFF23456E)
                          )),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                              border: Border.all(width: 2)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

          );
        };
      });
  }

  _removerParticipacaoConvidado() async{

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    String idUsuarioLogado = usuarioLogado.uid;
    var db = Firestore.instance;

    _mudarValor();

    Map<String, dynamic>  cancelarParticipacaoConvidado = {
      "statusConvidadoP": "nao",
      "nomeConvidado": "",
      "valor": _valor
    };

    db.collection("participantes")
        .document(idUsuarioLogado)
        .collection("minha_confirmacao")
        .document(_participantes.id)
        .updateData(cancelarParticipacaoConvidado)
        .then((_) {

      db.collection("participantes")
          .document(_participantes.id)
          .updateData(cancelarParticipacaoConvidado)
          .then((_) {
        setState(() {
          nomeButton = "CONFIRMAR";
          _color = Colors.green;
          _funcaoBotao = (){
            _confirmarParticipacao();
          };
        });
        Fluttertoast.showToast(
            msg: "Sucesso ao cancelar!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      });

    });


  }
  _removerParticipacao() async{

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    String idUsuarioLogado = usuarioLogado.uid;
    Firestore db = Firestore.instance;
    db.collection("participantes")
        .document( idUsuarioLogado )
        .collection("minha_confirmacao")
        .document( _participantes.id )
        .delete().then((_){

      db.collection("participantes")

          .document(_participantes.id)
          .delete();
      Navigator.pop(context);
      setState(() {
        nomeButton = "CONFIRMAR";
        _color = Colors.green;
        _funcaoBotao = (){
          _confirmarParticipacao();
        };
      });
      Fluttertoast.showToast(
          msg: "Sucesso ao cancelar!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );


    });
  }

  _mudarValor(){
    if(_participantes.statusConvidadoP == "sim" && _participantes.statusBebida == "sim") {
      setState(() {
        _valor = 40.00;
      });
    }
    if(_participantes.statusBebida == "nao" && _participantes.statusConvidadoP == "nao"){
        setState(() {
          _valor = 10.00;
        });
      } if(_participantes.statusBebida == "eu sim vou so" && _participantes.statusConvidadoP == "nao"){
      setState(() {
        _valor = 20.00;
      });
    } if( _participantes.statusBebida == "um sim" && _participantes.statusConvidadoP == "sim"){
      setState(() {
        _valor = 30.00;
      });
    }
  }
  _confirmarParticipacao() async{

      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseUser usuarioLogado = await auth.currentUser();
      String idUsuarioLogado = usuarioLogado.uid;
      var db = Firestore.instance;

      Map<String, dynamic>  confirmarParticipacao = {
        "statusParticipacao": "CONFIRMADO",
        "valor": _valor,
        "nomeParticipante": _nomeUsuario

      };
      Map<String, dynamic>  confirmarParticipacaoConvidado = {
        "statusEventoConvidado": "CONFIRMADO",
        "statusParticipacao": "CONFIRMADO",
        "nomeParticipante": _nomeUsuario,
        "valor": _valor,
        "nomeConvidado": _participantes.nomeConvidados
      };

      db = Firestore.instance;
      db.collection("participantes")
          .document(idUsuarioLogado)
          .collection("minha_confirmacao")
          .document(_participantes.id)
          .updateData(confirmarParticipacao)
          .then((_) {
        _funcaoButton();
        db.collection("participantes")
            .document(_participantes.id)
            .updateData(confirmarParticipacao).then((_){

          if(_participantes.statusConvidadoP == "nao"){

            db.collection("participantes")
                .document(idUsuarioLogado)
                .collection("minha_confirmacao")
                .document(_participantes.id)
                .updateData(confirmarParticipacaoConvidado)
                .then((_) {

              db.collection("participantes")
                  .document(_participantes.id)
                  .updateData(confirmarParticipacaoConvidado);
              _funcaoButton();
              Fluttertoast.showToast(
                  msg: "Sucesso ao confirmar!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
              );

            });
          }
        });
      });


  }

  _updateStatusParticipacao() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    String idUsuarioLogado = usuarioLogado.uid;
    var db = Firestore.instance;

    Map<String, dynamic> dadosAtualizar = {
      "statusParticipacao": "pendente",
      "statusEventoConvidado": "pendente",

    };

        db = Firestore.instance;
        db.collection("participantes")
        .document(idUsuarioLogado)
        .collection("minha_confirmacao")
        .document(_participantes.id)
        .updateData(dadosAtualizar)
        .then((_) {

          db.collection("participantes")
          .document(_participantes.id)
          .updateData(dadosAtualizar);
    });
  }

  _recuperarDadosDoUsuario() async {
    usuario = await UsuarioFirebase.getDadosUsuarioLogado();
    if (usuario != null) {
      setState(() {
        _nomeUsuario = "${usuario.nome}";
        _funcaoBotao = (){
          _confirmarParticipacao();
        };
      });
    }
  }

  _salvarParticipante() async {

    //Salvar participante no Firestore
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    String idUsuarioLogado = usuarioLogado.uid;

    Firestore db = Firestore.instance;
    db.collection("participantes")
        .document(idUsuarioLogado)
        .collection("minha_confirmacao")
        .document(_participantes.id)
        .setData(_participantes.toMap())
        .then((_) {
      //salvar em público
      db.collection("participantes")
          .document(_participantes.id)
          .setData(_participantes.toMap())
          .then((_) {
            _updateStatusParticipacao();
        _mudarValor();
      });
    });
  }



  @override
  void initState() {
    super.initState();
    _carregarItensDropdown();
    _participantes = Participantes.gerarId();
    _recuperarDadosDoUsuario();

  }

  _carregarItensDropdown() {
    _listaItensDropConvidados = Configuracoes.getConvidado();
    _listaItensDropBebida = Configuracoes.getBebida();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text("BEM VINDO!"),
        backgroundColor: Color(0xFF23456E),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 14),
                  child: Image.asset(
                    "images/logomarca.png",
                    width: 200,
                  ),
                ),
                Text(
                  "Para participar do evento, preencha todos os dados corretamente.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.white),
                        child: Center(
                          child: Text(
                            "Participante: ${_nomeUsuario}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 19),
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            child: Text(
                              "Levará um convidado?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: DropdownButtonFormField(
                                  value: _itemSelecionadoConvidado,
                                  items: _listaItensDropConvidados,
                                  onSaved: (convidado) {
                                    _participantes.statusConvidadoP = convidado;
                                  },
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                  validator: (valor) {
                                    return Validador()
                                        .add(Validar.OBRIGATORIO,
                                            msg: "Campo obrigatório")
                                        .valido(valor);
                                  },
                                  onChanged: (valor) {
                                    setState(() {
                                    });
                                  },
                                ),
                              ),
                            ),
                          ]),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            child: Text(
                              "Nome do convidado: (se houver)",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      InputCustomizado(
                        hint: "Nome do convidado",
                        onSaved: (nomeConvidado) {
                          _participantes.nomeConvidados = nomeConvidado;
                        },
                        maxLines: 1,
                        type: TextInputType.text,
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            child: Text(
                              "Vocês ingerem bebida alcoólica?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: DropdownButtonFormField(
                                  value: _itemSelecionadoBebida,
                                  onSaved: (bebida) {
                                    _participantes.statusBebida = bebida;
                                  },
                                  items: _listaItensDropBebida,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                  validator: (valor) {
                                    return Validador()
                                        .add(Validar.OBRIGATORIO,
                                            msg: "Campo obrigatório")
                                        .valido(valor);
                                  },
                                  onChanged: (valor) {
                                    setState(() {});
                                  }
                                ),

                              ),
                            ),
                          ]),
                      SizedBox(
                        height: 15,
                      ),
                      FlatButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            //salva campos
                            _formKey.currentState.save();
                           _salvarParticipante();

                          }
                        },
                        child: Text(
                          "CALCULAR VALOR",
                          style: TextStyle(
                              fontSize: 15, color: Colors.indigoAccent),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 25, bottom: 15),
                        child: Text(
                          "TOTAL A PAGAR",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xFF23456E)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: Text(
                          "R\$: ${_valor}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.red),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20, bottom: 3, left: 16, right: 16),
                            child: RaisedButton(
                                onPressed: _funcaoBotao,
                                color: _color,
                                child: Text(
                                  nomeButton,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
