import '../utils/enums.dart';

class SystemManager {
  SystemState _blueState = SystemState.free;
  SystemState _greenState = SystemState.free;
  System _currentSystem = System.Blue;

  void toggleSystem() {
    _currentSystem = _currentSystem == System.Blue ? System.Green : System.Blue;
  }

  void setSystemState(System system, SystemState state) {
    if (system == System.Blue) {
      _blueState = state;
    } else {
      _greenState = state;
    }
  }

  SystemState getSystemState(System system) {
    return system == System.Blue ? _blueState : _greenState;
  }

  System getCurrentSystem() {
    return _currentSystem;
  }
}
