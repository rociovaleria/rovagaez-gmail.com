import 'dart:convert';

import 'package:geografica_project/src/modelos/formularioModel.dart';
import 'package:http/http.dart' as http;
class FormularioProvider{
  final String _url='https://notifications-f6e66.firebaseio.com';


Future <bool> crearFormulario(Formulario formulario) async{
  final url='$_url/formularios.json';
  final resp=await http.post(url,body: formularioToJson(formulario));
  final decodedData=json.decode(resp.body);
  print(decodedData);
  return true;

}
  
}