// ignore_for_file: depend_on_referenced_packages

// void main() async {
//   // final container = ProviderContainer();
//   // final greenService = GreenServiceImpl();
//   // final blueService = BlueServiceImpl();
//   //
//   // final serviceRouter = ServiceRouter(
//   //   greenService: greenService,
//   //   blueService: blueService,
//   // );
//   //
//   // await serviceRouter.routeRequest(container);
//
//   List<Component> components = [
//     Component(1, 1, PersonalDetails('John Doe', 'john@example.com'), [4], [], 10.0),
//     Component(8, 1, PersonalDetails('Name1', 'john@example.com'), [4], [], 10.0),
//     Component(7, 1, PersonalDetails('Manasa', 'john@example.com'), [4, 5], [], 30.0),
//     Component(2, 1, PersonalDetails('Alice Smith', 'alice@example.com'), [5], [], 20.0),
//     Component(3, 1, PersonalDetails('Bob Johnson', 'bob@example.com'), [5], [], 20.0),
//     Component(9, 1, PersonalDetails('name2', 'bob@example.com'), [5], [], 20.0),
//     Component(4, 2, PersonalDetails('Emily Brown', 'emily@example.com'), [6], [1], 30.0),
//     Component(10, 2, PersonalDetails('Kiran', 'emily@example.com'), [6], [], 50.0),
//     Component(5, 2, PersonalDetails('David Lee', 'david@example.com'), [6], [2, 3], 70.0),
//     Component(6, 3, PersonalDetails('Sarah Jones', 'sarah@example.com'), [], [4, 5], 150.0),
//   ];
//
//   TreeNode<Component>? root = ComponentService().buildTree(components);
//
//   if (root != null) {
//     ComponentService().printTree(root);
//   } else {
//     print('Root node is null. Unable to build the tree.');
//   }
//
//   ComponentService().createRandomDataForComponents(10, 4);
//
//   // ComponentService().quickSort(components, 0, components.length - 1);
//   // ComponentService().printComponents(components);
//   //
//   // print("\n\nSort based on level-ascending order\n");
//   // ComponentService().sortBasedOnLevel(components, 1);
// }

//   /* maintain version/seq number for sync -
//    - if G/B selected - mark it as busy
//    - if both are in busy states, finish one (B) and then do a sync with green and keep it in higher version,
//    - after request mark it in sync state and then mark as free
//    - if both are free, do a sync if seq numbers are different
//
//
//    */

import 'dart:convert';

import 'package:example/src/models/component.dart';
import 'package:example/src/models/personal_details.dart';
import 'package:example/src/models/system_manager.dart';
import 'package:example/src/service/component_service_blue.dart';
import 'package:example/src/service/component_service_green.dart';
import 'package:example/src/serviceLayer.dart';
import 'package:example/src/utils/database.dart';
import 'package:example/src/utils/enums.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

