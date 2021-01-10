import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Login.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFF5F5F5),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:  EdgeInsets.only(left: 20,right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20,left: 20, right: 20, bottom: 26),
                child: Image.asset("images/logomarca.png", width: 220,),
              ),
              Text(
                "O churrasco HAMMER CONSULT é um evento exclusivamente para os funcionários da empresa, com intuito de promover a união, a amizade e a confiança entre os funcionários da empresa.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 40,),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 6, bottom:3, left: 16,right: 16),
                  child: RaisedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                      },
                      color: Color(0xFF06C572),
                      child: Text(
                        'FAZER LOGIN',
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
              ),

              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 30),
                child: Text( "Acesso restrito apenas para funcionários",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                )
                ),
              ),
              Image.asset("images/hammer.png", width: 170,)
            ],
          ),
        ),
      ),

    );
  }
}
