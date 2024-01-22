import '../utils/enums.dart';

class SystemStateManager {
  static SystemStateManager? _instance;

  SystemState blueState = SystemState.free;
  SystemState greenState = SystemState.free;

  factory SystemStateManager() {
    _instance ??= SystemStateManager._internal();
    return _instance!;
  }

  SystemStateManager._internal();

  void updateState(System system, SystemState newState) {
    if (system == System.Blue) {
      blueState = newState;
    } else if (system == System.Green) {
      greenState = newState;
    }
  }
}
