import 'package:postgres/postgres.dart';

import '../models/component.dart';
import '../models/personal_details.dart';
import 'database.dart';

class ComponentDatabase{
  static Future<List<Component>> getAllComponents() async {
    final connection = await Database.getConnection();
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
    final connection = await Database.getConnection();
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
    final connection = await Database.getConnection();
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