import 'package:example/src/service_layer.dart';

import 'component_service_blue.dart';
import 'component_service_green.dart';
import '../models/system_manager.dart';
import '../utils/enums.dart';

class SystemManagerService {
  Future<ServiceLayer> selectSystemAndService(SystemManager systemManager) async {
    while (true) {
      if (systemManager.getSystemState(System.Green) != SystemState.Busy) {
        systemManager.setSystemState(System.Green, SystemState.Busy);
        systemManager.setSystemState(System.Blue, SystemState.Free);
        await Future.delayed(Duration(minutes: 1));
        systemManager.setSystemState(System.Green, SystemState.Free);
        return ComponentServiceBlueGreen();
      } else if (systemManager.getSystemState(System.Blue) != SystemState.Busy) {
        systemManager.setSystemState(System.Blue, SystemState.Busy);
        systemManager.setSystemState(System.Green, SystemState.Free);
        await Future.delayed(Duration(minutes: 1));
        systemManager.setSystemState(System.Blue, SystemState.Free);
        return ComponentServiceBlue();
      }
      await Future.delayed(Duration(seconds: 1));
    }
  }
}
