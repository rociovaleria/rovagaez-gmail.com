import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:geografica_project/src/modelos/ubicacionModel.dart';
import 'package:geografica_project/src/providers/ubicacion_provider%20copy.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

///Dependencias del map
Completer<GoogleMapController> _controller = Completer();
GoogleMapController mapController;
final Set<Marker> _markers = Set();
double latitud=0;
double longitud=0;
String emergencia;
Ubicacion formUbicacion = new Ubicacion();

final ubicacionProvider = new UbicacionProvider();

class UbicacionActual extends StatelessWidget {
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void emergenciaActual(String e) {
    print('*********************************entro al void');
    print(e);
    emergencia = e;
    print(emergencia);
  }

  String getEmergfencia() {
    return emergencia;
  }

  @override
  Widget build(BuildContext context) {
    Geolocator().getCurrentPosition().then((location) {
      if (location != null) {
        latitud = location.latitude;
        longitud = location.longitude;
        print("Ubicacion actual=> longitud: " +
            longitud.toString() +
            ", latitud: " +
            latitud.toString());
      } else {
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    });
    return Container(
      color: Colors.grey[850],
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          mensaje(),
          SizedBox(
            height: 30.0,
          ),
          mapa(latitud, longitud),
          SizedBox(
            height: 70.0,
          ),
          FlatButton(
              child: Text(
                'Enviar',
                style: TextStyle(color: Colors.white),
              ),
              shape: StadiumBorder(),
              color: Colors.red[400],
              onPressed: () {
                _enviarInformacion();
                mostarAlert(context);
              }),
        ],
      ),
    );
  }

  Widget mensaje() {
    var card = Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.red[400],
      child: Column(
        children: <Widget>[
          ListTile(
            title:
                Text('', style: TextStyle(color: Colors.black, fontSize: 15.0)),
            subtitle: Text('Envianos tu ubicacion actual para enviarte ayuda ',
                style: TextStyle(color: Colors.white, fontSize: 20.0)),
          ),
          SizedBox(
            height: 15.0,
          )
        ],
      ),
    );
    return card;
  }

  void _enviarInformacion() {
    formUbicacion.emergencia = getEmergfencia();
    print('*****************************************getemergencia');

    print(formUbicacion.emergencia);
    formUbicacion.latitud = latitud;
    formUbicacion.longitud = longitud;
 
    ubicacionProvider.crearFormulario(formUbicacion);
  }

  void mostarAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Confirmacion'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                    'Su solicitud ha sido procesada con exito, enseguida lo atenderemos '),
                Icon(
                  Icons.check_circle,
                  size: 60.0,
                  color: Colors.redAccent,
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });

    // return object of type Dialog
  }

  Widget mapa(double x, double y) {
    return Container(
      height: 300.0,
      width: 400.0,
      child: Stack(
        children: <Widget>[
          GoogleMap(
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: _initialPosition(x, y),
            mapType: MapType.satellite,
            //markers: _markers,
          ),
        ],
      ),
    );
  }

  CameraPosition _initialPosition(double lat, double lon) =>
      CameraPosition(target: LatLng(lat, lon), zoom: 15.0);
}
