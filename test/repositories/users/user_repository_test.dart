import 'package:backend_sign_in/application/database/i_database_connection.dart';
import 'package:backend_sign_in/application/exceptions/user_not_found_exception.dart';
import 'package:backend_sign_in/models/user_model.dart';
import 'package:backend_sign_in/modules/sign_in/dtos/sign_in_request.dart';
import 'package:backend_sign_in/repositories/users/user_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mysql1/mysql1.dart';
import 'package:test/test.dart';

import '../../core/mysql/mock_database_connection.dart';
import '../../core/mysql/mock_mysql_connection.dart';
import '../../core/mysql/mock_mysql_results.dart';

void main() {
  test(
      'should login with email and password return Exception UserNotFoundException ...',
      () async {
    IDatabaseConnection database = MockDatabaseConnection();
    MySqlConnection mySqlConnection = MockMysqlConnection();
    Results results = MockMysqlResults([]);

    when(() => mySqlConnection.close()).thenAnswer((_) async => _);
    when(() => database.openConnection())
        .thenAnswer((_) async => mySqlConnection);
    when(() => mySqlConnection.query(any(), any()))
        .thenAnswer((_) async => results);

    final userRepository = UserRepository(database: database);

    final call = userRepository.login;

    expect(() => call(SignInRequest(email: 'email', password: 'password')),
        throwsA(isA<UserNotFoundException>()));
  });

  test('should login with email and password...', () async {
    IDatabaseConnection database = MockDatabaseConnection();
    MySqlConnection mySqlConnection = MockMysqlConnection();
    Results results = MockMysqlResults([
      {
        'cd_usuario': 1,
        'ds_email': 'email',
      }
    ]);

    when(() => mySqlConnection.close()).thenAnswer((_) async => _);
    when(() => database.openConnection())
        .thenAnswer((_) async => mySqlConnection);
    when(() => mySqlConnection.query(any(), any()))
        .thenAnswer((_) async => results);

    final userRepository = UserRepository(database: database);

    final userModel = await userRepository
        .login(SignInRequest(email: 'email', password: 'password'));

    final userExpected = UserModel(id: 1, email: 'email');

    expect(userModel, userExpected);
  });
}
