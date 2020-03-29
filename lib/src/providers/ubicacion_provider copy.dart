import 'dart:convert';

import 'package:geografica_project/src/modelos/ubicacionModel.dart';
import 'package:http/http.dart' as http;
class UbicacionProvider{
  final String _url='https://notifications-f6e66.firebaseio.com';


Future <bool> crearFormulario(Ubicacion ubicacionactual) async{
  final url='$_url/ubicacion.json';
  final resp=await http.post(url,body: ubicacionToJson(ubicacionactual));
  final decodedData=json.decode(resp.body);
  print(decodedData);
  return true;

}
  
}