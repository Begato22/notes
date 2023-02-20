import 'package:dartz/dartz.dart';
import 'package:notes/core/errors/failures.dart';
import 'package:notes/core/usecases/usecase.dart';
import 'package:notes/features/manage_note/domain/repositories/users_repository.dart';

import '../entities/intrest.dart';

class GetAllIntrests implements UseCase<List<Intrest>, NoParams> {
  final UsersRepository userRepository;

  GetAllIntrests({required this.userRepository});
  @override
  Future<Either<Failure, List<Intrest>>> call(NoParams params) {
    return userRepository.getAllIntrests();
  }
}
