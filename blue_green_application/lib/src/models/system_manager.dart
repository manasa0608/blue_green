import '../utils/enums.dart';

class SystemManager {
  static final SystemManager _instance = SystemManager._internal();

  factory SystemManager() {
    return _instance;
  }

  SystemManager._internal();

  System _currentSystem = System.Blue;
  SystemState _blueState = SystemState.Free;
  SystemState _greenState = SystemState.Free;

  // Method to toggle between systems
  void toggleSystem() {
    _currentSystem = _currentSystem == System.Blue ? System.Green : System.Blue;
  }

  // Method to set system state
  void setSystemState(System system, SystemState state) {
    if (system == System.Blue) {
      _blueState = state;
    } else {
      _greenState = state;
    }
  }

  // Method to get system state
  SystemState getSystemState(System system) {
    return system == System.Blue ? _blueState : _greenState;
  }

  // Method to get current system
  System getCurrentSystem() {
    return _currentSystem;
  }
}
