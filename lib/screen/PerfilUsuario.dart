import 'package:churras_hammer/model/InterfacePerfilU.dart';
import 'package:churras_hammer/screen/FormUsuario.dart';
import 'package:churras_hammer/screen/Informacao.dart';
import 'package:churras_hammer/screen/MeuLocal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Home.dart';
import 'Login.dart';

class PerfilUsuario extends StatefulWidget {
  @override
  _PerfilUsuarioState createState() => _PerfilUsuarioState();
}

class _PerfilUsuarioState extends State<PerfilUsuario> {

  List<String> itensMenu = [];

  _escolhaMenuItem(String itemEscolhido) {
    switch (itemEscolhido) {
      case "Entrar":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
        break;
      case "Deslogar":
        _deslogarUsuario();
        Fluttertoast.showToast(
            msg: "Sucesso ao deslogar",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

        break;
    }
  }



  Future _verificaUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await auth.currentUser();

    if (firebaseUser == null) {
      itensMenu = [
        "Entrar"
      ];
    } else {
      itensMenu = [
        "Deslogar"
      ];
    }
  }

  _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  void initState() {
    super.initState();
    _verificaUsuarioLogado();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text("BEM VINDO!"),
        backgroundColor:  Color(0xFF23456E),
        leading: GestureDetector(
          onTap: (){},
            child: Text("")),
        actions: [
          PopupMenuButton<String>(
            onSelected: _escolhaMenuItem,
            itemBuilder: (context){
              return itensMenu.map((String item){
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 40),
                child: Image.asset("images/logomarca.png", width: 220,),
              ),
              InterfacePerfilU(nome: "INFORMAÇÕES", imagem: "images/info.png",
                funcao:()=> Navigator.push(context, MaterialPageRoute(builder: (context) => Informacao())) ,),
              SizedBox(height: 20,),
              InterfacePerfilU(nome: "PARTICIPAR", imagem: "images/cadastro.png",
                funcao: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => FormUsuario())),),
              SizedBox(height: 20,),
              InterfacePerfilU(nome: "LOCAL EVENTO", imagem: "images/mapa.png",
                  funcao: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => MeuLocal())),),
              SizedBox(height: 30,),
              Image.asset("images/hammer.png", width: 170,)


            ],
          ),
        ),
      ),
    );
  }
}
