// ignore_for_file: depend_on_referenced_packages

import 'package:example/src/blue_implementation.dart';
import 'package:example/src/green_implementation.dart';
import 'package:example/src/service_router.dart';
import 'package:riverpod/riverpod.dart';

void main() async {
  final container = ProviderContainer();
  final greenService = GreenServiceImpl();
  final blueService = BlueServiceImpl();

  final serviceRouter = ServiceRouter(
    greenService: greenService,
    blueService: blueService,
  );

  await serviceRouter.routeRequest(container);
}

//   /* maintain version/seq number for sync -
//    - if G/B selected - mark it as busy
//    - if both are in busy states, finish one (B) and then do a sync with green and keep it in higher version,
//    - after request mark it in sync state and then mark as free
//    - if both are free, do a sync if seq numbers are different
//
//
//    */
