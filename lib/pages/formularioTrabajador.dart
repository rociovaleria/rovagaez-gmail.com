import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geografica_project/pages/paginaEspera.dart';
import 'package:geografica_project/src/modelos/formularioModel.dart';
import 'package:geografica_project/src/preferencias/preferencias_usuarios.dart';
import 'package:geografica_project/src/providers/formulario_provider.dart';
import 'package:geolocator/geolocator.dart';

double latitud;
double longitud;
class FormularioTrabajador extends StatefulWidget {
  @override
  _FormularioTrabajadorState createState() => new _FormularioTrabajadorState();
}

final formkey = GlobalKey<FormState>();
Formulario formularioTrabajador = new Formulario();
final formularioProvider = new FormularioProvider();
final _prefs = new PreferenciasUsuario();
class _FormularioTrabajadorState extends State<FormularioTrabajador> {
  String dateini = '';
  String datefin = '';

//controlador para poder manipular el input, cambiar sus propiedades de manera dinamica
  TextEditingController _controladorFechaIni = new TextEditingController();
  TextEditingController _controladorFechaFin = new TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _fondo(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 25.0),
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                  color: Colors.white10,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40.0,
                      ),
                      Text('Formulario de Trabajo',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontStyle: FontStyle.normal,
                              color: Colors.white70)),
                      SizedBox(
                        height: 30.0,
                      ),
                      _tipoVehiculo(),
                      SizedBox(
                        height: 10.0,
                      ),
                      _turno(),
                      SizedBox(
                        height: 10.0,
                      ),
                      _horaInicial(context),
                      SizedBox(
                        height: 10.0,
                      ),
                      _horaFinal(context),
                      SizedBox(
                        height: 30.0,
                      ),
                      _rolTrabajador(),
                      SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        children: <Widget>[
                          GestureDetector(child: Image(
                            image: AssetImage('assets/img/mapa.png'),
                          
                          ),
                          onTap: _enviarUbicacion,
                          ),
                          SizedBox(
                            width: 70.0,
                            
                          ),
                        _boton()
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _boton() {
    return RaisedButton.icon(
        label: Text('Enviar'),
        icon: Icon(Icons.send),
        shape: StadiumBorder(),
        color: Colors.red[900],elevation:20.0 ,
      
        textColor: Colors.white,
        onPressed: () {
          _submit();
          mostarAlert(context);
        });
  }

  Widget _fondo() {
    return Container(
      color: Colors.grey[850],
    );
  }

  Widget _horaInicial(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectFechaInicial(context);
        },
        child: AbsorbPointer(
          child: TextFormField(
            // padding: EdgeInsets.symmetric(horizontal: 20.0),

            //para no poder copiar
            enableInteractiveSelection: false,
            controller: _controladorFechaIni,
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red[800])),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                hintText: 'Inicio de turno',
                labelText: 'Hora de inicio',
                labelStyle: new TextStyle(color: Colors.white70)),

            onSaved: (value) => formularioTrabajador.horaEntrada = dateini,
          ),
        ));
  }

  _selectFechaInicial(BuildContext context) async {
    TimeOfDay select = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
    if (select != null) {
      setState(() {
        print(select);
        dateini = select.format(context);
        _controladorFechaIni.text = dateini;
      });
    }
  }

  Widget _horaFinal(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectFechaFin(context);
      },
      // padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: AbsorbPointer(
        child: TextFormField(
          enableInteractiveSelection: false,
          controller: _controladorFechaFin,
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red[800])),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              hintText: 'Fin del turno',
              labelText: 'Hora de salida',
              labelStyle: new TextStyle(color: Colors.white70)),
          onSaved: (value) => formularioTrabajador.horaSalida = datefin,
        ),
      ),
    );
  }

  _selectFechaFin(BuildContext context) async {
    TimeOfDay selectFin =
        await showTimePicker(initialTime: TimeOfDay.now(), context: context);
    if (selectFin != null) {
      setState(() {
        datefin = selectFin.format(context);
        _controladorFechaFin.text = datefin;
      });
    }
  }

  Widget _turno() {
    return TextFormField(
      //padding: EdgeInsets.symmetric(horizontal: 20.0),

      //  keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.white),
      initialValue: formularioTrabajador.turno,
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red[800])),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          labelText: 'Turno',
          labelStyle: new TextStyle(color: Colors.white70)),
      onSaved: (value) => formularioTrabajador.turno = value,
      validator: (value) {
        return (value.length < 3) ? 'ingrese el turno' : null;
      },
    );
  }

  Widget _rolTrabajador() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      initialValue: formularioTrabajador.turno,
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red[800])),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          labelText: 'Rol',
          labelStyle: new TextStyle(color: Colors.white70)),
      onSaved: (value) => formularioTrabajador.rol = value,
      validator: (value) {
        return (value.length < 3) ? 'ingrese el rol' : null;
      },
    );
  }

  Widget _tipoVehiculo() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      initialValue: formularioTrabajador.movilidad,
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red[800])),
          //  focusedBorder:UnderlineInputBorder(borderSide:BorderSide(color: Colors.cyan)1),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Colors.green)),
          labelText: 'Tipo de Vehiculo',
          labelStyle: new TextStyle(color: Colors.white70)),
      onSaved: (value) => formularioTrabajador.movilidad = value,
      validator: (value) {
        return (value.length < 3) ? 'ingrese el vehiculo' : null;
      },
    );
    //padding: EdgeInsets.symmetric(horizontal: 20.0),
  }

  void mostarAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Envio de Formulario'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                    'Se envio el formulario exitosamente, a la espera de una emergencia '),
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
                  final route = MaterialPageRoute(builder: (context) {
                    return PaginaEspera();
                    //FormularioTrabajador();
                  });
                  Navigator.push(context, route);
                },
              )
            ],
          );
        });

    // return object of type Dialog
  }
  
  void _enviarUbicacion() {
    
  Geolocator().getCurrentPosition().then((location) {
      if (location != null) {
        latitud = location.latitude;
        longitud = location.longitude;
        print("****************************Ubicacion actual=> longitud: " +
            longitud.toString() +
            ", latitud: " +
            latitud.toString());
    formularioTrabajador.latitud = latitud;
    formularioTrabajador.longitud = longitud;
    //cambiar el el form registro 
    formularioTrabajador.idFormRegistro=_prefs.idRegistro;
      } else {
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    });
  }

  void _submit() {
    if (!formkey.currentState.validate()) return;
    formkey.currentState.save();
    //si es valido hace todo lo que sigue
    print('todo ok');
    print(formularioTrabajador.movilidad);
    print(formularioTrabajador.turno);
    print(formularioTrabajador.horaSalida);
    print(formularioTrabajador.horaEntrada);
    print('este es el id del formulario');
    print(formularioTrabajador.idFormRegistro);
    


    formularioProvider.crearFormulario(formularioTrabajador);
  }
}
