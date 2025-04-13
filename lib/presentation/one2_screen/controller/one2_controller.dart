import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/one2_model.dart';

/// A controller class for the One2Screen.
///
/// This class manages the state of the One2Screen, including the
/// current one2ModelObj
class One2Controller extends GetxController {
  TextEditingController oneController = TextEditingController();

  TextEditingController tfController = TextEditingController();

  Rx<One2Model> one2ModelObj = One2Model().obs;

  var isValid = false.obs;

  @override
  void onClose() {
    super.onClose();
    oneController.dispose();
    tfController.dispose();
  }

  /// 路由到忘記密碼頁
  void goK14Screen() {
    Get.toNamed(AppRoutes.k14Screen);
  }

  void checkFromIsNotEmpty() {
    isValid.value =
        oneController.text.isNotEmpty && tfController.text.isNotEmpty;
  }

  /// 路由到個人信息頁
  void goK30Screen() {
    Get.toNamed(AppRoutes.k30Screen);
  }
}
