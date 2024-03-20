// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:example/src/utils/constants.dart';
import 'package:postgres/postgres.dart';

import '../models/component.dart';
import '../models/personal_details.dart';
import '../models/user.dart';

class Database {
  static getConnection() {
    return Connection.open(
      Endpoint(
        host: host,
        database: database,
        username: username,
        password: password,
      ),
      settings: const ConnectionSettings(sslMode: SslMode.disable),
    );
  }

  static Future<Map<String, dynamic>> getUserDetails(int userId) async {
    final connection = await getConnection();

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
    final connection = await getConnection();
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
    final connection = await getConnection();
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

  static Future<List<Component>> getAllComponents() async {
    final connection = await getConnection();
    List<Component> componentList = [];
    try {
      final result = await connection.execute('SELECT * FROM components_test');

      for (final row in result) {
        final component = Component(
            row[0] as int,
            row[1] as int,
            PersonalDetails(
              row[2] as String,
              row[3] as String,
            ),
            (row[4] as List<dynamic>?)?.cast<int>() ?? [],
            (row[5] as List<dynamic>?)?.cast<int>() ?? [],
            row[6] as double);
        componentList.add(component);
      }
      return componentList;
    } catch (e) {
      throw Exception('Failed to fetch components');
    } finally {
      await connection.close();
    }
  }

  static Future<String> addComponent(Component component) async {
    final connection = await getConnection();
    try {
      final result = await connection.execute(
          Sql.named(
              'INSERT INTO components (id, level, name, email, lower_components, higher_components, amount) VALUES (@id, @level, @name, @email, @lower_components, @higher_components, @amount)'),
          parameters: {
            'id': component.id,
            'level': component.level,
            'name': component.personalDetails.name,
            'email': component.personalDetails.email,
            'lower_components': component.listOfHigherComponentsId,
            'higher_components': component.listOfLowerComponentsId,
            'amount': component.amountAccountable
          });
      if (result != null) {
        return 'Component added successfully';
      } else {
        return "empty result";
      }
    } catch (e) {
      return 'Failed to add component';
    } finally {
      await connection.close();
    }
  }

  static Future<String> deleteComponent(int componentId) async {
    final connection = await getConnection();
    try {
      final result = await connection.execute(Sql.named('DELETE FROM components WHERE id = @id'), parameters: {'id': componentId});
      if (result != null) {
        return 'Component deleted successfully';
      } else {
        return "empty result";
      }
    } catch (e) {
      return 'Failed to delete component';
    } finally {
      await connection.close();
    }
  }
}
