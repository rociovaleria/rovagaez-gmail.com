import 'package:flutter/material.dart';
import 'package:geografica_project/pages/formularioTrabajador.dart';

class PrincipalTrabajador extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      
      appBar: AppBar(backgroundColor: Colors.red[900],actions: <Widget>[ Icon(Icons.menu)],),
      body:  Container(
           width: double.infinity,
      height: double.infinity,
        color: Colors.grey[850],
       child: Column(
        
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
          ),
          Text(
            'Bienvenido',
            style: TextStyle(fontSize: 35.0, color: Colors.red[400]),
          ),
          SizedBox(height: 20.0,),
          Text('Comienza llenando el formulario ',
              style: TextStyle(fontSize: 20.0, color: Colors.white)),
              SizedBox(height: 40.0,),
          GestureDetector(
            onTap: () {
               final route=MaterialPageRoute(
                builder: (context){
                  return FormularioTrabajador();
                  //FormularioTrabajador();
                }
              );
              Navigator.push(context, route);
            print('onpressss*************');

          },
          child:Image(image: AssetImage('assets/img/form.png'),)
          
           /*CircleAvatar(
             backgroundImage: ExactAssetImage('assets/img/form1.png'),
                minRadius: 80,
                maxRadius: 120,
          ),*/
          ),
            SizedBox(height: 20.0,),
          Text('Verifica las notificaciones',
              style: TextStyle(fontSize: 20.0, color: Colors.white)),
              SizedBox(height: 40.0,),
              GestureDetector(
            onTap: () {
               final route=MaterialPageRoute(
                builder: (context){
                  return FormularioTrabajador();
                  //FormularioTrabajador();
                }
              );
              Navigator.push(context, route);
            print('onpressss*************');

          },
          child:Image(image: AssetImage('assets/img/notificacion.png'),)
        
          ),
            SizedBox(height: 20.0,),
          Text('Finaliza la jornada ',
              style: TextStyle(fontSize: 20.0, color: Colors.white)),
              SizedBox(height: 40.0,),
              GestureDetector(
            onTap: () {
             mostarAlert(context);

          },
          child:Image(image: AssetImage('assets/img/fin.png'),)
        
          ),
        ],
      ),
      ),
    );
  }
  void mostarAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Salida'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                    'Se enviaron los datos exitosamente, usted ha finalizado la jornada laboral'),
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

}
