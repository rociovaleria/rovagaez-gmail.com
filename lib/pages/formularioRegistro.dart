import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geografica_project/src/modelos/registroModel.dart';
import 'package:geografica_project/src/preferencias/preferencias_usuarios.dart';
import 'package:geografica_project/src/providers/formRegistro_provider.dart';
import 'package:geografica_project/src/providers/notificaciones_provider.dart';

bool trabajador = false;
final _prefs = new PreferenciasUsuario();
class FormularioRegistro extends StatefulWidget {
  @override
  _FormularioRegistroState createState() => _FormularioRegistroState();
}

final formkey = GlobalKey<FormState>();
FormRegistro formRegistro = new FormRegistro();
final formularioProvider = new FormRegistroProvider();

class _FormularioRegistroState extends State<FormularioRegistro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: Container(
        color: Colors.grey[850],
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 25.0),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Container(
              color: Colors.white10,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.assignment_ind,
                    size: 90.0,
                    color: Colors.red[400],
                  ),
                  SizedBox(height: 20),
                  _nameField(),
                  SizedBox(height: 20.0),
                  _celField(),
                   SizedBox(height: 20.0),
                  _emailField(),
                  SizedBox(height: 20),
                  _passwordField(),
                  SizedBox(height: 20),
                  _rolField(),
                  SizedBox(
                    height: 30,
                    // height: double.infinity,
                  ),
                  tokenButton(context),
                  SizedBox(height: 20),
                  loginButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _nameField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      initialValue: formRegistro.nombre,
      decoration: new InputDecoration(
        labelText: "Nombre Completo",
        
        labelStyle: TextStyle(color: Colors.white70),
        fillColor: Colors.red[400],
        border: new OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: new BorderRadius.circular(20.0),
        ),
      ),
      onSaved: (value) => formRegistro.nombre = value,
      validator: (value) {
        return (value.length < 3) ? 'ingrese el nombre correctamente' : null;
      },
    );
  }
  Widget _celField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      initialValue: formRegistro.celular,
      decoration: new InputDecoration(
        labelText: "Celular",
        labelStyle: TextStyle(color: Colors.white70),
        fillColor: Colors.red[400],
        border: new OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: new BorderRadius.circular(20.0),
        ),
      ),
      onSaved: (value) => formRegistro.celular = value,
      validator: (value) {
        return (value.length < 3) ? 'ingrese el nombre correctamente' : null;
      },
    );
  }

  Widget _emailField() {
    return TextFormField(
      // controller: _controladoremail,
      style: TextStyle(color: Colors.white),
      initialValue: formRegistro.email,
      decoration: new InputDecoration(
        labelText: "Email",
        labelStyle: TextStyle(color: Colors.white70),
        fillColor: Colors.red[400],
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(20.0),
        ),
      ),
      onSaved: (value) => formRegistro.email = value,
      validator: (value) {
        return (value.length < 3) ? 'ingrese un correo existente' : null;
      },
    );
  }

  Widget _passwordField() {
    return TextFormField(
      // controller: _controladorpassw,
      style: TextStyle(color: Colors.white),
      obscureText: true,
      initialValue: formRegistro.password,
      decoration: new InputDecoration(
        labelText: "Password",
        labelStyle: TextStyle(
          color: Colors.white70,
        ),
        fillColor: Colors.red[400],
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(20.0),
        ),
      ),
      onSaved: (value) => formRegistro.password = value,
      validator: (value) {
        return (value.length < 3) ? 'la contraseña es muy corta' : null;
      },
    );
  }

  Widget _rolField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      initialValue: formRegistro.rol,
      decoration: new InputDecoration(
        labelText: "Rol",
        labelStyle: TextStyle(color: Colors.white70),
        fillColor: Colors.red[400],
        border: new OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white70),
          borderRadius: new BorderRadius.circular(20.0),
        ),
      ),
      onSaved: (value) => formRegistro.rol = value,
      validator: (value) {
        return (value.length < 3) ? 'ingrese un rol correcto' : null;
      },
    );
  }

  Widget tokenButton(BuildContext context) {
    return RaisedButton(
        child: Text('generar Token'),
        color: Colors.red[400],
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20.0)),
        onPressed: () {
          final pushProvidertoken = new NotificacionesProvider();
          final tok=formularioProvider.getFormularioToken(_prefs.token);
                    final res = pushProvidertoken.getToken().then((res) {
            if (res != null) {
              formRegistro.token = res.toString();
            } else {
              _showDialogNull(context);
            }
          });

          print(res);
          print(formRegistro.token.toString());
          //_submit(context);
          //sPrincipal();
        });
  }

  void _showDialogNull(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('vuelva a intentarlo'),
            content: Text('presione nuevamente el boton'),
            actions: <Widget>[
              FlatButton(
                child: Text('ok'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  Widget loginButton(BuildContext context) {
    return RaisedButton(
        child: Text('Registrarme'),
        color: Colors.red[400],
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20.0)),
        onPressed: () {
          _submit(context);
          //sPrincipal();
        });
  }

  void _submit(BuildContext context) async {
    if (!formkey.currentState.validate()) return;
    formkey.currentState.save();
    //si es valido hace todo lo que sigue
    print('todo ok');
    print(formRegistro.nombre);
    print(formRegistro.password);
    print(formRegistro.email);
    print(formRegistro.rol);
    print('debria estar el token aqui');

    print(formRegistro.token);

    //formularioProvider.crearFormularioRegistro(formRegistro);
    Map info = await formularioProvider.crearFormularioRegistro(
        formRegistro.email, formRegistro.password, formRegistro);
    if (info['ok']) {
      if (formRegistro.rol != 'cliente') {
        Navigator.pushReplacementNamed(context, 'principalTrabajador');
      } else {
        Navigator.pushReplacementNamed(context, 'principal');
      }
    }
  }
}
