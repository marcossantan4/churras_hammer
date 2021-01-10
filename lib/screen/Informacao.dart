import 'package:flutter/material.dart';

class Informacao extends StatefulWidget {
  @override
  _InformacaoState createState() => _InformacaoState();
}

class _InformacaoState extends State<Informacao> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        appBar: AppBar(
          title: Text("INFORMAÇÕES"),
          backgroundColor: Color(0xFF23456E),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 20),
                child: Image.asset(
                  "images/logomarca.png",
                  width: 200,
                ),
              ),
              Container(
                  width: double.infinity,
                  height: 500,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "SOBRE O EVENTO",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.  printer took a galley of type and scrambled. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.  printer took a galley of type and scrambled. ",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Text(
                          "IMAGENS",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 100,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              Image.asset(
                                "images/imagem1.png",
                                width: 100,
                                height: 100,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Image.asset(
                                "images/imagem2.png",
                                width: 100,
                                height: 100,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Image.asset(
                                "images/imagem3.png",
                                width: 100,
                                height: 100,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Image.asset(
                                "images/imagem4.png",
                                width: 100,
                                height: 100,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }
}
