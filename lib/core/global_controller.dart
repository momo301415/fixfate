import 'package:flutter/foundation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pulsedevice/core/app_export.dart';
import 'package:pulsedevice/core/hiveDb/goal_profile.dart';
import 'package:pulsedevice/core/hiveDb/user_profile.dart';
import 'package:yc_product_plugin/yc_product_plugin.dart';

class GlobalController extends GetxController {
  RxInt blueToolStatus = 0.obs;
  RxString userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() async {
    // 初始化穿戴式sdk
    YcProductPlugin().initPlugin(isReconnectEnable: true, isLogEnable: true);
    // 啟動監聽
    YcProductPlugin().onListening((event) {
      if (event.keys.contains(NativeEventType.bluetoothStateChange)) {
        final int st = event[NativeEventType.bluetoothStateChange];
        debugPrint('藍牙狀態變更：$st');
        blueToolStatus.value = st;
      }
    });
    await Hive.initFlutter();
    Hive.registerAdapter(UserProfileAdapter());
    Hive.registerAdapter(GoalProfileAdapter());
    await Hive.openBox<UserProfile>('user_profile');
    await Hive.openBox<GoalProfile>('goal_profile');
  }
}
