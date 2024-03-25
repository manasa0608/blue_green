import 'dart:collection';



import '../models/tree_node.dart';
import 'employees.dart';
import 'organization_builder.dart';

class OrganizationService {
  late final OrganizationBuilder _organizationBuilder;

  void printTreeLevels(TreeNode<Employee> root) {
    Queue<TreeNode<Employee>> queue = Queue();
    queue.add(root);

    while (queue.isNotEmpty) {
      int levelSize = queue.length;

      for (int i = 0; i < levelSize; i++) {
        TreeNode<Employee> current = queue.removeFirst();
        // print(current.data.personalDetails.name);

        for (TreeNode<Employee> child in current.children) {
          queue.add(child);
        }
      }
      // print("---- ----");
    }
  }

  void handleExitEmployee(TreeNode<Employee>? rootNode, int exitEmployeeId) {
    if (rootNode == null) {
      return;
    }

    markNodesForUpdate(rootNode, exitEmployeeId);

    updateNodes(rootNode, exitEmployeeId);

    printTreeLevels(rootNode);
  }

  void markNodesForUpdate(TreeNode<Employee> node, int exitEmployeeId) {
    if (node.data.id == exitEmployeeId) {
      node.data.updateRequired = true;
    }

    for (TreeNode<Employee> child in node.children) {
      markNodesForUpdate(child, exitEmployeeId); // Recursively mark child nodes
    }

    if (node.data.isManagingPeople) {
      for (int id in node.data.directReportees) {
        if (id == exitEmployeeId) {
          node.data.updateRequired = true;
          break;
        }
      }
    }
  }

  void updateNodes(TreeNode<Employee> node, int exitEmployeeId) {
    for (TreeNode<Employee> child in node.children) {
      updateNodes(child, exitEmployeeId);
    }

    if (node.data.updateRequired) {
      //if emp is manager
      if (node.data.managerId == exitEmployeeId) {
        TreeNode<Employee>? emp = findNodeById(node, node.data.managerId);
        node.data.managerId = emp!.data.managerId;
        node.data.updateRequired = false;
      }

      //manage exit employees manager data
      if (node.data.isManagingPeople && managesExitEmployee(node.data.directReportees, exitEmployeeId)) {
        removeExitEmployeeFromDirectReports(exitEmployeeId, node);
      }

      //delete node and update parent and child relation
      // if (node.data.id == exitEmployeeId) {
      //   deleteNodeAndUpdateRelations(exitEmployeeId, node);
      // }
    }
  }

  void deleteNodeAndUpdateRelations(int exitEmployeeId, TreeNode<Employee> nodeToDelete) {
    TreeNode<Employee>? rootNode = _organizationBuilder.getRootNode();
    TreeNode<Employee>? parentNode = findParentNode(rootNode!, exitEmployeeId);

    if (parentNode != null) {
      parentNode.children.remove(nodeToDelete);
    }

    for (TreeNode<Employee> child in nodeToDelete.children) {
      child.parent = parentNode;
    }

    nodeToDelete.parent = null;
  }

  TreeNode<Employee>? findParentNode(TreeNode<Employee> node, int exitEmployeeId) {
    for (TreeNode<Employee> child in node.children) {
      if (child.data.id == exitEmployeeId) {
        return node;
      }

      TreeNode<Employee>? foundNode = findParentNode(child, exitEmployeeId);
      if (foundNode != null) {
        return foundNode;
      }
    }

    return null;
  }

  TreeNode<Employee>? findNodeById(TreeNode<Employee> node, int id) {
    if (node.data.id == id) {
      return node;
    }

    for (TreeNode<Employee> child in node.children) {
      TreeNode<Employee>? result = findNodeById(child, id);
      if (result != null) {
        return result;
      }
    }

    return null;
  }

  bool managesExitEmployee(List<int> directReports, int exitEmployeeId) {
    for (int id in directReports) {
      if (id == exitEmployeeId) {
        return true;
      }
    }
    return false;
  }

  void removeExitEmployeeFromDirectReports(int exitEmployeeId, TreeNode<Employee> node) {
    final List<int> updatedDirectReportees = [];
    for (int id in node.data.directReportees) {
      if (id != exitEmployeeId) {
        updatedDirectReportees.add(id);
      }
    }

    node.data.directReportees = updatedDirectReportees;

    for (int i = 0; i < node.children.length; i++) {
      if (node.children[i].data.id == exitEmployeeId) {
        node.children.removeAt(i);
        break;
      }
    }

    node.data.updateRequired = false;
  }
}
