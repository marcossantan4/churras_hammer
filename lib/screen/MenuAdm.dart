import 'package:churras_hammer/screen/AddUsuario.dart';
import 'package:churras_hammer/screen/ListaParticipantes.dart';
import 'package:flutter/material.dart';

import 'PerfilAdministrador.dart';

class MenuAdm extends StatefulWidget {
  @override
  _MenuAdmState createState() => _MenuAdmState();
}

class _MenuAdmState extends State<MenuAdm> {

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.all(20),
        color:Color(0xFFF2F2F2),
        child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(top: 60),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 60, top: 60),
                                child: Image.asset("images/logomarca.png", width: 170,)
                              ),

                            ]
                        )
                    ) ,
                    ListTile(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PerfilAdministrador()));
                      },
                      leading: Icon(
                        Icons.dashboard,
                        color:  Color(0xFF4A4A4A),
                      ),
                      title: Text(
                        "DASHBOARD",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4A4A4A)
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ListaParticipantes()));
                      },
                      leading: Icon(
                        Icons.check_box,
                        color:  Color(0xFF4A4A4A),
                      ),
                      title: Text(
                        "PARTICIPANTES",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4A4A4A)
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AddUsuario()));
                      },
                      leading: Icon(
                        Icons.settings,
                        color:  Color(0xFF4A4A4A),
                      ),
                      title: Text(
                        "CADASTRAR",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4A4A4A)
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]
        ),
      ),
    );
  }
}

