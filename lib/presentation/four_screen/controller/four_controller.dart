import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../core/app_export.dart';
import '../models/four_model.dart';

/// A controller class for the FourScreen.
///
/// This class manages the state of the FourScreen, including the
/// current fourModelObj
class FourController extends GetxController with CodeAutoFill {
  Rx<TextEditingController> otpController = TextEditingController().obs;

  Rx<FourModel> fourModelObj = FourModel().obs;

  var isReadPrivacyPolicy = false.obs;

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

  void goPravacyPolicyScreen() async {
    final result = await Get.toNamed(AppRoutes.k0Screen);
    if (result == true) {
      isReadPrivacyPolicy.value = true;
    }
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
}
