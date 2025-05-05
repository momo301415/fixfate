import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/hiveDb/user_profile_storage.dart';
import 'package:pulsedevice/presentation/k29_page/models/list_one_item_model.dart';

import '../../../core/app_export.dart';
import '../models/k29_model.dart';

/// A controller class for the K29Page.
///
/// This class manages the state of the K29Page, including the
/// current k29ModelObj
class K29Controller extends GetxController {
  Rx<K29Model> k29ModelObj = K29Model().obs;
  final gc = Get.find<GlobalController>();
  @override
  void onInit() {
    super.onInit();
    print("初始化監聽藍牙狀態：${gc.blueToolStatus.value}");
    var userProfile = UserProfileStorage.getUserProfile("me");
    if (userProfile != null) {
      gc.userEmail.value = userProfile.email ?? '';
    }
  }

  void onTopCardTap(ListOneItemModel model) {
    // 可依 model.id 判斷導頁
    print('點擊功能卡片：${model.title}');
  }

  void onMenuTap(String key) {
    switch (key) {
      case 'profile':
        Get.toNamed('/profile');
        break;
      case 'device':
        Get.toNamed('/device');
        break;
      // ...依需求加上去
    }
  }

  /// 路由到個人中心-個人資料
  void goK30Screen() {
    Get.toNamed(AppRoutes.k30Screen);
  }

  /// 路由到用藥告警
  void goK48Screen() {
    Get.toNamed(AppRoutes.k48Screen);
  }

  /// 我的設備頁面
  void goK40Screen() {
    Get.toNamed(AppRoutes.k40Screen);
  }

  /// 路由到警報紀錄頁面
  void goK53Screen() {
    Get.toNamed(AppRoutes.k53Screen);
  }

  /// 路由到通知消息頁面
  void goK55Screen() {
    Get.toNamed(AppRoutes.k55Screen);
  }

  /// 路由到帳號與安全頁面
  void go63Screen() {
    Get.toNamed(AppRoutes.k63Screen);
  }

  void go67SrcScreen() {
    Get.toNamed(AppRoutes.k67Screen);
  }
}
