// ignore_for_file: depend_on_referenced_packages

import 'package:example/src/controllers/organization_controller.dart';
import 'package:example/src/controllers/user_controller.dart';
import 'package:example/src/service/organization_service.dart';
import 'package:example/src/service/user_service.dart';
import 'package:example/src/utils/organization_builder.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';


void main() async {
  final userService = UserService();
  final userController = UserController(userService);

  final organizationService = OrganizationService();
  final organizationBuilder = OrganizationBuilder();
  final organizationController =
      OrganizationController(organizationService, organizationBuilder);

  final app = Router();
  app.mount('/users/', userController.router);

  app.mount('/org/', organizationController.router);

  final handler = const Pipeline().addMiddleware(logRequests()).addHandler(app);

  await io.serve(handler, 'localhost', 8080);
}
