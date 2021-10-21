import 'package:backend_sign_in/application/database/i_database_connection.dart';
import 'package:mysql1/mysql1.dart';

class DatabaseConnection implements IDatabaseConnection {

  const DatabaseConnection();

  @override
  Future<MySqlConnection> openConnection() async {
    return MySqlConnection.connect(
      ConnectionSettings(
          host: 'localhost',
          port: 3306,
          user: 'root',
          password: 'academiadoflutter',
          db: 'expert_club'),
    );
  }
}
