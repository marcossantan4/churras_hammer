import 'package:awesome_loader/awesome_loader.dart';
import 'package:churras_hammer/model/Usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'PerfilAdministrador.dart';
import 'PerfilUsuario.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String textError = '';
  bool _carregando = false;
  bool _senha = true;
  Color _color = Colors.black;
  bool loginGoogleB = false;

  _validarLogin(){

    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if(email.isNotEmpty && email.contains('@')){
      if(senha.isNotEmpty && senha.length > 4){

        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;

        logarUsuario(usuario);

      }else{
        setState(() {
          textError = 'Digite uma senha válida';
          _carregando = false;
        });
      }

    }else{
      setState(() {
        textError = "Digite um e-mail válido";
        _carregando = false;
      });
    }

  }

  _RedirecionarUsuarioLogado(String idUsuario) async{


    Firestore db = Firestore.instance;

    DocumentSnapshot snapshot = await db.collection("usuarios").document(idUsuario).get();

    Map<String, dynamic> dados = snapshot.data;
    String tipoUsuario = dados["email"];


    if(tipoUsuario == "administrador@hammer.com.br"){

      Navigator.pushReplacement(context, MaterialPageRoute( builder: (context) => PerfilAdministrador()));


    }else{

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PerfilUsuario()));

    }

  }

  logarUsuario(Usuario usuario) async{

    setState(() {
      _carregando = true;
    });
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signInWithEmailAndPassword(email: usuario.email, password: usuario.senha).then((firebaseUser){

      _RedirecionarUsuarioLogado(firebaseUser.uid);

    }).catchError((onError){
      setState(() {
        textError = "Erro ao entrar no app";
        _carregando = false;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFFF5F5F5),
      appBar: AppBar(
        elevation: 0,
        title: Text("LOGIN", style: TextStyle(color: Colors.white),),
        backgroundColor:  Color(0xFF23456E),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 20),
                child: Image.asset("images/logomarca.png", width: 220,),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 12),
                child: TextField(
                  controller: _controllerEmail,
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: 'E-mail',
                      hintStyle: TextStyle( fontSize: 18),
                      prefixIcon: Icon(FontAwesomeIcons.envelope,),
                      fillColor: Colors.white.withOpacity(0.5),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 12),
                child: TextField(
                  autofocus: true,
                  controller: _controllerSenha,
                  obscureText: _senha,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: 'Senha',
                      hintStyle: TextStyle( fontSize: 18),
                      prefixIcon: Icon(FontAwesomeIcons.lock,),
                      fillColor: Colors.white.withOpacity(0.5),
                      filled: true,
                      suffixIcon: GestureDetector(
                        onTap: (){
                          setState(() {
                            if(_senha == false){
                              _senha = true;
                              _color = Colors.black;
                            }else if(_senha == true){
                              _senha = false;
                              _color = Colors.blueAccent;
                            }
                          });
                        },
                        child: Icon(
                          Icons.remove_red_eye, color: _color,),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom:3, left: 16,right: 16),
                    child: RaisedButton(
                        onPressed:_validarLogin,
                        color: Color(0xFF06C572),
                        child: Text(
                          'ENTRAR',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF23456E)
                          ),
                        ),
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 20),
                      child: Text(
                        textError, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              Image.asset("images/hammer.png", width: 170,)
            ],
          ),
        ),
      ),
    );
  }
}
