// ignore_for_file: unused_element

import 'dart:convert';

import 'package:blue_green_application/src/database/components_database.dart';
import 'package:blue_green_application/src/service/system_manager_service.dart';
import 'package:shelf/shelf.dart';

import '../../main.dart';
import '../models/component.dart';
import '../models/personal_details.dart';
import '../repository/service_layer.dart';
import '../database/database.dart';

class ComponentApiService {
  Future<Response> generateTreeHandler(Request request) async {
    ServiceLayer service = await SystemManagerService().selectSystemAndService(systemManager);
    final requestBody = await request.readAsString();
    final requestData = jsonDecode(requestBody);
    final randomTree = requestData['random'] as bool;
    final numberOfData = requestData['numberOfData'] as int;
    final numberOfLevels = requestData['numberOfLevels'] as int;
    final List<Component> generatedData;
    if (randomTree) {
      generatedData = service.createRandomDataForComponents(numberOfData, numberOfLevels);
    } else {
      generatedData = await ComponentDatabase.getAllComponents();
    }
    final root = service.buildTree(generatedData);

    if (root != null) {
      return Response.ok(jsonEncode({'success': true, 'message': 'Tree data generated successfully', 'tree': root.data}));
    } else {
      return Response.internalServerError(body: jsonEncode({'success': false, 'message': 'Failed to generate tree data'}));
    }
  }

  Future<Response> addComponent(Request request) async {
    try {
      ServiceLayer service = await SystemManagerService().selectSystemAndService(systemManager);
      final requestBody = await request.readAsString();
      final requestData = jsonDecode(requestBody);

      final int componentId = requestData['id'] as int;
      final int level = requestData['level'] as int;
      final String name = requestData['name'] as String;
      final String email = requestData['email'] as String;
      final List<int>? lowerComponents = requestData['listOfLowerComponentsId'] != null ? List<int>.from(requestData['listOfLowerComponentsId'] as List<dynamic>) : null;

      final List<int>? higherComponents =
          requestData['listOfHigherComponentsId'] != null ? List<int>.from(requestData['listOfHigherComponentsId'] as List<dynamic>) : null;

      final double amountAccountable = requestData['amountAccountable'] as double;

      final PersonalDetails personalDetails = PersonalDetails(name, email);
      final Component newComponent = Component(componentId, level, personalDetails, higherComponents!, lowerComponents!, amountAccountable);

      final List<Component> updatedComponents = service.addComponent(await ComponentDatabase.getAllComponents(), newComponent);
      ComponentDatabase.addComponent(newComponent);
      service.printComponents(updatedComponents);

      return Response.ok(jsonEncode({'success': true, 'message': 'Component added successfully', 'components': updatedComponents}));
    } catch (e) {
      return Response.internalServerError(body: jsonEncode({'success': false, 'message': 'Failed to add component: $e'}));
    }
  }

  Future<Response> deleteComponent(Request request) async {
    try {
      final requestBody = await request.readAsString();
      final requestData = jsonDecode(requestBody);

      final int componentId = requestData['id'] as int;
      ServiceLayer service = await SystemManagerService().selectSystemAndService(systemManager);

      service.deleteComponent(await ComponentDatabase.getAllComponents(), componentId);
      await ComponentDatabase.deleteComponent(componentId);

      return Response.ok(jsonEncode({'success': true, 'message': 'Component deleted successfully'}));
    } catch (e) {
      return Response.internalServerError(body: jsonEncode({'success': false, 'message': 'Failed to delete component: $e'}));
    }
  }

  Future<Response> sortComponents(Request request) async {
    try {
      ServiceLayer service = await SystemManagerService().selectSystemAndService(systemManager);

      List<Component> components = await ComponentDatabase.getAllComponents();

      service.quickSort(components, 0, components.length - 1);

      return Response.ok(jsonEncode({'success': true, 'message': 'Components sorted successfully', 'sortedComponents': components}));
    } catch (e) {
      return Response.internalServerError(body: jsonEncode({'success': false, 'message': 'Failed to sort components: $e'}));
    }
  }
}
