import 'dart:convert';

import 'package:notes/features/manage_note/domain/entities/user.dart';

List<UserModel> userModelFromJson(List<dynamic> list) =>
    List<UserModel>.from(list.map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel extends User {
  const UserModel({
    required super.username,
    required super.password,
    required super.email,
    super.imageAsBase64,
    required super.interestId,
    required super.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json["username"],
        password: json["password"],
        email: json["email"],
        imageAsBase64: json["imageAsBase64"],
        interestId: json["intrestId"],
        id: json["id"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "email": email,
        "imageAsBase64": imageAsBase64,
        "intrestId": interestId,
        "id": id,
      };
}
