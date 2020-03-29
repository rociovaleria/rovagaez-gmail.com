// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    String id;
    String email;
    String password;

    LoginModel({
        this.id="",
        this.email="",
        this.password="",
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        id: json["id"],
        email: json["usuario"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
    };
}
