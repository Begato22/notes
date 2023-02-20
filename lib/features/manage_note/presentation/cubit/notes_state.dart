part of 'notes_cubit.dart';

abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

class NotesInitial extends NotesState {}

class AllNotesIsLoading extends NotesState {}

class AllNotesLoadedSuccess extends NotesState {
  final List<Note> note;

  const AllNotesLoadedSuccess({required this.note});

  @override
  List<Object> get props => [note];
}

class AllNotesLoadedError extends NotesState {
  final String msg;

  const AllNotesLoadedError({required this.msg});

  @override
  List<Object> get props => [msg];
}

class UpdateNoteIsLoading extends NotesState {}

class UpdateNoteSuccess extends NotesState {
  final bool isUpdated;

  const UpdateNoteSuccess({required this.isUpdated});

  @override
  List<Object> get props => [isUpdated];
}

class UpdateNoteError extends NotesState {
  final String msg;

  const UpdateNoteError({required this.msg});

  @override
  List<Object> get props => [msg];
}

class InsertNoteIsLoading extends NotesState {}

class InsertNoteSuccess extends NotesState {
  final bool isInserted;

  const InsertNoteSuccess({required this.isInserted});

  @override
  List<Object> get props => [isInserted];
}

class InsertNoteError extends NotesState {
  final String msg;

  const InsertNoteError({required this.msg});

  @override
  List<Object> get props => [msg];
}

class SearchedInListInit extends NotesState {}
class SearchedInListDone extends NotesState {}
