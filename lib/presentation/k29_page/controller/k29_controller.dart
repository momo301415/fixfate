import 'package:pulsedevice/presentation/k29_page/models/list_one_item_model.dart';

import '../../../core/app_export.dart';
import '../models/k29_model.dart';

/// A controller class for the K29Page.
///
/// This class manages the state of the K29Page, including the
/// current k29ModelObj
class K29Controller extends GetxController {
  Rx<K29Model> k29ModelObj = K29Model().obs;
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
}
