import 'package:blue_green_application/src/database/database.dart';
import 'package:postgres/postgres.dart';

import '../user_code/user.dart';

class UserDatabase {
  static Future<Map<String, dynamic>> getUserDetails(int userId) async {
    final connection = await Database.getConnection();
    try {
      final result = await connection.execute(
        Sql.named('SELECT * FROM users WHERE id = @id'),
        parameters: {'id': userId},
      );

      if (result.isNotEmpty) {
        final user = User(
          result[0][0] as int,
          result[0][1] as String,
          result[0][2] as String,
        );

        return user.toJson();
      } else {
        return {};
      }
    } catch (e) {
      rethrow;
    } finally {
      await connection.close();
    }
  }

  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    List<User> _userList = [];
    final connection = await Database.getConnection();
    try {
      final result = await connection.execute('SELECT * FROM users');
      for (final row in result) {
        final user = User(row[0] as int, row[1] as String, row[2] as String);
        _userList.add(user);
      }
      return _userList.map((user) => user.toJson()).toList();
    } catch (e) {
      throw Exception('Failed to users config');
    } finally {
      await connection.close();
    }
  }

  static Future<String> addUser(String username, String email) async {
    final connection = await Database.getConnection();
    try {
      final result = connection.execute(Sql.named('Insert into users (username, email) VALUES  (@username, @email)'), parameters: {'username': username, 'email': email});
      if (result != null) {
        return 'User added successfully';
      } else {
        return "empty result";
      }
    } catch (e) {
      return 'Failed to add user';
    } finally {
      await connection.close();
    }
  }
}
