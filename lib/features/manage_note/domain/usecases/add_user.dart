import 'package:dartz/dartz.dart';
import 'package:notes/core/errors/failures.dart';
import 'package:notes/core/usecases/usecase.dart';
import 'package:notes/features/manage_note/domain/repositories/users_repository.dart';

class AddUser implements UseCase<bool, UserParam> {
  final UsersRepository usersRepository;

  AddUser({required this.usersRepository});
  @override
  Future<Either<Failure, bool>> call(UserParam params) {
    return usersRepository.insertUser(params);
    //update
  }
}
