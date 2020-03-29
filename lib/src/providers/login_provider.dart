import 'dart:convert';

import 'package:geografica_project/src/modelos/loginModel.dart';
import 'package:http/http.dart' as http;

class LoginProvider {
  final String _url = 'https://notifications-f6e66.firebaseio.com';

  Future<List<LoginModel>> cargarLogin() async {
    final url = '$_url/formRegistro.json';
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return [];
  }
}
