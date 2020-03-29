import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geografica_project/pages/Login.dart';
import 'package:geografica_project/pages/formularioRegistro.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          _pagina1(),
          _pagina3(context),
        ],
      ),
    );
  }

  Widget _pagina1() {
    return Stack(
      children: <Widget>[_colorFondo(), _imagenFondo(), _textos()],
    );
  }

  Widget _colorFondo() {
    return Container(
      color: Colors.white54,
      width: double.infinity,
      height: double.infinity,
    );
  }

  Widget _imagenFondo() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 170.0, horizontal: 3.0),
      child: Image(
        image: AssetImage('assets/img/portada.jpg'),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _textos() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(),
        ),
        Text(
          'Bienvenido',
          style: TextStyle(fontSize: 35.0, color: Colors.red),
        ),
        Icon(
          Icons.keyboard_arrow_down,
          color: Colors.red,
          size: 100.0,
        ),
      ],
    );
  }

  Widget _pagina3(BuildContext context) {
    return Container(
      color: Colors.grey[850],
      //width: double.infinity ,
      //height: double.infinity,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 60.0,
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              child: Text(
                'Servicios de emergencias AyudaU',
                style: TextStyle(color: Colors.red[400], fontSize: 30.0),
              )),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
            child: Text(
                'Con esta app puedes solicitar ayuda en caso de Emergencias, mediante tu ubicacion nosotros te localizamos y asistimos al pedido de ayuda, todo al alcance de un solo click',
                style: TextStyle(color: Colors.white70, fontSize: 15.0)),
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 30.0,
              ),
              Icon(
                Icons.people,
                size: 40.0,
                color: Colors.red[400],
              ),
              Icon(
                Icons.location_on,
                size: 40.0,
                color: Colors.red[400],
              ),
              Icon(
                Icons.local_hospital,
                size: 40.0,
                color: Colors.red[400],
              ),
              Icon(
                Icons.airport_shuttle,
                size: 40.0,
                color: Colors.red[400],
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              shape: StadiumBorder(),
              color: Colors.red[400],
              textColor: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                child: Text(
                  "Registrarme",
                  style: TextStyle(fontSize: 22.0),
                ),
              ),
              onPressed: () {
                final route = MaterialPageRoute(builder: (context) {
                  return FormularioRegistro();
                });
                Navigator.push(context, route);
              }),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              shape: StadiumBorder(),
              color: Colors.red[400],
              textColor: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                child: Text(
                  "Iniciar Sesion",
                  style: TextStyle(fontSize: 22.0),
                ),
              ),
              onPressed: () {
                final route = MaterialPageRoute(builder: (context) {
                  return Login();
                  //FormularioTrabajador();
                });
                Navigator.push(context, route);
              }),
        ],
      ),
    );
  }
}
