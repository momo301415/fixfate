import '../../../core/app_export.dart';
import '../models/k2_model.dart';

/// A controller class for the K2Screen.
///
/// This class manages the state of the K2Screen, including the
/// current k2ModelObj
class K2Controller extends GetxController {
  Rx<K2Model> k2ModelObj = K2Model().obs;

  /// 路由登入頁面
  void goOne2Screen() {
    Get.toNamed(AppRoutes.one2Screen);
  }

  /// 路由註冊頁面
  void goOneScreen() {
    Get.toNamed(AppRoutes.oneScreen);
  }
}
