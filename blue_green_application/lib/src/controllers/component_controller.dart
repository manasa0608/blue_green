import 'package:example/src/service/component_api_service.dart';
import 'package:shelf_router/shelf_router.dart';

class ComponentController {
  final ComponentApiService componentApiService;

  ComponentController(this.componentApiService);

  void setupRoutes(Router app) async {
    final urlMappings = {
      '/generate-tree': {'POST': componentApiService.generateTreeHandler},
      '/add-component': {'POST': componentApiService.addComponent},
      '/delete-item': {'DELETE': componentApiService.deleteComponent},
      '/sort-components': {'GET': componentApiService.sortComponents},
    };

    urlMappings.forEach((url, methods) {
      methods.forEach((method, handler) {
        if (method == 'POST') {
          app.post(url, handler);
        } else if (method == 'GET') {
          app.get(url, handler);
        } else if (method == 'DELETE') {
          app.delete(url, handler);
        }
      });
    });
  }
}
