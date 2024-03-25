import 'package:annotations/annotation.dart';
import 'package:blue_green_application/src/database/generic_database.dart';
import 'package:memory_cache/memory_cache.dart';

import '../models/generic_model.dart';
import '../repository/generic_repository.dart';

part 'generic_component_service.g.dart';

@Green
class GenericComponentService implements GenericComponentRepository<GenericComponent> {
  @override
  void sortComponents(List<GenericComponent> components) {
    if (components.isEmpty) {
      return;
    }

    if (components.first.data is int) {
      for (int i = 0; i < components.length - 1; i++) {
        for (int j = 0; j < components.length - i - 1; j++) {
          if ((components[j].data as int) > (components[j + 1].data as int)) {
            final temp = components[j];
            components[j] = components[j + 1];
            components[j + 1] = temp;
          }
        }
      }
    } else if (components.first.data is String) {
      for (int i = 0; i < components.length - 1; i++) {
        for (int j = 0; j < components.length - i - 1; j++) {
          if ((components[j].data as String).compareTo(components[j + 1].data as String) > 0) {
            final temp = components[j];
            components[j] = components[j + 1];
            components[j + 1] = temp;
          }
        }
      }
    } else {
      throw Exception('Invalid data type in components');
    }
  }

  @override
  void addComponentToDatabase(GenericComponent component) {
    List<GenericComponent> myValue = MemoryCache.instance.read<String>('generic_component') as List<GenericComponent>;
    myValue.add(component);
    MemoryCache.instance.update('generic_component', myValue);
    GenericDatabase.addGenericComponent(component);
  }

  @override
  void deleteComponentToDatabase(GenericComponent component) {
    List<GenericComponent> myValue = MemoryCache.instance.read<String>('generic_component') as List<GenericComponent>;
    myValue.remove(component);
    MemoryCache.instance.update('generic_component', myValue);
    GenericDatabase.deleteGenericComponent(component.id);
  }

  @override
  void generateComponents(List<GenericComponent> components) {}

  @override
  Future<List<GenericComponent>> getAllComponents() {
    Future<List<GenericComponent>> componentsList = GenericDatabase.getGenericComponents();
    MemoryCache.instance.create('generic_component', componentsList);
    return componentsList;
  }
}
