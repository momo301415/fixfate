import 'package:pulsedevice/core/service/firebase_analytics_service.dart';
import '../../../core/app_export.dart';
import '../models/k57_model.dart';

/// A controller class for the K57Screen.
///
/// This class manages the state of the K57Screen, including the
/// current k57ModelObj
class K57Controller extends GetxController {
  Rx<K57Model> k57ModelObj = K57Model().obs;

  @override
  void onInit() {
    super.onInit();

    // 📊 記錄測量設定頁面瀏覽事件
    FirebaseAnalyticsService.instance.logViewMeasurementPage();
  }

  /// 路由到心率測量設定
  void goK58Screen() {
    Get.toNamed(AppRoutes.k58Screen);
  }

  /// 路由到體溫測量設定
  void goK61Screen() {
    Get.toNamed(AppRoutes.k61Screen);
  }

  /// 路由到血氧測量設定
  void goTwo5Screen() {
    Get.toNamed(AppRoutes.two5Screen);
  }

  /// 路由到壓力測量設定
  void goTwo9Screen() {
    Get.toNamed(AppRoutes.two9Screen);
  }

  /// 路由到監聽設定
  void goTwo10Screen() {
    Get.toNamed(AppRoutes.two10Screen);
  }
}
