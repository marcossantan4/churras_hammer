import 'dart:async';

import 'package:churras_hammer/card/CardLista.dart';
import 'package:churras_hammer/model/Participantes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListaParticipantes extends StatefulWidget {
  @override
  _ListaParticipantesState createState() => _ListaParticipantesState();
}

class _ListaParticipantesState extends State<ListaParticipantes> {

  final _controler = StreamController<QuerySnapshot>.broadcast();


  Future<Stream<QuerySnapshot>> _adicionarListenerParticipantes() async {

    Firestore db = Firestore.instance;
    Query query = db.collection("participantes");

    query = query.where("statusParticipacao", isEqualTo: "CONFIRMADO");

    Stream<QuerySnapshot> stream = query.snapshots();
    stream.listen((dados){
      _controler.add(dados);
    });

  }
  @override
  void initState() {
    super.initState();
    _adicionarListenerParticipantes();

  }

  @override
  Widget build(BuildContext context) {

    var carregandoDados = Center(
      child: Column(children: <Widget>[

        Text("Carregando participantes"),
        CircularProgressIndicator()

      ],),
    );

    return Scaffold(
        backgroundColor:  Color(0xFFF5F5F5),
        appBar: AppBar(
          title: Text("Participantes"),
          backgroundColor:  Color(0xFF23456E),
        ),
        body:Container(
          padding: EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Column(
            children: <Widget>[
              StreamBuilder(
                stream: _controler.stream,
                builder: (context, snapshot){
                  switch( snapshot.connectionState ){
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return carregandoDados;
                      break;
                    case ConnectionState.active:
                    case ConnectionState.done:

                      QuerySnapshot querySnapshot = snapshot.data;

                      if( querySnapshot.documents.length == 0 ){
                        return Container(
                          padding: EdgeInsets.all(25),
                          child: Text("Nenhum Participante :( ", style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),),
                        );
                      }

                      return Expanded(
                        child: ListView.builder(
                            itemCount: querySnapshot.documents.length,
                            itemBuilder: (_, indice){

                              List<DocumentSnapshot> anuncios = querySnapshot.documents.toList();
                              DocumentSnapshot documentSnapshot = anuncios[indice];
                              Participantes participantes = Participantes.fromDocumentSnapshot(documentSnapshot);

                              return Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: CardLista(
                                  participantes: participantes,
                                ),
                              );

                            }
                        ),
                      );

                  }
                  return Container();
                },
              ),
            ],
          ),
        )

    );
  }
}
