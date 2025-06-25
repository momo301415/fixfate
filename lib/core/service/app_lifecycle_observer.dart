import 'package:flutter/widgets.dart';
import 'package:pulsedevice/core/global_controller.dart';

class AppLifecycleObserver extends WidgetsBindingObserver {
  final GlobalController gc;

  AppLifecycleObserver(this.gc);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      var res = await gc.getBlueToothDeviceInfo();
      if (res && !gc.isSporting.value) {
        // App 回到前景，觸發一次同步
        gc.safeRunSync();
      }
      debugPrint("App 回到前景，已執行資料同步");
    }
  }
}
