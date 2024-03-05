import 'dart:math';

import 'package:example/src/models/component.dart';
import 'package:example/src/models/treeNode.dart';
import 'package:example/src/serviceLayer.dart';

import '../models/personal_details.dart';

class ComponentServiceGreen implements ServiceLayer {
  Random random = Random();

  late List<Component> sortedNodes = [];

  @override
  TreeNode<Component>? buildTree(List<Component> components) {
    Map<int, TreeNode<Component>> nodeMap = {};

    for (var component in components) {
      TreeNode<Component> node = TreeNode(component);
      nodeMap[component.id] = node;
    }

    for (var component in components) {
      TreeNode<Component>? currentNode = nodeMap[component.id];
      for (var lowerId in component.listOfLowerComponentsId) {
        TreeNode<Component>? lowerNode = nodeMap[lowerId];
        if (lowerNode != null && !currentNode!.children.contains(lowerNode)) {
          currentNode.children.add(lowerNode);
        }
      }
      for (var higherId in component.listOfHigherComponentsId) {
        TreeNode<Component>? higherNode = nodeMap[higherId];
        if (higherNode != null && !higherNode.children.contains(currentNode)) {
          higherNode.children.add(currentNode!);
        }
      }
    }

    TreeNode<Component>? rootNode;
    for (var node in nodeMap.values) {
      if (node.parent == null) {
        rootNode = node;
        continue;
      }
    }
    return rootNode;
  }

  void printTree(TreeNode<Component> node, [int level = 1]) {
    print('${'|   ' * level}+-- ${node.data.personalDetails.name}');

    for (var child in node.children) {
      printTree(child, level + 1);
    }
  }

  @override
  void quickSort(List<Component> components, int low, int high) {
    if (low < high) {
      int pi = partition(components, low, high);

      quickSort(components, low, pi - 1);
      quickSort(components, pi + 1, high);
    }
  }

  int partition(List<Component> components, int low, int high) {
    double pivot = components[high].amountAccountable;
    int i = low - 1;

    for (int j = low; j < high; j++) {
      if (components[j].amountAccountable < pivot) {
        i++;
        Component temp = components[i];
        components[i] = components[j];
        components[j] = temp;
      }
    }

    Component temp = components[i + 1];
    components[i + 1] = components[high];
    components[high] = temp;

    return i + 1;
  }

  void sortBasedOnLevel(List<Component> components, int level) {
    List<Component> filteredComponents = [];

    for (Component component in components) {
      if (component.level == level) {
        filteredComponents.add(component);
      }
    }

    quickSort(filteredComponents, 0, filteredComponents.length - 1);
    printComponents(filteredComponents);
  }

  void printComponents(List<Component> components) {
    for (Component component in components) {
      print("${component.personalDetails.name}-${component.amountAccountable}-${component.listOfHigherComponentsId}--${component.listOfLowerComponentsId}");
    }
  }

  @override
  List<Component> createRandomDataForComponents(int numberOfData, int numberOfLevels) {
    /*
      * divide the number of data into different levels, do 1:2:3:4 ratio format
      * start from the higher level and create one data and choose the amount between 100-20000. higher level = numberOfLevels
      * create lower levels and divide the amount among them, numberOfLevels--
      * for each lower level add sub levels until numberOfLevels becomes 0
      * */

    print("hello green system");

    List<Component> generatedData = [];
    double amount = generateRandomAmountValue();
    PersonalDetails personalDetailsValue = PersonalDetails("name$numberOfData", "email$numberOfData");
    Component higherComponent = Component(numberOfData, numberOfLevels, personalDetailsValue, [], [], amount);

    // checks
    if (numberOfData == numberOfLevels) {
      generatedData = createOneDataForEachLevel(numberOfData);
    } else if (numberOfData == numberOfLevels && numberOfData == 1) {
      generatedData.add(higherComponent);
    } else if (numberOfData < numberOfLevels) {
      throw Exception("Incorrect data format- Please ensure data count is greater then number of levels");
    } else {
      generatedData = createDataAtLevels(numberOfData, numberOfLevels);
    }
    for (var component in generatedData) {
      print(component.toJson());
    }

    return generatedData;
  }

