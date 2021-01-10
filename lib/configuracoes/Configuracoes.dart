import 'package:flutter/material.dart';

class Configuracoes {

  static List<DropdownMenuItem<String>> getConvidado() {
    List<DropdownMenuItem<String>> itensDropConvidado = [];

    //Categorias
    itensDropConvidado.add(
        DropdownMenuItem(child: Text(
          " ", style: TextStyle(
            color: Colors.black
        ),
        ), value: null,)
    );

    itensDropConvidado.add(
        DropdownMenuItem(child: Text("Não"), value: "nao",)
    );

    itensDropConvidado.add(
        DropdownMenuItem(child: Text("Sim"), value: "sim",)
    );

    return itensDropConvidado;
  }

  static List<DropdownMenuItem<String>> getBebida() {
    List<DropdownMenuItem<String>> itensDropBebida = [];

    //Categorias
    itensDropBebida.add(
        DropdownMenuItem(child: Text(
          " ", style: TextStyle(
            color: Colors.black
        ),
        ), value: null,)
    );

    itensDropBebida.add(
        DropdownMenuItem(child: Text("Sim"), value: "sim",)
    );

    itensDropBebida.add(
        DropdownMenuItem(child: Text("Não"), value: "nao",)
    );

    itensDropBebida.add(
        DropdownMenuItem(child: Text("um sim e um não"), value: "um sim",)
    );

    itensDropBebida.add(
        DropdownMenuItem(child: Text("Eu Sim / vou só"), value: "eu sim vou so",)
    );

    return itensDropBebida;
  }

}

