import 'models/component.dart';
import 'models/treeNode.dart';

abstract class ServiceLayer {
  TreeNode<Component>? buildTree(List<Component> components);

  List<Component> createRandomDataForComponents(int numberOfData, int numberOfLevels);

  void quickSort(List<Component> components, int low, int high);
}
