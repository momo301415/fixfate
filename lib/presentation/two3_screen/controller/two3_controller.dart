import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/two3_model.dart';

/// A controller class for the Two3Screen.
///
/// This class manages the state of the Two3Screen, including the
/// current two3ModelObj
class Two3Controller extends GetxController {
  TextEditingController passwordController = TextEditingController();

  TextEditingController passwordoneController = TextEditingController();

  Rx<Two3Model> two3ModelObj = Two3Model().obs;

  var isValid = false.obs;

  @override
  void onClose() {
    super.onClose();
    passwordController.dispose();
    passwordoneController.dispose();
  }

  void checkFromIsNotEmpty() {
    isValid.value = passwordController.text.isNotEmpty &&
        passwordoneController.text.isNotEmpty;
  }

  /// 路由到個人信息頁
  void goK30Screen() {
    Get.toNamed(AppRoutes.k30Screen);
  }
}
