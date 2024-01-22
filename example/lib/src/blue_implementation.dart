import 'package:example/src/service/organization_service.dart';
import 'package:example/src/service/user_service.dart';
import 'package:example/src/utils/organization_builder.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

import 'blue_service.dart';
import 'controllers/organization_controller.dart';
import 'controllers/user_controller.dart';

class BlueServiceImpl implements BlueServiceInterface {
  @override
  void blueOperation() async {
    final userService = UserService();
    final userController = UserController(userService);

    final organizationService = OrganizationService();
    final organizationBuilder = OrganizationBuilder();
    final organizationController = OrganizationController(organizationService, organizationBuilder);

    final app = Router();
    app.mount('/users/', userController.router);

    app.mount('/org/', organizationController.router);

    final handler = const Pipeline().addMiddleware(logRequests()).addHandler(app);

    await io.serve(handler, 'localhost', 8080);
  }
}
