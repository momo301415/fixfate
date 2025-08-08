import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/core/chat_screen_controller.dart';
import 'package:pulsedevice/core/utils/firebase_helper.dart';

import 'package:pulsedevice/presentation/k73_screen/controller/k73_controller.dart';

class HomeController extends GetxController {
  final bottomBarIndex = 1.obs; // 改為 1，對應 K29Page
  final cc = Get.find<ChatScreenController>();
  @override
  void onInit() {
    super.onInit();
    FirebaseHelper.init();
  }

  @override
  void onReady() {
    super.onReady();
    // 保留作為備用檢查，以防 FirebaseHelper 沒有處理
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(seconds: 3));
      try {
        final message = FirebaseHelper.consumePendingDialogMessage();
        if (message != null) {
          print("🔑 HomeController: 備用檢查發現待處理推播訊息: $message");
          await FirebaseHelper.handleMessage(message);
        }
      } catch (e) {
        print("❌ HomeController: 備用檢查錯誤: $e");
      }
    });
  }

  void onTabChanged(int index) {
    print('🔄 HomeController.onTabChanged: index = $index');

    switch (index) {
      case 0:
        // 健康頁面
        bottomBarIndex.value = 0;
        Get.find<K73Controller>().getFamilyData();
        Get.find<K73Controller>().getHealthData();
        break;
      case 1:
        // 諮詢按鈕 - 打開 K19Screen
        cc.isK19Visible.value = true;
        print('🔥 打開諮詢頁面');
        break;
      case 2:
        // 我的頁面 (實際對應 IndexedStack 的 index 1)
        bottomBarIndex.value = 1;
        print('📱 切換到個人中心');
        break;
    }
  }
}
