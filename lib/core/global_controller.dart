import 'package:flutter/foundation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pulsedevice/core/app_export.dart';
import 'package:yc_product_plugin/yc_product_plugin.dart';

class GlobalController extends GetxController {
  RxInt blueToolStatus = 0.obs;
  RxString userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() {
    YcProductPlugin().onListening((event) {
      if (event.keys.contains(NativeEventType.bluetoothStateChange)) {
        final int st = event[NativeEventType.bluetoothStateChange];
        debugPrint('藍牙狀態變更：$st');
        blueToolStatus.value = st;
      }
    });
  }
}
