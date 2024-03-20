import 'package:example/src/service_layer.dart';

import '../models/system_manager.dart';
import '../utils/enums.dart';
import 'component_service_blue.dart';

class SystemManagerService {
  Future<ServiceLayer> selectSystemAndService(SystemManager systemManager) async {
    while (true) {
      if (systemManager.getSystemState(System.Green) != SystemState.Busy) {
        systemManager.setSystemState(System.Green, SystemState.Busy);
        systemManager.setSystemState(System.Blue, SystemState.Free);
        await Future.delayed(const Duration(seconds: 20));
        systemManager.setSystemState(System.Green, SystemState.Free);
        print("green in action");
        return ComponentServiceBlueGreen();
      } else if (systemManager.getSystemState(System.Blue) != SystemState.Busy) {
        systemManager.setSystemState(System.Blue, SystemState.Busy);
        systemManager.setSystemState(System.Green, SystemState.Free);
        await Future.delayed(const Duration(seconds: 20));
        systemManager.setSystemState(System.Blue, SystemState.Free);
        print("blue in action");
        return ComponentServiceBlue();
      }
      await Future.delayed(const Duration(seconds: 1));
    }
  }
}
