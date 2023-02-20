import 'package:notes/core/local%20database/app_local_database.dart';
import 'package:notes/core/usecases/usecase.dart';
import 'package:notes/features/manage_note/data/models/note_model.dart';

abstract class NotesLocalDataSource {
  Future<List<NoteModel>> getAllNotes();
  // Future<bool> updateNote(NoteParam noteParam);
  Future<bool> insertNote(NoteParam noteParam);
}

class NotesLocalDataSourceImpl implements NotesLocalDataSource {
  final SqlDb sqlDb;

  NotesLocalDataSourceImpl({required this.sqlDb});

  @override
  Future<List<NoteModel>> getAllNotes() async {
    final response = await sqlDb.readData('SELECT * FROM Notes');
    final note = noteModelFromJson(response);
    return note;
  }

  // @override
  // Future<bool> updateNote(NoteParam noteParam) async {
  //   final response = await apiConsumer.post(EndPoints.updateNote, body: {
  //     "Id": noteParam.id,
  //     "Text": noteParam.text,
  //     "UserId": noteParam.userId,
  //     "PlaceDateTime": "2021-11-18T09:39:44",
  //   });

  //   if (response
  //       .toString()
  //       .toLowerCase()
  //       .contains('Update Successfully'.toLowerCase())) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  @override
  Future<bool> insertNote(NoteParam noteParam) async {
    final response = await sqlDb.insertData(
        'INSERT INTO Notes(text, userId, placeDateTime) VALUES(?, ?, ?)',
        [noteParam.text, noteParam.userId, "2021-11-18T09:39:44"]);

    if (response is int) {
      return true;
    } else {
      return false;
    }
  }
}
