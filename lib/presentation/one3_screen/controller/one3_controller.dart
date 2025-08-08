import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/utils/dialog_utils.dart';
import 'package:pulsedevice/core/utils/loading_helper.dart';
import 'package:pulsedevice/core/utils/snackbar_helper.dart';
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
  final service = ApiService();
  late final String phone;
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
    initData();
  }

  void initData() async {
    final args = await Get.arguments as Map<String, dynamic>;
    phone = args['phone'];

    ///確保不卡UI
    Future.delayed(const Duration(milliseconds: 500), () {
      fetchSms(phone);
    });
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
    Get.toNamed(AppRoutes.two3Screen, arguments: {
      'phone': phone,
    });
  }

  void goLogin() {
    Get.offNamed(AppRoutes.one2Screen);
  }

  Future<void> fetchSms(String phone) async {
    LoadingHelper.show();
    try {
      var resData = await service.postJson(
        Api.sms,
        {
          'phone': phone,
        },
      );
      LoadingHelper.hide();
      if (resData.isNotEmpty) {
        final resMsg = resData["message"];
        if (resMsg.contains("請輸入")) {
          Future.delayed(const Duration(milliseconds: 500), () {
            SnackbarHelper.showBlueSnackbar(message: "snackbar_send_msm".tr);
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

  /// 簡訊驗證
  Future<void> fetchSmsVerify(String phone, String smsCode) async {
    LoadingHelper.show();
    try {
      var resData = await service.postJson(
        Api.smsVerify,
        {
          'phone': phone,
          'phone_verify': smsCode,
        },
      );
      LoadingHelper.hide();
      if (resData.isNotEmpty) {
        final resMsg = resData["message"];
        if (resMsg.contains("成功") || resMsg.contains("正確")) {
          goTwo3Screen();
        } else {
          DialogHelper.showError("${resData["message"]}");
        }
      }
    } catch (e) {
      LoadingHelper.hide();
      DialogHelper.showError("服務錯誤，請稍後再試");
    }
  }
}
