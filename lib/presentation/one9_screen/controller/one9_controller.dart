import 'package:flutter/material.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/utils/dialog_utils.dart';
import 'package:pulsedevice/core/utils/loading_helper.dart';
import 'package:pulsedevice/core/utils/snackbar_helper.dart';
import '../../../core/app_export.dart';
import '../models/one9_model.dart';

/// A controller class for the One9Screen.
///
/// This class manages the state of the One9Screen, including the
/// current one9ModelObj
class One9Controller extends GetxController {
  TextEditingController tfController = TextEditingController();

  TextEditingController tf1Controller = TextEditingController();

  TextEditingController tf2Controller = TextEditingController();

  Rx<One9Model> one9ModelObj = One9Model().obs;
  final gc = Get.find<GlobalController>();
  final service = ApiService();
  var isValid = false.obs;
  var isDisablePwd = true.obs;
  var isDisablePwdConfirm = true.obs;

  @override
  void onClose() {
    super.onClose();
    tfController.dispose();
    tf1Controller.dispose();
    tf2Controller.dispose();
  }

  void checkFromIsNotEmpty() {
    isValid.value = tfController.text.isNotEmpty &&
        tf1Controller.text.isNotEmpty &&
        tf2Controller.text.isNotEmpty;
  }

  Future<void> callApi() async {
    LoadingHelper.show();
    try {
      var resData = await service.postJson(
        Api.updatePWD,
        {
          'userId': gc.apiId.value,
          "oldPWD": tfController.value.text,
          "newPWD": tf2Controller.value.text
        },
      );
      LoadingHelper.hide();
      if (resData.isNotEmpty) {
        final success = resData["success"];
        if (success == true) {
          await PrefUtils().setPassword(tf2Controller.value.text);
          DialogHelper.showError("${resData["message"]}", onOk: () {
            goLogin();
          });
        } else {
          DialogHelper.showError("${resData["message"]}");
        }
      }
    } catch (e) {
      LoadingHelper.hide();
      DialogHelper.showError("服務錯誤，請稍後再試");
    }
  }

  void goLogin() {
    Get.offAllNamed(AppRoutes.one2Screen);
  }
}
