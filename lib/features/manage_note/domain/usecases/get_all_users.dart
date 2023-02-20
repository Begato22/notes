import 'package:dartz/dartz.dart';
import 'package:notes/core/errors/failures.dart';
import 'package:notes/core/usecases/usecase.dart';
import 'package:notes/features/manage_note/domain/entities/user.dart';
import 'package:notes/features/manage_note/domain/repositories/users_repository.dart';

class GetAllUsers implements UseCase<List<User>, NoParams> {
  final UsersRepository userRepository;

  GetAllUsers({required this.userRepository});
  @override
  Future<Either<Failure, List<User>>> call(NoParams params) {
    return userRepository.getAllUsers();
  }
}
