import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../models/one_model.dart';

/// A controller class for the OneScreen.
///
/// This class manages the state of the OneScreen, including the
/// current oneModelObj
class OneController extends GetxController {
  TextEditingController oneController = TextEditingController();

  TextEditingController tfController = TextEditingController();

  TextEditingController tf1Controller = TextEditingController();

  Rx<OneModel> oneModelObj = OneModel().obs;

  var isValid = false.obs;
  var isDisablePwd = true.obs;
  var isDisablePwdConfirm = true.obs;
  @override
  void onClose() {
    super.onClose();
    oneController.dispose();
    tfController.dispose();
    tf1Controller.dispose();
  }

  /// 路由到sms
  void goFourScreen() {
    Get.toNamed(AppRoutes.fourScreen, arguments: {
      'phone': oneController.text,
      'password': tfController.text
    });
  }

  void goAll() {
    Get.toNamed(AppRoutes.appNavigationScreen);
  }

  void checkFromIsNotEmpty() {
    isValid.value = oneController.text.isNotEmpty &&
        tfController.text.isNotEmpty &&
        tf1Controller.text.isNotEmpty;
  }
}