  List<Component> createOneDataForEachLevel(int dataCount) {
    List<Component> components = [];
    int level = 1;
    int highestLevel = dataCount;
    double amount = generateRandomAmountValue();

    for (int i = 1; i <= dataCount; i++) {
      PersonalDetails personalDetails = PersonalDetails("Name$i", "email$i");

      // Determine higher and lower components based on the current level
      List<int> listOfHigherComponentsId = [];
      if (level != highestLevel) {
        listOfHigherComponentsId.add(level + 1);
      }

      List<int> listOfLowerComponentsId = [];
      if (level != 1) {
        listOfLowerComponentsId.add(level - 1);
      }

      Component component = Component(i, level, personalDetails, listOfHigherComponentsId, listOfLowerComponentsId, amount);
      components.add(component);
      level++;
    }
    return components;
  }

  List<Component> createDataAtLevels(int numberOfData, int numberOfLevels) {
    List<Component> components = [];
    int currentId = 1;
    double amount = generateRandomAmountValue();

    int totalComponents = 0;
    for (int level = 1; level <= numberOfLevels; level++) {
      totalComponents += level;
    }

    for (int level = 1; level <= numberOfLevels; level++) {
      int componentsForThisLevel = (numberOfData * level / totalComponents).round();

      if (componentsForThisLevel == 0) {
        componentsForThisLevel = 1;
      }

      if (currentId + componentsForThisLevel > numberOfData) {
        componentsForThisLevel = numberOfData - currentId + 1;
      }

      for (int i = 0; i < componentsForThisLevel; i++) {
        PersonalDetails personalDetails = PersonalDetails("Name$currentId", "email$currentId");
        Component component = Component(currentId, numberOfLevels - level + 1, personalDetails, [], [], amount);
        components.add(component);

        currentId++;
      }
    }

    createLevelCombinations(components);
    return components;
  }

  void createLevelCombinations(List<Component> components) {
    // Get all unique levels
    Set<int> uniqueLevels = components.map((component) => component.level).toSet();
    components.sort((a, b) => a.level.compareTo(b.level));
    Map<int, List<Component>> levelCombinations = {};

    for (var level in uniqueLevels) {
      levelCombinations[level] = [];
    }
    for (var component in components) {
      levelCombinations[component.level]!.add(component);
    }
    return distributeLowerLevels(levelCombinations);
  }

  void distributeLowerLevels(Map<int, List<Component>> levelCombinations) {
    for (var level = 1; level < levelCombinations.length; level++) {
      var lowerLevelComponents = levelCombinations[level]!;
      var higherLevelComponents = levelCombinations[level + 1]!;
      var lowerComponentsPerHigherComponent = lowerLevelComponents.length ~/ higherLevelComponents.length;
      for (var higherObjectComponent in higherLevelComponents) {
        higherObjectComponent.amountAccountable = 0;
      }
      // Distribute the lower-level components among the higher-level components
      for (var i = 0; i < higherLevelComponents.length; i++) {
        var startIds = i * lowerComponentsPerHigherComponent;
        var endIds = (i + 1) * lowerComponentsPerHigherComponent;
        for (var j = startIds; j < endIds && j < lowerLevelComponents.length; j++) {
          var lowerLevelComponent = lowerLevelComponents[j];
          higherLevelComponents[i].amountAccountable += lowerLevelComponent.amountAccountable;
          higherLevelComponents[i].listOfLowerComponentsId.add(lowerLevelComponent.id);
          lowerLevelComponent.listOfHigherComponentsId.add(higherLevelComponents[i].id);
        }
      }
    }
  }

  void assignMoneyDivisionValues(Map<int, List<Component>> levelCombinations) {}

  double generateRandomAmountValue() {
    return (random.nextInt(20001 - 100) + 100).toDouble().roundToDouble();
  }
}
