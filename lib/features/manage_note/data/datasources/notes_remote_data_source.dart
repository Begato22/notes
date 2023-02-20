import 'package:notes/core/api/api_consumer.dart';
import 'package:notes/core/api/end_points.dart';
import 'package:notes/core/usecases/usecase.dart';
import 'package:notes/features/manage_note/data/models/note_model.dart';

abstract class NotesRemoteDataSource {
  Future<List<NoteModel>> getAllNotes();
  Future<bool> updateNote(NoteParam noteParam);
  Future<bool> insertNote(NoteParam noteParam);
}

class NotesRemoteDataSourceImpl implements NotesRemoteDataSource {
  final ApiConsumer apiConsumer;

  NotesRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<NoteModel>> getAllNotes() async {
    final response = await apiConsumer.get(EndPoints.getAllNotes);
    final note = noteModelFromJson(response);
    return note;
  }

  @override
  Future<bool> updateNote(NoteParam noteParam) async {
    final response = await apiConsumer.post(EndPoints.updateNote, body: {
      "Id": noteParam.id,
      "Text": noteParam.text,
      "UserId": noteParam.userId,
      "PlaceDateTime": "2021-11-18T09:39:44",
    });

    if (response
        .toString()
        .toLowerCase()
        .contains('Update Successfully'.toLowerCase())) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> insertNote(NoteParam noteParam) async {
    final response = await apiConsumer.post(EndPoints.insertNote, body: {
      "Text": noteParam.text,
      "UserId": noteParam.userId,
      "PlaceDateTime": "2021-11-18T09:39:44",
    });
    if (response
        .toString()
        .toLowerCase()
        .contains('Inserted Successfully'.toLowerCase())) {
      return true;
    } else {
      return false;
    }
  }
}
