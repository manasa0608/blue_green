import 'package:example/src/utils/enums.dart';

import 'blue_service.dart';
import 'green_service.dart';
import 'models/system_config.dart';
import 'models/system_state_manager.dart';

class ServiceRouter {
  final GreenServiceInterface greenService;
  final BlueServiceInterface blueService;

  ServiceRouter({
    required this.greenService,
    required this.blueService,
  });

  Future<void> routeRequest(SystemConfig systemConfig) async {
    final systemStateManager = SystemStateManager();
    if (systemConfig.system == System.Blue) {
      systemStateManager.updateState(System.Blue, SystemState.busy);
      blueService.blueOperation();
      systemStateManager.updateState(System.Blue, SystemState.free);
    } else if (systemConfig.system == System.Green) {
      systemStateManager.updateState(System.Green, SystemState.busy);
      await greenService.greenOperation();
      systemStateManager.updateState(System.Green, SystemState.free);
    } else {
      print("System is busy. Request cannot be processed.");
    }
  }
}
