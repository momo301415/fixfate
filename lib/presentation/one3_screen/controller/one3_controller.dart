import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../core/app_export.dart';
import '../models/one3_model.dart';

/// A controller class for the One3Screen.
///
/// This class manages the state of the One3Screen, including the
/// current one3ModelObj
class One3Controller extends GetxController with CodeAutoFill {
  Rx<TextEditingController> otpController = TextEditingController().obs;

  Rx<One3Model> one3ModelObj = One3Model().obs;

  var isValid = false.obs;
  var countdown = 60.obs;

  @override
  void codeUpdated() {
    otpController.value.text = code ?? '';
  }

  @override
  void onInit() {
    super.onInit();
    listenForCode();
    countdownTimer();
  }

  void checkFromIsNotEmpty() {
    isValid.value = otpController.value.text.isNotEmpty &&
        otpController.value.text.length == 4;
  }

  void countdownTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        timer.cancel();
        countdown.value = 60;
      }
    });
  }

  /// 路由到重設密碼
  void goTwo3Screen() {
    Get.toNamed(AppRoutes.two3Screen);
  }
}
