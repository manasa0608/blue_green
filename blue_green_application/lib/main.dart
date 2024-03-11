import 'package:example/src/controllers/component_controller.dart';
import 'package:example/src/models/system_manager.dart';
import 'package:example/src/service/component_api_service.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

final SystemManager systemManager = SystemManager();

void main() async {
  final app = Router();

  final apiService = ComponentApiService();
  final apiController = ComponentController(apiService);
  apiController.setupRoutes(app);

  final handler = const shelf.Pipeline().addMiddleware(shelf.logRequests()).addHandler(app);
  await shelf_io.serve(handler, 'localhost', 8080);
}
