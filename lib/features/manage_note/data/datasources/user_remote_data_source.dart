import 'package:notes/core/api/api_consumer.dart';
import 'package:notes/core/api/end_points.dart';
import 'package:notes/core/usecases/usecase.dart';
import 'package:notes/features/manage_note/data/models/intrest_model.dart';
import 'package:notes/features/manage_note/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getAllUsers();
  Future<List<IntrestModel>> getAllIntrests();
  Future<bool> insertUser(UserParam noteParam);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiConsumer apiConsumer;

  UserRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<UserModel>> getAllUsers() async {
    final response = await apiConsumer.get(EndPoints.getAllUsers);
    final users = userModelFromJson(response);
    return users;
  }

  @override
  Future<List<IntrestModel>> getAllIntrests() async {
    final response = await apiConsumer.get(EndPoints.getAllIntrests);
    final intrests = intrestModelFromJson(response);
    return intrests;
  }

  @override
  Future<bool> insertUser(UserParam param) async {
    final response = await apiConsumer.post(
      EndPoints.insertUser,
      body: {
        "Username": param.username,
        "Password": param.password,
        "Email": param.email,
        "ImageAsBase64": param.imageAsBase64,
        "IntrestId": param.intrestId,
      },
    );
    if (response
        .toString()
        .toLowerCase()
        .contains('Inserted Successfully'.toLowerCase())) {
      return true;
    } else {
      return false;
    }
  }
}