void main() async {
  final app = Router();

  ServiceLayer service;
  SystemManager systemManager = SystemManager();

  if (systemManager.getCurrentSystem() == System.Green) {
    systemManager.setSystemState(System.Blue, SystemState.busy);
    service = ComponentServiceBlue();
    systemManager.setSystemState(System.Blue, SystemState.free);
  } else {
    systemManager.setSystemState(System.Green, SystemState.busy);

    service = ComponentServiceGreen();
    systemManager.setSystemState(System.Green, SystemState.free);
  }

  List<Component> components = [
    Component(1, 1, PersonalDetails('John Doe', 'john@example.com'), [4], [], 10.0),
    Component(8, 1, PersonalDetails('Jennifer Davis', 'Jennifer@example.com'), [4], [], 10.0),
    Component(7, 1, PersonalDetails('Michael Johnson', 'Michael@example.com'), [4, 5], [], 30.0),
    Component(2, 1, PersonalDetails('Alice Smith', 'alice@example.com'), [5], [], 20.0),
    Component(3, 1, PersonalDetails('Bob Johnson', 'bob@example.com'), [5], [], 20.0),
    Component(9, 1, PersonalDetails('William Martinez', 'William@example.com'), [5], [], 20.0),
    Component(17, 1, PersonalDetails('Michael Gonzalez', 'Michael@example.com'), [14], [], 35.0),
    Component(18, 1, PersonalDetails('Nancy Young', 'Nancy@example.com'), [14], [], 35.0),
    Component(19, 1, PersonalDetails('Christopher King', 'Christopher@example.com'), [15], [], 80.0),
    Component(20, 1, PersonalDetails('Laura Hill', 'Laurah@example.com'), [16], [], 20.0),
    Component(21, 1, PersonalDetails('Vasco Gama', 'Vasco@example.com'), [16], [], 70.0),
    Component(4, 2, PersonalDetails('Emily Brown', 'emily@example.com'), [6], [1, 7, 8], 30.0),
    Component(10, 2, PersonalDetails('Mary Wilson', 'Mary@example.com'), [6], [], 50.0),
    Component(5, 2, PersonalDetails('David Lee', 'david@example.com'), [6], [2, 3, 7], 70.0),
    Component(14, 2, PersonalDetails('Patricia Lopez', 'Patricia@example.com'), [11], [17, 18], 70.0),
    Component(15, 2, PersonalDetails('David Martinez', 'Davidm@example.com'), [11], [19], 80.0),
    Component(16, 2, PersonalDetails('Susan Hernandez', 'Susan@example.com'), [12], [20, 21], 90.0),
    Component(6, 3, PersonalDetails('Sarah Jones', 'sarah@example.com'), [13], [4, 5], 150.0),
    Component(11, 3, PersonalDetails('James Taylor', 'James@example.com'), [13], [14, 15], 200.0),
    Component(12, 3, PersonalDetails('Linda Rodriguez', 'Linda@example.com'), [13], [16], 90.0),
    Component(13, 4, PersonalDetails('Robert Garcia', 'Robert@example.com'), [], [6, 11, 12], 400.0),
  ];

  // Generate tree data endpoint
  app.post('/generate-tree', (Request request) async {
    final requestBody = await request.readAsString();
    final requestData = jsonDecode(requestBody);
    final randomTree = requestData['random'] as bool;
    final numberOfData = requestData['numberOfData'] as int;
    final numberOfLevels = requestData['numberOfLevels'] as int;
    final List<Component> generatedData;
    if (randomTree) {
      generatedData = service.createRandomDataForComponents(numberOfData, numberOfLevels);
    } else {
      print(await Database.getAllComponents());
      generatedData = await Database.getAllComponents();
    }
    final root = service.buildTree(generatedData);

    if (root != null) {
      return Response.ok(jsonEncode({'success': true, 'message': 'Tree data generated successfully', 'tree': root.data}));
    } else {
      return Response.internalServerError(body: jsonEncode({'success': false, 'message': 'Failed to generate tree data'}));
    }
  });

  // Sort components endpoint
  app.post('/sort-components', (Request request) async {
    final requestBody = await request.readAsString();
    final requestData = jsonDecode(requestBody);
    final List<dynamic> componentsData = requestData['components'];
    final List<Component> components = componentsData.map((data) => Component.fromJson(data)).toList();

    service.quickSort(components, 0, components.length - 1);
    return Response.ok(jsonEncode({'success': true, 'message': 'Components sorted successfully', 'sortedComponents': components}));
  });

  final handler = const Pipeline().addMiddleware(logRequests()).addHandler(app);
  final server = await shelf_io.serve(handler, 'localhost', 8080);
  print('Server running on localhost:${server.port}');

  app.post('/add-component', (Request request) async {
    try {
      final requestBody = await request.readAsString();
      final requestData = jsonDecode(requestBody);

      final int componentId = requestData['id'] as int;
      final int level = requestData['level'] as int;
      final String name = requestData['name'] as String;
      final String email = requestData['email'] as String;
      final List<int>? lowerComponents =
          (requestData['listOfLowerComponentsId'] != null) ? List<int>.from(requestData['listOfLowerComponentsId'] as List<dynamic>) : null;

      final List<int>? higherComponents =
          (requestData['listOfHigherComponentsId'] != null) ? List<int>.from(requestData['listOfHigherComponentsId'] as List<dynamic>) : null;

      final double amountAccountable = requestData['amountAccountable'] as double;

      final PersonalDetails personalDetails = PersonalDetails(name, email);
      final Component newComponent = Component(componentId, level, personalDetails, higherComponents!, lowerComponents!, amountAccountable);

      // Call the function to add the component
      final List<Component> updatedComponents = ComponentServiceBlue().addComponent(components, newComponent);
      ComponentServiceBlue().printComponents(updatedComponents);

      return Response.ok(jsonEncode({'success': true, 'message': 'Component added successfully', 'components': updatedComponents}));
    } catch (e) {
      return Response.internalServerError(body: jsonEncode({'success': false, 'message': 'Failed to add component: $e'}));
    }
  });
}
