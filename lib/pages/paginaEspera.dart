import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PaginaEspera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: EdgeInsets.symmetric(vertical: 40.0),
        color: Colors.grey[850],
        child: Material(
          color: Colors.grey[850],
          child: Column(
            children: <Widget>[
                  Padding(
                padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
              ),
          
              Text( 'Esperando emergencia ..',style: TextStyle(color: Colors.red[400],fontSize: 20.0)),
                SizedBox(height: 70.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/img/time1.png'),
                  ),
                  Image(
                    image: AssetImage('assets/img/ajustes.png'),
                  ),
                ],
              )
            ],
          ),
        )
        );
  }
}
