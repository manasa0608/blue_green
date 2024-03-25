import '../models/component.dart';
import '../models/tree_node.dart';

abstract class ServiceLayer {
  TreeNode<Component>? buildTree(List<Component> components);

  List<Component> createRandomDataForComponents(int numberOfData, int numberOfLevels);

  void quickSort(List<Component> components, int low, int high);

  void printComponents(List<Component> components);

  List<Component> addComponent(List<Component> components, Component componentToBeAdded);

  void deleteComponent(List<Component> components, int componentId);
}
