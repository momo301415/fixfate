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
    var userProfile = UserProfileStorage.getUserProfile(gc.userId.value);
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

  /// 路由到家人管理頁面
  void go67SrcScreen() {
    Get.toNamed(AppRoutes.k67Screen);
  }

  /// 路由到目標設定頁面
  void goK62Screen() {
    Get.toNamed(AppRoutes.k62Screen);
  }

  /// 路由到測量設定
  void goK57Screen() {
    Get.toNamed(AppRoutes.k57Screen);
  }

  void queryDb() async {
    var id = await gc.userId.value;
    var combined_data = await gc.combinedDataService.getByUser(id);
    var sleep_data = await gc.sleepDataService.getSleepDataByUser(id);
    var sleep_detail_data =
        await gc.sleepDataService.getSleepDataWithDetails(id);
    var step_data = await gc.stepDataService.getStepDataByUser(id);
    var heeart_rate_data = await gc.heartRateDataService.getByUser(id);
    var blood_pressure_data = await gc.bloodPressureDataService.getByUser(id);
    print("query database combined_data -> ${combined_data.length}");
    // printLongText("query database combined_data -> ${combined_data}");
    print("query database sleep_data -> ${sleep_data.length}");
    // printLongText("query database sleep_data -> ${sleep_data}");
    print("query database sleep_detail_data -> ${sleep_data.length}");
    // printLongText("query database sleep_detail_data -> ${sleep_detail_data}");
    print("query database step_data -> ${step_data.length}");
    // print("query database step_data -> ${step_data}");
    print("query database heeart_rate_data -> ${heeart_rate_data.length}");
    // print("query database heeart_rate_data -> ${heeart_rate_data}");
    print(
        "query database blood_pressure_data -> ${blood_pressure_data.length}");
    // print("query database blood_pressure_data -> ${blood_pressure_data}");
  }

  void printLongText(String text) {
    const int chunkSize = 800;
    for (var i = 0; i < text.length; i += chunkSize) {
      final chunk = text.substring(
          i, i + chunkSize > text.length ? text.length : i + chunkSize);
      print(chunk);
    }
  }
}
