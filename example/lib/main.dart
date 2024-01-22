// ignore_for_file: depend_on_referenced_packages

import 'package:example/src/blue_implementation.dart';
import 'package:example/src/green_implementation.dart';
import 'package:example/src/models/system_config.dart';
import 'package:example/src/service_router.dart';
import 'package:example/src/utils/enums.dart';
import 'package:riverpod/riverpod.dart';

void main() async {
  final container = ProviderContainer();
  final greenService = GreenServiceImpl();
  final blueService = BlueServiceImpl();

  final serviceRouter = ServiceRouter(
    greenService: greenService,
    blueService: blueService,
  );

  final systemConfig = getSystemConfig(container);
  print(systemConfig.system);

  await serviceRouter.routeRequest(systemConfig);
}

SystemConfig getSystemConfig(ProviderContainer container) {
  try {
    var systemConfig = container.read(systemProvider);

    if (systemConfig.system == '') {
      return SystemConfig(system: System.Blue, isRunning: false, systemState: SystemState.free);
    }

    if (systemConfig.system == System.Blue && systemConfig.systemState == SystemState.busy) {
      return SystemConfig(system: System.Green, isRunning: false, systemState: SystemState.free);
    }

    if (systemConfig.system == System.Blue && systemConfig.systemState == SystemState.free) {
      return SystemConfig(system: System.Blue, isRunning: false, systemState: SystemState.free);
    }

    if (systemConfig.system == System.Green && systemConfig.systemState == SystemState.busy) {
      return SystemConfig(system: System.Blue, isRunning: false, systemState: SystemState.free);
    }

    if (systemConfig.system == System.Green && systemConfig.systemState == SystemState.free) {
      return SystemConfig(system: System.Green, isRunning: false, systemState: SystemState.free);
    }

    return SystemConfig(system: System.Blue, isRunning: false, systemState: SystemState.free);
  } catch (exception) {
    rethrow;
  }
}

// void maintainStates(){
//
//   /* maintain version/seq number for sync -
//    - if G/B selected - mark it as busy
//    - if both are in busy states, finish one (B) and then do a sync with green and keep it in higher version,
//    - after request mark it in sync state and then mark as free
//    - if both are free, do a sync if seq numbers are different
//
//
//    */
// }
