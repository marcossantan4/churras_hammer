import 'package:flutter/material.dart';

class DadosAdm extends StatelessWidget {

  DadosAdm({this.nome1, this.dados1, this.nome2, this.dados2});
  String nome1, dados1, nome2, dados2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child:  Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:  Color(0xFF23456E),
            ),
            width: 200,
            height: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(nome1, style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),),
                Text(dados1, style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),)
              ],
            ),
          ),
        ),
        SizedBox(width: 20, height: 20,),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color:  Color(0xFF23456E),
            ),
            width: 200,
            height: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(nome2, style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),),
                Text(dados2, style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),)
              ],
            ),
          )
        )
      ],
    );
  }
}
