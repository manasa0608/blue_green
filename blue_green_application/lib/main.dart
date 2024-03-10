import 'package:example/src/models/system_manager.dart';
import 'package:example/src/service/api_service.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

final SystemManager systemManager = SystemManager();

void main() async {
  final app = Router();

  ApiService apiService = ApiService();

  final urlMappings = {
    '/generate-tree': {'POST': apiService.generateTreeHandler},
    '//add-component': {'POST': apiService.addComponent},
    // '/delete-item': {'DELETE': apiService.deleteItemHandler},
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
      // Add other methods as needed
    });
  });
  final handler = const shelf.Pipeline().addMiddleware(shelf.logRequests()).addHandler(app);
  await shelf_io.serve(handler, 'localhost', 8080);


}

// void main() async {
//   final app = Router();
//
//   final urlMappings = {
//     '/api/generate-tree': generateTreeHandler,
//   };
//
//   final handler = const Pipeline().addMiddleware(logRequests()).addHandler(app);
//   final server = await shelf_io.serve(handler, 'localhost', 8080);
//   print('Server running on localhost:${server.port}');
//   urlMappings.forEach((url, handler) {
//     app.post(url, handler);
//   });
// }
//
