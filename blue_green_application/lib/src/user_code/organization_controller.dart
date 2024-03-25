// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'employees.dart';
import '../models/tree_node.dart';
import 'organization_service.dart';
import 'organization_builder.dart';

class OrganizationController {
  final Router _router = Router();
  late final OrganizationService _organizationService;
  late final OrganizationBuilder _organizationBuilder;

  OrganizationController(this._organizationService, this._organizationBuilder) {
    _router.get('/teams', _getEmployeesHandler);
    _router.post('/exit', _exitEmployeeHandler);
  }

  Future<Response> _getEmployeesHandler(Request request) async {
    try {
      TreeNode<Employee>? root = _organizationBuilder.getRootNode();
      _organizationService.printTreeLevels(root!);

      return Response.ok("DONE");
    } catch (e) {
      return Response.internalServerError(body: 'Internal Server Error');
    }
  }

  Future<Response> _exitEmployeeHandler(Request request) async {
    try {
      String requestBody = await request.readAsString();
      Map<String, dynamic> requestBodyJson = jsonDecode(requestBody);

      int exitEmployeeId = requestBodyJson['exitEmployeeId'];

      _organizationService.handleExitEmployee(_organizationBuilder.getRootNode(), exitEmployeeId);

      return Response.ok("DONE");
    } catch (e) {
      return Response.internalServerError(body: 'Internal Server Error');
    }
  }

  Router get router => _router;
}
