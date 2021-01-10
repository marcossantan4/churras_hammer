import 'package:flutter/material.dart';

class EcolherCancelamento extends StatelessWidget {

  VoidCallback functionValue;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Radio(
          value: 1,
          groupValue: functionValue,
          activeColor: Colors.green,
          onChanged: (val){

          },
        )
      ],
    );
  }
}
