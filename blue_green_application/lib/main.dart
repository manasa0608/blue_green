import 'package:blue_green_application/src/controllers/component_controller.dart';
import 'package:blue_green_application/src/models/system_manager.dart';
import 'package:blue_green_application/src/repository/generic_repository.dart';
import 'package:blue_green_application/src/service/component_api_service.dart';
import 'package:blue_green_application/src/service/system_manager_service.dart';
import 'package:memory_cache/memory_cache.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

final SystemManager systemManager = SystemManager();
final MemoryCache localCache = MemoryCache();

void main() async {
  //component with predefined structure and operations
  final app = Router();

  final apiService = ComponentApiService();
  final apiController = ComponentController(apiService);
  apiController.setupRoutes(app);

  final handler = const shelf.Pipeline().addMiddleware(shelf.logRequests()).addHandler(app);
  await shelf_io.serve(handler, 'localhost', 8080);

  //component with generic operations
  GenericComponentRepository service = await SystemManagerService().selectSystemAndServiceForGenericComponent(systemManager);
}
