import 'package:flutter/material.dart';
import 'package:geografica_project/pages/formularioTrabajador.dart';
import 'package:geografica_project/pages/home.dart';
import 'package:geografica_project/pages/principal.dart';
import 'package:geografica_project/pages/ubicacionActual.dart';
import 'package:geografica_project/src/preferencias/preferencias_usuarios.dart';
import 'package:geografica_project/src/providers/notificaciones_provider.dart';

import 'pages/mapaForTrabajador.dart';
import 'pages/principalTrabajador.dart';

void main() async{
  final prefs= new PreferenciasUsuario();
  await prefs. initPrefs();
  runApp(MyApp());
  
   
  }


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final GlobalKey<NavigatorState> navigatorkey=new GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    final pref=new PreferenciasUsuario();

    print(pref.token);
    final prefM=new PreferenciasUsuario();
    print('este deberia ser el nombre');
    print(prefM.idRegistro);
   final token=new NotificacionesProvider();
    token.initNotifications();
    token.mensajes.listen((argumento){
       print('argumento de la data');
       navigatorkey.currentState.pushNamed('mapaTrabajador');
    }
    );
      return MaterialApp(
         debugShowCheckedModeBanner: false,
         navigatorKey: navigatorkey,
         initialRoute: 'home',
          routes:{
            'home': (BuildContext context)=>Home(), 
            //'ubicacionTrabajador':(BuildContext context )=>Ubicacion(),
            'formulario': (BuildContext context)=>FormularioTrabajador(), 
            'principal': (BuildContext context)=>Principal(), 
            'principalTrabajador': (BuildContext context)=>PrincipalTrabajador(), 
            'mapaTrabajador': (BuildContext context)=>MapaTrabajador(), 
           
            
          },
      );
    
    
  }


}

