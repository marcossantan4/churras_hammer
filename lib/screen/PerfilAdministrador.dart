import 'package:churras_hammer/model/DadosAdministrador.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Home.dart';
import 'Login.dart';
import 'MenuAdm.dart';

class PerfilAdministrador extends StatefulWidget {
  @override
  _PerfilAdministradorState createState() => _PerfilAdministradorState();
}

class _PerfilAdministradorState extends State<PerfilAdministrador> {

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
      drawer: MenuAdm(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor:   Color(0xFF23456E),
        title: Text("PERFIL ADMINISTRADOR", style: TextStyle(
            color: Colors.white,
        ),),
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
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 15, top: 20),
                child: Image.asset("images/logomarca.png", width: 200,),

              ),
              DadosAdm(nome1: "VALOR TOTAL:", dados1: "R\$: 00.00", nome2: "PARTICIPANTES", dados2: "0",),
              SizedBox(height: 20,),
              DadosAdm(nome1: "TOTAL GASTO:", dados1: "R\$: 00.00", nome2: "CONVIDADOS", dados2: "0",),
              SizedBox(height: 20,),
              DadosAdm(nome1: "GASTO COMIDA:", dados1: "R\$: 00.00", nome2: "GASTO BEBIDAS", dados2: "R\$: 00.00",)
            ],
          ),
        ),
      ),
    );
  }
}
