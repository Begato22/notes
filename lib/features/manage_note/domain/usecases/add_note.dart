import 'package:dartz/dartz.dart';
import 'package:notes/core/errors/failures.dart';
import 'package:notes/core/usecases/usecase.dart';
import 'package:notes/features/manage_note/domain/repositories/notes_repository.dart';

class AddNote implements UseCase<bool, NoteParam> {
  final NotesRepository notesRepository;

  AddNote({required this.notesRepository});
  @override
  Future<Either<Failure, bool>> call(NoteParam params) {
    return notesRepository.insertNote(params);
    //update
  }
}
