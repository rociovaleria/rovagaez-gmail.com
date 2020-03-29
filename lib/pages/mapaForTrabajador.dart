import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:geografica_project/src/providers/ubicacion_provider%20copy.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

///Dependencias del map
Completer<GoogleMapController> _controller = Completer();
GoogleMapController mapController;

final Set<Marker> _markers = Set();
double latitud=-17.7757187;
double longitud=-63.1964036;
String emergencia='Policia';
//Ubicacion formUbicacion = new Ubicacion();

final ubicacionProvider = new UbicacionProvider();

class MapaTrabajador extends StatelessWidget {
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
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
         // mensaje(),
          SizedBox(
            height: 30.0,
          ),
          mapa(latitud, longitud),
          SizedBox(
            height: 70.0,
          ),
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
 
   Set<Marker> getMarkers() {
    final Set<Marker> markers = Set();
    
      markers.add(
        new Marker(
            markerId: MarkerId('SosEmergencia'),
            position:
                LatLng(latitud, longitud),
            infoWindow: InfoWindow(
                title: 'Emergencia',
                snippet: "solicitud de emergencia")),
      );
    
    return markers;
  }

  Widget mapa(double x, double y) {
    return Container(
      height: 450.0,
      width: 400.0,
      child: Stack(
        children: <Widget>[
          GoogleMap(
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: _initialPosition(x, y),
            mapType: MapType.satellite,
            markers: getMarkers(),
          ),
          
        ],
      ),
    );
  }

  CameraPosition _initialPosition(double lat, double lon) =>
      CameraPosition(target: LatLng(lat, lon), zoom: 15.0);
}
