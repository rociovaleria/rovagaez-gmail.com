
import 'package:flutter/material.dart';



class ContainerC extends StatefulWidget {
  @override
  _ContainerCState createState() => _ContainerCState();
  
}

class _ContainerCState extends State<ContainerC> {
  ContainerC createState() => new ContainerC();

  @override
  Widget build(BuildContext context) {
    // debugCheckIntrinsicSizes = false;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GestureDetector(child:Icon(Icons.arrow_back,),onTap: (){
           // Navigator.push(context, Route(Home);
          },),
          
          _fondoApp(),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5.0,
                ),
                _titulos(),
                _botones(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _fondoApp() {
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset(0.0, 0.5),
              end: FractionalOffset(0.0, 1.0),
              colors: [Colors.grey[850], Colors.grey[800], Colors.grey[700]]
              //Color.fromRGBO(35, 37, 57, 1.0)
              )),
    );
    return Stack(
      children: <Widget>[gradiente],
    );
  }

  Widget _titulos() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text('Services Drive',
                style: TextStyle(
                    color: Colors.lime,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold)),
            Text('Elige el servicio que mas te interese',
                style: TextStyle(color: Colors.lime, fontSize: 18.0)),
          ],
        ),
      ),
    );
  }

  Widget _botones() {
    return Table(
      children: [
        TableRow(children: [
          _crearBoton(
            Colors.pinkAccent,
            Icons.local_gas_station,
            'Surtidores',
          ),
          _crearBoton(Colors.brown, Icons.local_car_wash, 'Lavaderos'),
        ]),
        TableRow(children: [
          _crearBoton(Colors.blueAccent, Icons.local_parking, 'Parqueos'),
          _crearBoton(
              Colors.purpleAccent, Icons.local_taxi, 'Talleres Mecanicos'),
        ]),
        TableRow(children: [
          _crearBoton(Colors.red[500], Icons.touch_app, 'Gruas'),
          _crearBoton(Colors.teal[800], Icons.people, 'Mecanicos'),
        ])
      ],
    );
  }

  Widget _crearBoton(Color color, IconData icono, String texto ) {
    return Container(
      height: 150.0,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
         // color: Colors.lime[600],

          color: Color.fromRGBO(204, 255, 0, 0.50),
          borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(
            height: 5.0,
          ),
          GestureDetector(
              child: CircleAvatar(
            backgroundColor: color,
            radius: 35.0,
            child: Icon(
              icono,
              color: Colors.white,
              size: 30.0,
            ),
          ),),
          Text(
            texto,
            style: TextStyle(color: color),
          ),
          SizedBox(
            height: 5.0,
          ),
        ],
      ),
    );
  }
}
