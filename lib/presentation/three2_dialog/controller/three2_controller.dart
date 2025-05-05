import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/hiveDb/user_profile_storage.dart';
import 'package:pulsedevice/core/utils/snackbar_helper.dart';
import '../../../core/app_export.dart';
import '../models/three2_model.dart';

/// A controller class for the Three2Dialog.
///
/// This class manages the state of the Three2Dialog, including the
/// current three2ModelObj
class Three2Controller extends GetxController {
  Rx<Three2Model> three2ModelObj = Three2Model().obs;
  final gc = Get.find<GlobalController>();
  Future<void> deleteAccount() async {
    var isAccountExist = await UserProfileStorage.exists("me");
    if (isAccountExist) {
      await UserProfileStorage.deleteUserProfile("me");
      gc.userEmail.value = "";
      Get.back(result: 'refresh');
      SnackbarHelper.showBlueSnackbar(message: "snackbar_account_delete".tr);
    } else {
      Get.back();
      SnackbarHelper.showBlueSnackbar(message: "snackbar_no_account_delete".tr);
    }
  }
}
