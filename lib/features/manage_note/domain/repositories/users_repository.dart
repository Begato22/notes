import 'package:dartz/dartz.dart';
import 'package:notes/core/errors/failures.dart';
import 'package:notes/core/usecases/usecase.dart';
import 'package:notes/features/manage_note/domain/entities/user.dart';

import '../entities/intrest.dart';

abstract class UsersRepository {
  Future<Either<Failure, List<User>>> getAllUsers();
  Future<Either<Failure, List<Intrest>>> getAllIntrests();
  Future<Either<Failure, bool>> insertUser(UserParam noteParam);
}
