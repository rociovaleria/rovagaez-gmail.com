// To parse this JSON data, do
//
//     final formRegistro = formRegistroFromJson(jsonString);

import 'dart:convert';

FormRegistro formRegistroFromJson(String str) => FormRegistro.fromJson(json.decode(str));

String formRegistroToJson(FormRegistro data) => json.encode(data.toJson());

class FormRegistro {
    String id;
    String email;
    String nombre;
    String rol;
    String password;
    String token;
    String celular;
    FormRegistro({
        this.id,
        this.email="",
        this.nombre="",
        this.rol="",
        this.password="",
        this.token="",
        this.celular="60818849",
    });

    factory FormRegistro.fromJson(Map<String, dynamic> json) => FormRegistro(
        id: json["id"],
        email: json["email"],
        nombre: json["nombre"],
        rol: json["rol"],
        password: json["password"],
        token: json["token"],
        celular: json["celular"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "nombre": nombre,
        "rol": rol,
        "password": password,
        "token": token,
        "celular": celular
        
    };
}
