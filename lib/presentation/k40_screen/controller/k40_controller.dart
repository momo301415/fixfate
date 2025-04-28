import '../../../core/app_export.dart';
import '../models/k40_model.dart';

/// A controller class for the K40Screen.
///
/// This class manages the state of the K40Screen, including the
/// current k40ModelObj
class K40Controller extends GetxController {
  Rx<K40Model> k40ModelObj = K40Model().obs;

  /// 註冊設備頁面
  void goK10Screen() {
    Get.toNamed(AppRoutes.k10Screen);
  }
}
