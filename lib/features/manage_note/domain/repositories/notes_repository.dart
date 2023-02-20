import 'package:dartz/dartz.dart';
import 'package:notes/core/errors/failures.dart';
import 'package:notes/core/usecases/usecase.dart';
import 'package:notes/features/manage_note/domain/entities/note.dart';

abstract class NotesRepository {
  Future<Either<Failure, List<Note>>> getAllNotes();
  Future<Either<Failure, bool>> insertNote(NoteParam noteParam);
  Future<Either<Failure, bool>> updateNote(NoteParam noteParam);
}
