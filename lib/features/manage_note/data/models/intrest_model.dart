// To parse this JSON data, do
//
//     final intrestModel = intrestModelFromJson(jsonString);

import 'dart:convert';

import 'package:notes/features/manage_note/domain/entities/intrest.dart';

List<IntrestModel> intrestModelFromJson(List<dynamic> list) =>
    List<IntrestModel>.from(list.map((x) => IntrestModel.fromJson(x)));

String intrestModelToJson(List<IntrestModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IntrestModel extends Intrest {
  const IntrestModel({
    required String id,
    required String intrestText,
  }) : super(id: id, intrestText: intrestText);

  factory IntrestModel.fromJson(Map<String, dynamic> json) => IntrestModel(
        intrestText: json["intrestText"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "intrestText": intrestText,
        "id": id,
      };
}
