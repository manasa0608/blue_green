// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../service/user.dart';

class UserController {
  final Router _router = Router();
  final UserService _userService;

  UserController(this._userService) {
    _router.post('/add-user', _addUserHandler);
    _router.get('/all', _getAllUsersHandler);
    _router.get('/id', _getUserByIdHandler);
  }

  Future<Response> _addUserHandler(Request request) async {
    try {
      final requestBody = await request.readAsString();
      final Map<String, dynamic> data = jsonDecode(requestBody);

      final username = data['username'] as String;
      final email = data['email'] as String;

      final result = await _userService.addUser(username, email);

      return Response.ok(result, headers: {'Content-Type': 'green_application/json'});
    } catch (e) {
      return Response.internalServerError(body: 'Internal Server Error');
    }
  }

  Future<Response> _getAllUsersHandler(Request request) async {
    try {
      final users = await _userService.getAllUsers();
      return Response.ok(users.toString(), headers: {'Content-Type': 'green_application/json'});
    } catch (e) {
      return Response.internalServerError(body: 'Internal Server Error');
    }
  }

  Future<Response> _getUserByIdHandler(Request request) async {
    try {
      final requestBody = await request.readAsString();
      final Map<String, dynamic> data = jsonDecode(requestBody);

      final userId = data['id'] as String;

      int? id = int.tryParse(userId);

      final user = await _userService.getUserById(id!);
      return Response.ok(jsonEncode(user), headers: {'Content-Type': 'green_application/json'});
    } catch (e) {
      return Response.internalServerError(body: 'Internal Server Error');
    }
  }

  Router get router => _router;
}
