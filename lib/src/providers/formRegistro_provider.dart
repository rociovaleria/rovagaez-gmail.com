import 'dart:convert';
import 'package:geografica_project/src/modelos/registroModel.dart';
import 'package:geografica_project/src/preferencias/preferencias_usuarios.dart';
import 'package:http/http.dart' as http;

class FormRegistroProvider {
  final String _tokenfb = 'AIzaSyClo_ARiTJ1_2MZkeuGkbvs9gWARpyyf_0';
  final _prefs = new PreferenciasUsuario();
  // final String _urlreg='https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=';
  //final String _urllogin='https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=';
  final String _url = 'https://notifications-f6e66.firebaseio.com';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final authdata = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_tokenfb',
        body: json.encode(authdata));

    Map<String, dynamic> decodedData = json.decode(resp.body);
    print('**************datalogin******************');
    print(decodedData);
    if (decodedData.containsKey('idToken')) {
      _prefs.token = decodedData['idToken'];
      return {'ok': true};
    } else {
      return {'ok': false, 'mensaje': decodedData['error']['message']};
    }
  }

  Future<FormRegistro> getFormularioToken(String token) async {
    final url = '$_url/formRegistro/$token.json';
    final res = await http.get(url);
    final decodeData = json.decode(res.body);
    print('*****************************getobjeto*********************');
    print(decodeData);
    if (decodeData('idToken') == token) {
      final respuesta = decodeData.toString();
      print(respuesta);
    }
  }

  Future<Map<String, dynamic>> crearFormularioRegistro(
      String email, String password, FormRegistro formulario) async {
    final authdata = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    final url = '$_url/formRegistro.json';
    final respFormulario =
        await http.post(url, body: formRegistroToJson(formulario));
    final decodedDataRegistro = json.decode(respFormulario.body);
    print('Identificador del documento');
    print(decodedDataRegistro['name']);
    _prefs.idRegistro=decodedDataRegistro['name'];
    
    final prefs= new PreferenciasUsuario();
  await prefs. initPrefs();
  final prefM=new PreferenciasUsuario();
    print('este deberia ser el nombre');
    print(prefM.idRegistro);

    final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_tokenfb',
        body: json.encode(authdata));

    Map<String, dynamic> decodedData = json.decode(resp.body);
    print('Respuesta del servicio: https://identitytoolkit.googleapis.com');
    print(decodedData);
    if (decodedData.containsKey('idToken')) {
      _prefs.token = decodedData['idToken'];
      return {'ok': true};
    } else {
      return {'ok': false, 'mensaje': decodedData['error']['message']};
    }
  }
}
