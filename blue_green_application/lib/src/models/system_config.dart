import 'package:riverpod/riverpod.dart';

class SystemConfig {
  SystemConfig({required this.system, required this.isRunning, required this.systemState});

  dynamic system;
  dynamic isRunning;
  dynamic systemState;
}

class SystemNotifier extends StateNotifier<SystemConfig> {
  SystemNotifier()
      : super(
          SystemConfig(system: '', isRunning: '', systemState: ''),
        );
}

final systemProvider = StateNotifierProvider<SystemNotifier, SystemConfig>((ref) {
  return SystemNotifier();
});
