import 'package:blue_green_application/src/models/generic_model.dart';
import 'package:postgres/postgres.dart';

import 'database.dart';

class GenericDatabase {
  static Future<List<GenericComponent<T>>> getGenericComponents<T>() async {
    final connection = await Database.getConnection();
    List<GenericComponent<T>> componentList = [];
    try {
      final result = await connection.execute('SELECT * FROM generic_components');

      for (final row in result) {
        final id = row[0] as T;
        final data = row[1]['data'] as T;
        final lowerComponents = (row[2] as List).cast<T>();
        final higherComponents = (row[3] as List).cast<T>();

        final component = GenericComponent<T>(data, lowerComponents, higherComponents, id);
        componentList.add(component);
      }
      return componentList;
    } catch (e) {
      throw Exception('Failed to fetch components');
    } finally {
      await connection.close();
    }
  }

  static Future<String> addGenericComponent<T>(GenericComponent<T> component) async {
    final connection = await Database.getConnection();
    try {
      final result = await connection.execute(
        Sql.named('INSERT INTO generic_components (data, lowerComponents, higherComponents, id) VALUES (@data, @lowerComponents, @higherComponents, @id)'),
        parameters: {
          'data': component.data,
          'lowerComponents': component.lowerComponents,
          'higherComponents': component.higherComponents,
          'id': component.id,
        },
      );
      if (result != null) {
        return 'Component added successfully';
      } else {
        return 'Empty result';
      }
    } catch (e) {
      return 'Failed to add component: $e';
    } finally {
      await connection.close();
    }
  }

  static Future<String> deleteGenericComponent<T>(T componentId) async {
    final connection = await Database.getConnection();
    try {
      final result = await connection.execute(
        Sql.named('DELETE FROM generic_components WHERE id = @id'),
        parameters: {'id': componentId},
      );
      if (result != null) {
        return 'Component deleted successfully';
      } else {
        return 'Empty result';
      }
    } catch (e) {
      return 'Failed to delete component: $e';
    } finally {
      await connection.close();
    }
  }
}
