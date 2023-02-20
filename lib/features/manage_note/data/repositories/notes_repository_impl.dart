import 'package:notes/core/errors/exceptions.dart';
import 'package:notes/core/network/network_info.dart';
import 'package:notes/core/usecases/usecase.dart';
import 'package:notes/features/manage_note/data/datasources/notes_local_data_source.dart';
import 'package:notes/features/manage_note/data/datasources/notes_remote_data_source.dart';
import 'package:notes/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:notes/features/manage_note/presentation/cubit/options_cubit.dart';
import 'package:notes/injection_container.dart' as di;

import '../../domain/entities/note.dart';
import '../../domain/repositories/notes_repository.dart';

class NotesRepositoryImpl implements NotesRepository {
  final NetworkInfo networkInfo;
  final NotesRemoteDataSource notesRemoteDataSource;
  final NotesLocalDataSource notesLocalDataSource;

  NotesRepositoryImpl({
    required this.networkInfo,
    required this.notesRemoteDataSource,
    required this.notesLocalDataSource,
  });
  @override
  Future<Either<Failure, List<Note>>> getAllNotes() async {
    try {
      final allNotes = di.sl<OptionsCubit>().isLocalEnabled
          ? await notesLocalDataSource.getAllNotes()
          : await notesRemoteDataSource.getAllNotes();
      return Right(allNotes);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateNote(NoteParam noteParam) async {
    try {
      final isUpdated = await notesRemoteDataSource.updateNote(noteParam);
      return Right(isUpdated);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> insertNote(NoteParam noteParam) async {
    try {
      final isInserted = di.sl<OptionsCubit>().isLocalEnabled
          ? await notesLocalDataSource.insertNote(noteParam)
          : await notesRemoteDataSource.insertNote(noteParam);
      return Right(isInserted);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
