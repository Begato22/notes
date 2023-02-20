import 'package:notes/core/local%20database/app_local_database.dart';
import 'package:notes/core/usecases/usecase.dart';
import 'package:notes/features/manage_note/data/models/user_model.dart';

abstract class UserLocalDataSource {
  Future<List<UserModel>> getAllUsers();
  // Future<List<IntrestModel>> getAllIntrests();
  Future<bool> insertUser(UserParam noteParam);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SqlDb sqlDb;

  UserLocalDataSourceImpl({required this.sqlDb});

  @override
  Future<List<UserModel>> getAllUsers() async {
    final response = await sqlDb.readData('SELECT * FROM User');
    final users = userModelFromJson(response);
    return users;
  }

  // @override
  // Future<List<IntrestModel>> getAllIntrests() async {
  //   final response = await apiConsumer.get(EndPoints.getAllIntrests);
  //   final intrests = intrestModelFromJson(response);
  //   return intrests;
  // }

  @override
  Future<bool> insertUser(UserParam param) async {
    final response = await sqlDb.insertData(
        'INSERT INTO User(userName, password, email, imageAsBase64, intrestId ) VALUES(?,?,?,?,?)',
        [
          param.username,
          param.password,
          param.email,
          param.imageAsBase64,
          param.intrestId,
        ]);
    if (response is num) {
      return true;
    } else {
      return false;
    }
  }
}
