import 'package:dartz/dartz.dart';
import 'package:notes/core/errors/failures.dart';
import 'package:notes/core/usecases/usecase.dart';
import 'package:notes/features/manage_note/domain/entities/note.dart';
import 'package:notes/features/manage_note/domain/repositories/notes_repository.dart';

class GetAllNotes implements UseCase<List<Note>, NoParams> {
  final NotesRepository notesRepository;

  GetAllNotes({required this.notesRepository});
  @override
  Future<Either<Failure, List<Note>>> call(NoParams params) {
    return notesRepository.getAllNotes();
    //update
  }
}
