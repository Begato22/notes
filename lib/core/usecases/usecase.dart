import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:notes/core/errors/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class NoteParam extends Equatable {
  final String id;
  final String text;
  final String userId;
  final String placeDateTime;

  const NoteParam({
    required this.id,
    required this.text,
    required this.userId,
    required this.placeDateTime,
  });
  @override
  List<Object?> get props => [id, userId, text, placeDateTime];
}

class UserParam extends Equatable {
  const UserParam({
    required this.username,
    required this.password,
    required this.email,
    this.imageAsBase64,
    required this.intrestId,
  });

  final String username;
  final String password;
  final String email;
  final String? imageAsBase64;
  final String intrestId;
  @override
  List<Object?> get props =>
      [username, password, email, imageAsBase64, intrestId];
}
