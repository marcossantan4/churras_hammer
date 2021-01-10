import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MeuLocal extends StatefulWidget {
  @override
  _MeuLocalState createState() => _MeuLocalState();
}

class _MeuLocalState extends State<MeuLocal> {

  Set<Marker> _marcadores = {};
  Completer<GoogleMapController> _controller = Completer();

  _onMapCreated( GoogleMapController googleMapController ){
    _controller.complete( googleMapController );
  }

  _carregarMarcadores(){

    Set<Marker> marcadoresLocal = {};

    Marker marcadorLocal = Marker(
        markerId: MarkerId("Local-Evento"),
        position: LatLng(-30.004717562119257, -51.15328615650497),
        infoWindow: InfoWindow(
            title: "Local Evento"
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueRed
        ),

    );

    marcadoresLocal.add( marcadorLocal );

    setState(() {
      _marcadores = marcadoresLocal;
    });
  }

  _movimentarCamera() async {

    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(-30.004717562119257, -51.15328615650497),
                zoom: 16,
                tilt: 0,
                bearing: 270
            )
        )
    );

  }

  @override
  void initState() {
    super.initState();
    _carregarMarcadores();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LOCAL EVENTO"),
        backgroundColor: Color(0xFF23456E),),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF23456E) ,
          child: Icon(Icons.done),
          onPressed: _movimentarCamera
      ),
      body: Container(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
              target: LatLng(-30.004717562119257, -51.15328615650497),
              zoom: 16
          ),
          onMapCreated: _onMapCreated,
          markers: _marcadores,
        ),
      ),
    );
  }
}

