import 'package:backend_sign_in/application/database/database_connection.dart';
import 'package:backend_sign_in/application/database/i_database_connection.dart';
import 'package:backend_sign_in/application/exceptions/user_not_found_exception.dart';
import 'package:backend_sign_in/application/helpers/cripty_helper.dart';
import 'package:backend_sign_in/models/user_model.dart';
import 'package:backend_sign_in/modules/sign_in/dtos/sign_in_request.dart';
import 'package:mysql1/mysql1.dart';

class UserRepository {

  IDatabaseConnection database;

  UserRepository({this.database = const DatabaseConnection()});

  Future<UserModel> login(SignInRequest request) async {
    MySqlConnection? conn;
    
    try {
      // MysqlConnection
      conn = await database.openConnection();
      // Results
      final result = await conn.query('''
        select *
        from usuario
        where ds_email = ?
        and ds_senha = ?
      ''', [request.email, CriptyHelper.generateSha256Hash(request.password)]);

      if(result.isEmpty) {
        throw UserNotFoundException();
      }

      // ResultRow
      final resultData = result.first;
      return UserModel(id: resultData['cd_usuario'], email: resultData['ds_email']);

    } on MySqlException catch (e, s) {
      print(e);
      print(s);
      throw Exception();
    } finally {
      await conn?.close();
    }

  }
}
