import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/utils/dialog_utils.dart';
import 'package:pulsedevice/presentation/three2_dialog/controller/three2_controller.dart';
import 'package:pulsedevice/presentation/three2_dialog/three2_dialog.dart';
import '../../../core/app_export.dart';
import '../models/k63_model.dart';

/// A controller class for the K63Screen.
///
/// This class manages the state of the K63Screen, including the
/// current k63ModelObj
class K63Controller extends GetxController {
  Rx<K63Model> k63ModelObj = K63Model().obs;
  final gc = Get.find<GlobalController>();
  var eamil = "".obs;

  @override
  void onInit() {
    super.onInit();
    eamil.value = gc.userEmail.value;
  }

  /// 路由到使用者條款
  void goK0screen() {
    Get.toNamed(AppRoutes.k0Screen);
  }

  /// 路由到修改密碼頁面
  void goOne9Screen() {
    Get.toNamed(AppRoutes.one9Screen);
  }

  ///路由到登入頁面
  void goOne2Screen() {
    Get.offAllNamed(AppRoutes.one2Screen);
  }

  Future<void> showThree2Dialog() async {
    var result = await DialogHelper.showCustomDialog(
        Get.context!, Three2Dialog(Get.put(Three2Controller())));
    if (result == "refresh") {
      update();
    }
  }
}
