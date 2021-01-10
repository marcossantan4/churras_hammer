import 'package:churras_hammer/screen/Home.dart';
import 'package:churras_hammer/screen/MeuLocal.dart';
import 'package:churras_hammer/screen/PerfilAdministrador.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() {

  runApp(MaterialApp(
    home: SplashScreenView(
      home: PerfilAdministrador(),
      duration: 3000,
      imageSize: 130,
      imageSrc: "images/logomarca.png",
      backgroundColor: Color(0xFFF5F5F5),
    ),
    debugShowCheckedModeBanner: false,

    ));
}