import 'package:example/src/utils/enums.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod/riverpod.dart';

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

  Future<void> routeRequest(ProviderContainer container) async {
    final systemStateManager = SystemStateManager();
    SystemConfig systemConfig = getSystemConfig(container);

    if (systemConfig.system == System.Blue) {
      systemStateManager.updateState(System.Blue, SystemState.busy);
      blueService.blueOperation();
      systemStateManager.updateState(System.Blue, SystemState.free);
    } else if (systemConfig.system == System.Green) {
      systemStateManager.updateState(System.Green, SystemState.busy);
      await greenService.greenOperation();
      systemStateManager.updateState(System.Green, SystemState.free);
    } else {
      if (kDebugMode) {
        print("System is busy. Request cannot be processed.");
      }
    }
  }
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
