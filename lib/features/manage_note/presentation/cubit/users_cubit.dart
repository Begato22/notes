import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:notes/core/errors/failures.dart';
import 'package:notes/core/usecases/usecase.dart';
import 'package:notes/core/utils/app_strings.dart';
import 'package:notes/features/manage_note/domain/entities/intrest.dart';
import 'package:notes/features/manage_note/domain/entities/user.dart';
import 'package:notes/features/manage_note/domain/usecases/add_user.dart';
import 'package:notes/features/manage_note/domain/usecases/get_all_intrests.dart';
import 'package:notes/features/manage_note/domain/usecases/get_all_users.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final GetAllUsers getAllUsersUseCase;
  final GetAllIntrests getAllIntrestsUseCase;
  final AddUser addUserUseCase;
  UsersCubit({
    required this.getAllUsersUseCase,
    required this.getAllIntrestsUseCase,
    required this.addUserUseCase,
  }) : super(UsersInitial());

  final ImagePicker imgpicker = ImagePicker();
  String imagepath = "";
  File? userImage;
  String? image64;

  Future<void> getAllUsers() async {
    emit(AllUsersIsLoading());
    Either<Failure, List<User>> response =
        await getAllUsersUseCase.call(NoParams());
    emit(
      response.fold(
        (failure) => AllUsersLoadedError(msg: _mapFailureToMsg(failure)),
        (users) => AllUsersLoadedSuccess(users: users),
      ),
    );
  }

  Future<void> getAllIntrests() async {
    emit(AllIntrestsIsLoading());
    Either<Failure, List<Intrest>> response =
        await getAllIntrestsUseCase.call(NoParams());
    emit(
      response.fold(
        (failure) => AllIntrestsLoadedError(msg: _mapFailureToMsg(failure)),
        (intrest) => AllIntrestsLoadedSuccess(intrest: intrest),
      ),
    );
  }

  Future<void> insertUser({
    required String username,
    required String password,
    required String email,
    required String intrestId,
    String? imageAsBase64,
  }) async {
    // emit(UpdateNoteIsLoading());
    Either<Failure, bool> response = await addUserUseCase.call(UserParam(
      username: username,
      password: password,
      email: email,
      intrestId: intrestId,
      imageAsBase64: imageAsBase64,
    ));
    emit(
      response.fold(
        (failure) => InsertUserError(msg: _mapFailureToMsg(failure)),

        (isInserted) {
          userImage=null;
          return InsertUserSuccess(isInserted: isInserted);
        },
      ),
    );
  }

  Future<String?> openImage() async {
    try {
      emit(AddImageLoading());
      var pickedFile = await imgpicker.pickImage(source: ImageSource.gallery);
      //you can use ImageCourse.camera for Camera capture
      if (pickedFile != null) {
        imagepath = pickedFile.path;
        //output /data/user/0/com.example.testapp/cache/image_picker7973898508152261600.jpg
        File imagefile = File(imagepath); //convert Path to File
        Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
        String base64string =
            base64.encode(imagebytes); //convert bytes to base64 string
        userImage = imagefile;
        emit(AddImageSuccess());
        getAllIntrests();
        return base64string;
      } else {
        debugPrint("No image is selected.");
        return null;
      }
    } catch (e) {
      debugPrint("error while picking file. $e");
      emit(AddImageError());
    }
    return null;
  }
}

String _mapFailureToMsg(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return AppStrings.serverFailure;
    case CashFailure:
      return AppStrings.cashFailure;
    default:
      return AppStrings.unexpectedFailure;
  }
}
