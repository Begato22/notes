import 'package:flutter/material.dart';
import 'package:notes/core/errors/exceptions.dart';
import 'package:notes/core/network/network_info.dart';
import 'package:notes/core/usecases/usecase.dart';

import 'package:notes/features/manage_note/data/datasources/user_local_data_source.dart';
import 'package:notes/features/manage_note/data/datasources/user_remote_data_source.dart';
import 'package:notes/features/manage_note/domain/entities/intrest.dart';
import 'package:notes/features/manage_note/domain/entities/user.dart';
import 'package:notes/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:notes/features/manage_note/domain/repositories/users_repository.dart';
import 'package:notes/features/manage_note/presentation/cubit/options_cubit.dart';
import 'package:notes/injection_container.dart' as di;

class UsersRepositoryImpl implements UsersRepository {
  final NetworkInfo networkInfo;
  final UserRemoteDataSource userRemoteDataSource;
  final UserLocalDataSource userLocalDataSource;

  const UsersRepositoryImpl({
    required this.networkInfo,
    required this.userRemoteDataSource,
    required this.userLocalDataSource,
  });
  @override
  Future<Either<Failure, List<User>>> getAllUsers() async {
    try {
      debugPrint('==========${di.sl<OptionsCubit>().isLocalEnabled}==========');
      final allUsers = di.sl<OptionsCubit>().isLocalEnabled
          ? await userLocalDataSource.getAllUsers()
          : await userRemoteDataSource.getAllUsers();
      return Right(allUsers);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Intrest>>> getAllIntrests() async {
    try {
      final allIntrests = await userRemoteDataSource.getAllIntrests();
      return Right(allIntrests);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> insertUser(UserParam param) async {
    try {
      final isInserted = di.sl<OptionsCubit>().isLocalEnabled
          ? await userLocalDataSource.insertUser(param)
          : await userRemoteDataSource.insertUser(param);
      return Right(isInserted);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
