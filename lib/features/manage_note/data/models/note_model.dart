// To parse this JSON data, do
//
//     final quote = quoteFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/note.dart';

// To parse this JSON data, do
//
//     final note = noteFromJson(jsonString);
// To parse this JSON data, do
//
//     final noteModel = noteModelFromJson(jsonString);

List<NoteModel> noteModelFromJson(List<dynamic> list) =>
    List<NoteModel>.from(list.map((x) => NoteModel.fromJson(x)));

String noteModelToJson(List<NoteModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NoteModel extends Note {
  const NoteModel({
    required String text,
    required DateTime placeDateTime,
    String? userId,
    required String id,
  }) : super(
          id: id,
          placeDateTime: placeDateTime,
          text: text,
          userId: userId,
        );

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
        text: json["text"],
        placeDateTime: DateTime.parse(json["placeDateTime"]),
        userId: json["userId"],
        id: json["id"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "placeDateTime": placeDateTime.toIso8601String(),
        "userId": userId,
        "id": id,
      };
}
