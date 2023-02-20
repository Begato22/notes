part of 'users_cubit.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersInitial extends UsersState {}

class AllUsersIsLoading extends UsersState {}

class AllUsersLoadedSuccess extends UsersState {
  final List<User> users;

  const AllUsersLoadedSuccess({required this.users});

  @override
  List<Object> get props => [users];
}

class AllUsersLoadedError extends UsersState {
  final String msg;

  const AllUsersLoadedError({required this.msg});

  @override
  List<Object> get props => [msg];
}

class AllIntrestsIsLoading extends UsersState {}

class AllIntrestsLoadedSuccess extends UsersState {
  final List<Intrest> intrest;

  const AllIntrestsLoadedSuccess({required this.intrest});

  @override
  List<Object> get props => [intrest];
}

class AllIntrestsLoadedError extends UsersState {
  final String msg;

  const AllIntrestsLoadedError({required this.msg});

  @override
  List<Object> get props => [msg];
}

class InsertUserIsLoading extends UsersState {}

class InsertUserSuccess extends UsersState {
  final bool isInserted;

  const InsertUserSuccess({required this.isInserted});

  @override
  List<Object> get props => [isInserted];
}

class InsertUserError extends UsersState {
  final String msg;

  const InsertUserError({required this.msg});

  @override
  List<Object> get props => [msg];
}
class AddImageLoading extends UsersState{}
class AddImageSuccess extends UsersState{}
class AddImageError extends UsersState{}
