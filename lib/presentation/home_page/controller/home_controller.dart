import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/core/utils/dialog_utils.dart';
import 'package:pulsedevice/core/utils/firebase_helper.dart';

import 'package:pulsedevice/presentation/k73_screen/controller/k73_controller.dart';

class HomeController extends GetxController {
  final bottomBarIndex = 1.obs;

  @override
  void onInit() {
    super.onInit();
    FirebaseHelper.init();
  }

  @override
  void onReady() {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final message = FirebaseHelper.consumePendingDialogMessage();
        if (message != null) {
          print("🔑 Showing dialog from push message: $message");
          await Future.delayed(Duration(milliseconds: 500));
          await FirebaseHelper.handleMessage(message);
        }
      } catch (e) {
        print("❌ Error showing dialog from push message: $e");
      }
    });
  }

  void onTabChanged(int index) {
    bottomBarIndex.value = index;

    // 根據 index 主動刷新該 tab 頁資料
    switch (index) {
      case 0:
        Get.find<K73Controller>().getFamilyData();
        Get.find<K73Controller>().getHealthData();
        break;
      case 1:
        break;
    }
  }
}
