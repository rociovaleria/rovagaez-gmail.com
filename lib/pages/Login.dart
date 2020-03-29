import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geografica_project/src/modelos/loginModel.dart';
import 'package:geografica_project/src/providers/formRegistro_provider.dart';
//import 'package:parcial_flutter/application/content_user_provider.dart';
//import 'package:parcial_flutter/models/empleados_model.dart';
//import 'package:parcial_flutter/providers/login_provider.dart';

class Login extends StatefulWidget {
  _LoginState createState() => _LoginState();
}

final formkey = GlobalKey<FormState>();
LoginModel loginmodel = new LoginModel();
final loginProvider = new FormRegistroProvider();

class _LoginState extends State<Login> {
  bool recordar = false;
  @override
  Widget build(BuildContext context) {
    final loginButton = new RaisedButton(
        child: Text('Iniciar sesión'),
        color: Colors.red[400],
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20.0)),
        onPressed: () {
          _submit(context);
        });
    final borrarButton = new RaisedButton(
        child: Text('Iniciar sesión como trabajador'),
        color: Colors.red[400],
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20.0)),
        onPressed: () {
          _submitTrbajador(context);
        });

    return Scaffold(
      // body: Container(

      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 80),
        color: Colors.grey[850],
        child: SingleChildScrollView(
          //child: Container(
          //  color: Colors.pink,
          child: Form(
            key: formkey,
            child: Container(
              color: Colors.white10,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/img/trabajador.png'),
                  ),
                  SizedBox(height: 10.0),
                  emailField(),
                  SizedBox(height: 20),
                  passwordField(),
                  Row(
                    children: <Widget>[
                      Checkbox(
                          value: recordar,
                          onChanged: (bool value) {
                            setState(() {
                              recordar = value;
                            });
                          }),
                      Text('Recodar contraseña')
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: loginButton,
                  ),
                  SizedBox(height: 15.0),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: borrarButton,
                  )
                ],
              ),
              //),
            ),
          ),
        ),
        //),
      ),
    );
  }

  /* Widget _cargarLogin() {
    return FutureBuilder(
      future: loginProvider.login(, password),
      builder:
          (BuildContext context, AsyncSnapshot<List<LoginModel>> snapshot) {
        if (snapshot.hasData) {
          return Container();
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }*/

  Widget emailField() {
    return TextFormField(
      initialValue: loginmodel.email,
      decoration: new InputDecoration(
        labelText: "Email",
        labelStyle: TextStyle(color: Colors.white70),
        border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.white10)),
      ),
      onSaved: (value) => loginmodel.email = value,
      validator: (value) {
        return (value.length < 3) ? 'ingrese un nombre de usuario' : null;
      },
    );
  }

  void _logout() {
    print('tocando***********');
    var log = FirebaseMessaging().deleteInstanceID();

    print(log);
  }

  Widget passwordField() {
    return TextFormField(
      initialValue: loginmodel.password,
      obscureText: true,
      decoration: new InputDecoration(
        labelText: "Password",
        labelStyle: TextStyle(color: Colors.white70),
        border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.white10)),
      ),
      onSaved: (value) => loginmodel.password = value,
      validator: (value) {
        return (value.length < 3) ? 'ingrese un nombre de usuario' : null;
      },
    );
  }
}

void _submit(BuildContext context) async {
  if (!formkey.currentState.validate()) return;
  formkey.currentState.save();
  print('todo ok');
  print(loginmodel.password);
  print(loginmodel.email);

  Map info = await loginProvider.login(loginmodel.email, loginmodel.password);
  if (info['ok']) {
    Navigator.pushReplacementNamed(context, 'principal');
  } else {
    _showDialogError(context, info['mensaje']);
  }
}

void _submitTrbajador(BuildContext context) async {
  if (!formkey.currentState.validate()) return;
  formkey.currentState.save();
  Map info = await loginProvider.login(loginmodel.email, loginmodel.password);
  if (info['ok']) {
    Navigator.pushReplacementNamed(context, 'principalTrabajador');
  } else {
    _showDialogError(context, info['mensaje']);
  }
}

void _showDialogError(BuildContext context, String mensaje) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Informacion incorrecta'),
          content: Text(mensaje),
          actions: <Widget>[
            FlatButton(
              child: Text('ok'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      });
}
