import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pulsedevice/core/utils/dialog_utils.dart';
import 'package:pulsedevice/core/utils/loading_helper.dart';
import 'package:pulsedevice/core/utils/snackbar_helper.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../core/app_export.dart';
import '../models/four_model.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';

/// A controller class for the FourScreen.
///
/// This class manages the state of the FourScreen, including the
/// current fourModelObj
class FourController extends GetxController with CodeAutoFill {
  Rx<TextEditingController> otpController = TextEditingController().obs;

  Rx<FourModel> fourModelObj = FourModel().obs;
  ApiService service = ApiService();

  var isReadPrivacyPolicy = false.obs;

  var countdown = 60.obs;

  late final String phone;
  late final String password;

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
    password = args['password'];

    ///確保不卡UI
    Future.delayed(const Duration(milliseconds: 500), () {
      fetchSms(phone);
    });
  }

  void goPravacyPolicyScreen() async {
    final result = await Get.toNamed(AppRoutes.k0Screen);
    if (result == true) {
      isReadPrivacyPolicy.value = true;
    }
  }

  void countdownTimer() async {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        timer.cancel();
      }
    });
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

  void pressFetchRegist() async {
    LoadingHelper.show();
    try {
      var resData = await service.postJson(
        Api.register,
        {
          'phone': phone,
          'password': password,
          'phone_verify': otpController.value.text,
        },
      );
      LoadingHelper.hide();
      if (resData.isNotEmpty) {
        final resMsg = resData["message"];
        if (resMsg.contains("已註冊")) {
          DialogHelper.showError("${resData["message"]}", onOk: () {
            goOne2Screen();
          });
        } else if (resMsg.contains("成功")) {
          gok10Screen();
        } else {
          DialogHelper.showError("${resData["message"]}");
        }
      }
    } catch (e) {
      LoadingHelper.hide();
      DialogHelper.showError("服務錯誤，請稍後再試");
    }
  }

  /// 路由登入頁面
  void goOne2Screen() {
    Get.toNamed(AppRoutes.one2Screen);
  }

  /// 路由到設備註冊頁面
  void gok10Screen() {
    Get.toNamed(AppRoutes.k10Screen);
  }
}
