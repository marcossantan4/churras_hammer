import 'package:churras_hammer/model/Participantes.dart';
import 'package:flutter/material.dart';

class CardLista extends StatelessWidget {
  CardLista({@required this.participantes});
  Participantes participantes;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.indigo, width: 2.0)
      ),
      child: Column(
        children: <Widget>[
          Text("Participante: ${participantes.nomeParticipante}", style: TextStyle(
            color: Colors.indigo, fontSize: 14
          ),),
          Text("Convidado: ${participantes.nomeParticipante}", style: TextStyle(
              color: Colors.indigo, fontSize: 14
          )),
          SizedBox(height: 3,),
          Text("Valor: R\$: ${participantes.valor}",style: TextStyle(
              color: Colors.red, fontSize: 14
          )),

        ],
      ),
    );
  }
}
