import 'package:flutter/material.dart';

class InterfacePerfilU extends StatelessWidget {

  InterfacePerfilU({this.nome, this.imagem, this.funcao});
  String nome, imagem;
  VoidCallback funcao;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: funcao,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all( color: Color(0xFF23456E), width: 2)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(imagem, width: 70,),
            Text(nome, style: TextStyle(
              color: Color(0xFF23456E),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),)
          ],
        ),
      ),
    );
  }
}
