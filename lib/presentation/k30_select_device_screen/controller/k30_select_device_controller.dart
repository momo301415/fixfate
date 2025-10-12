import '../../../core/app_export.dart';
import '../models/k30_model.dart';

/// A controller class for the K30Screen.
///
/// This class manages the state of the K30Screen, including the
/// current k30ModelObj
class K30SelectDeviceController extends GetxController {
  Rx<K30Model> k30ModelObj = K30Model().obs;

  void goOne3FindDeviceScreen() {
    Get.toNamed(AppRoutes.one3FindDeviceScreen);
  }

  /// 註冊設備頁面
  void goK10Screen() {
    Get.toNamed(AppRoutes.k10Screen);
  }

  /// 選擇設備頁面
  void goSelectDeviceScreen(int index) {
    switch (index) {
      case 0:
        goK10Screen();
        break;
      case 1:
        goOne3FindDeviceScreen();
        break;
    }
  }
}
