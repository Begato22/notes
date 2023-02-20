import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:notes/core/api/api_consumer.dart';
import 'package:notes/core/api/app_intercepters.dart';
import 'package:notes/core/api/dio_consumer.dart';
import 'package:notes/core/local%20database/app_local_database.dart';
import 'package:notes/core/network/network_info.dart';
import 'package:notes/core/utils/app_strings.dart';
import 'package:notes/features/manage_note/data/datasources/notes_local_data_source.dart';
import 'package:notes/features/manage_note/data/datasources/user_local_data_source.dart';
import 'package:notes/features/manage_note/data/datasources/user_remote_data_source.dart';
import 'package:notes/features/manage_note/data/repositories/users_repository_impl.dart';
import 'package:notes/features/manage_note/domain/repositories/users_repository.dart';
import 'package:notes/features/manage_note/domain/usecases/add_note.dart';
import 'package:notes/features/manage_note/domain/usecases/get_all_users.dart';
import 'package:notes/features/manage_note/presentation/cubit/users_cubit.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'features/manage_note/data/datasources/notes_remote_data_source.dart';
import 'features/manage_note/data/repositories/notes_repository_impl.dart';
import 'features/manage_note/domain/repositories/notes_repository.dart';
import 'features/manage_note/domain/usecases/add_user.dart';
import 'features/manage_note/domain/usecases/get_all_intrests.dart';
import 'features/manage_note/domain/usecases/get_all_notes.dart';
import 'features/manage_note/domain/usecases/update_notes.dart';
import 'features/manage_note/presentation/cubit/notes_cubit.dart';
import 'features/manage_note/presentation/cubit/options_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Blocs
  sl.registerFactory(
    () => NotesCubit(
      getAllNotesUseCase: sl(),
      updateNoteUseCase: sl(),
      addNoteUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => UsersCubit(
      getAllUsersUseCase: sl(),
      getAllIntrestsUseCase: sl(),
      addUserUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(() => OptionsCubit());

  //Use Cases
  sl.registerLazySingleton(() => GetAllNotes(notesRepository: sl()));
  sl.registerLazySingleton(() => UpdateNoteData(notesRepository: sl()));
  sl.registerLazySingleton(() => AddNote(notesRepository: sl()));
  sl.registerLazySingleton(() => GetAllUsers(userRepository: sl()));
  sl.registerLazySingleton(() => GetAllIntrests(userRepository: sl()));
  sl.registerLazySingleton(() => AddUser(usersRepository: sl()));

  //Repositories
  sl.registerLazySingleton<NotesRepository>(
    () => NotesRepositoryImpl(
      networkInfo: sl(),
      notesRemoteDataSource: sl(),
      notesLocalDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<UsersRepository>(
    () => UsersRepositoryImpl(
        networkInfo: sl(),
        userRemoteDataSource: sl(),
        userLocalDataSource: sl()),
  );

  //Data Sources
  sl.registerLazySingleton<NotesRemoteDataSource>(
      () => NotesRemoteDataSourceImpl(apiConsumer: sl()));
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(apiConsumer: sl()));
  sl.registerLazySingleton<NotesLocalDataSource>(
      () => NotesLocalDataSourceImpl(sqlDb: sl()));
  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(sqlDb: sl()));

  //Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));
  // sl.registerLazySingleton<SqlDb>(() => SqlDb());

  //External

  final sharedPreferences = await SharedPreferences.getInstance();
  if (AppStrings.databaseName.isNotEmpty) {
    await SqlDb().db;
    sl.registerLazySingleton<SqlDb>(() => SqlDb());
  }
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => AppIntercepters());
  sl.registerLazySingleton(
    () => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true,
    ),
  );
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
