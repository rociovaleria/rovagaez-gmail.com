import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geografica_project/pages/ubicacionActual.dart';

class Principal extends StatelessWidget {
  bool policia=false;
  bool ambulancia=false;
  bool bomberos=false;
  //Principal(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
         actions: <Widget>[GestureDetector(onTap: (){ _logout();},  child: Icon(Icons.backspace),) ], 
        ),
        backgroundColor: Colors.grey[850],
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 40.0),
            ),
            Text('Bienvenido',
                style: TextStyle(color: Colors.red[400], fontSize: 30.0)),
            SizedBox(height: 30.0),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      'ya puedes comenzar a usar nuestros servicios',
                      style: TextStyle(color: Colors.white70, fontSize: 20.0),
                    ),
                    
                  ],
                )),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                shape: StadiumBorder(),
                color: Colors.red[400],
                textColor: Colors.white,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                  child: Text(
                    "Pedir Ayuda",
                    style: TextStyle(fontSize: 22.0),
                  ),
                ),
                onPressed: () {
                  final route = MaterialPageRoute(builder: (context) {
                    return _menu(context);
                  });
                  Navigator.push(context, route);
                }),
                SizedBox(height:30.0 ),
                Image(
                        image: AssetImage('assets/img/aprovechar.png')
                    ),
          ],
        ));
  }

  Widget _menu(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[850],
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          SizedBox(height: 10.0),
          _servicioPolicias(context),
          _servicioBomberos(context),
          _servicioAmbulancias(context)
        ],
      ),
    );
  }
  Widget _servicioPolicias(BuildContext context) {
   policia=true;
   String nombreEm="";
    return Card(
      color: Colors.grey[850],
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              'Policias',
              style: TextStyle(color: Colors.white, fontSize: 30.0),
            ), 
            subtitle: Text(
                'solicita nuestro servicio de policias en caso que estes sufriendo algun percance o necesites la ayuda urgente de una patrulla',
                style: TextStyle(color: Colors.white24, fontSize: 15.0)),
          ),
          Image(
            image: AssetImage('assets/img/policia.png'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                  child: Text(
                    'solicitar',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.red[900],
                  onPressed: () {
                    final route = MaterialPageRoute(builder: (context) {
                          if(policia){
                         nombreEm='policia';
                     UbicacionActual().emergenciaActual(nombreEm);
                      }
                      return UbicacionActual();
                    });
                    Navigator.push(context, route);
                  }),
            ],
          )
        ],
      ),
    );
  }

  Widget _servicioAmbulancias(BuildContext context) {
    ambulancia=true;
    String nombreEm="";
    return Card(
      color: Colors.grey[850],
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              'Ambulancias',
              style: TextStyle(color: Colors.white, fontSize: 30.0),
            ),
            subtitle: Text(
                'solicita nuestro servicio de ambulancias en caso de cualuier accidente u de alguna necesidad de emergencia',
                style: TextStyle(color: Colors.white24, fontSize: 15.0)),
          ),
          Image(
            image: AssetImage('assets/img/ambulancia.png'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                  child: Text(
                    'solicitar',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.red[900],
                  onPressed: () {
                    final route = MaterialPageRoute(builder: (context) {
                       if(ambulancia){
                         nombreEm='ambulacia';
                     UbicacionActual().emergenciaActual(nombreEm);
                      }
                      return UbicacionActual();
                    });
                    Navigator.push(context, route);
                  }),
            ],
          )
        ],
      ),
    );
  }

  Widget _servicioBomberos(BuildContext context) {
    bomberos=true;
    String nombreEm;
    return Card(
      color: Colors.grey[850],
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              'Bomberos',
              style: TextStyle(color: Colors.white, fontSize: 30.0),
            ),
            subtitle: Text(
                'solicita nuestro servicio de bomberos en caso de presenciar algun y necesites la ayuda de un camion bombero',
                style: TextStyle(color: Colors.white24, fontSize: 15.0)),
          ),
          Image(
            image: AssetImage('assets/img/bomberos.png'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                  child: Text(
                    'solicitar',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.red[900],
                  onPressed: () {
                    final route = MaterialPageRoute(builder: (context) {
                      if(bomberos){
                         nombreEm='bomberos';
                     UbicacionActual().emergenciaActual(nombreEm);
                      }
                    
                      return UbicacionActual();
                    });
                    Navigator.push(context, route);
                  }),
            ],
          )
        ],
      ),
    );
  }
  void _logout(){
  FirebaseMessaging().deleteInstanceID();
    
  }
}
