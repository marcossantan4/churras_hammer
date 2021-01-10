import 'package:churras_hammer/model/Usuario.dart';

import 'package:churras_hammer/screen/PerfilAdministrador.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddUsuario extends StatefulWidget {
  @override
  _AddUsuarioState createState() => _AddUsuarioState();
}

class _AddUsuarioState extends State<AddUsuario> {

  TextEditingController _controllerNomeC = TextEditingController();
  TextEditingController _controllerEmailC = TextEditingController();
  TextEditingController _controllerSenhaC = TextEditingController();
  String msgerro = "";


  _cadastro(){

    String email = _controllerEmailC.text;
    String nome = _controllerNomeC.text;
    String senha = _controllerSenhaC.text;


    if(nome.isNotEmpty && nome.length > 3){
      if(email.isNotEmpty && email.contains('@')){
        if(senha.isNotEmpty && senha.length > 6){

          Usuario usuario = Usuario();
          usuario.nome = nome;
          usuario.email = email;
          usuario.senha = senha;



          _cadastrarUsuario(usuario);

        }else{
          setState(() {
            msgerro = "Preencha uma senha segura de até 6 caracteres";

          });
        }
      }else{
        setState(() {
          msgerro = "Preencha corretamente o campo E-mail";
        });
      }
    }else{
      setState(() {
        msgerro = "Preencha um nome válido";
      });

    }
  }

  _cadastrarUsuario(Usuario usuario){

    Firestore db = Firestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.createUserWithEmailAndPassword(email: usuario.email, password: usuario.senha).then((firebaseUser){

      db.collection("usuarios").document(firebaseUser.uid).setData(usuario.toMap());

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PerfilAdministrador()));

      Fluttertoast.showToast(
          msg: "Sucesso ao cadastrar!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }).catchError((onError){
      setState(() {
        msgerro = "Erro ao cadastrar usuario";

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text('Cadastro'),
        backgroundColor: Color(0xFF23456E),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("images/logomarca.png", width: 180,),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 8),
                child: TextField(
                  controller: _controllerNomeC,
                  keyboardType: TextInputType.text,
                  autofocus: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Nome Completo',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only( left: 16, right: 16, bottom: 8),
                child: TextField(
                  controller: _controllerEmailC,
                  keyboardType: TextInputType.emailAddress,
                  autofocus: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'E-mail',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ),
              ),Padding(
                padding: EdgeInsets.only( left: 16, right: 16, bottom: 8),
                child: TextField(
                  controller: _controllerSenhaC,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  autofocus: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Senha',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children:<Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 12, left: 16, right: 16),
                    child: RaisedButton(
                        onPressed: _cadastro,
                        color: Color(0xFF00BCC9),
                        child: Text(
                          'CADASTRAR',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black
                          ),
                        ),
                        padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Text(msgerro,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}
