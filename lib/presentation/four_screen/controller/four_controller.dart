import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/service/firebase_analytics_service.dart';
import 'package:pulsedevice/core/utils/config.dart';
import 'package:pulsedevice/core/utils/dialog_utils.dart';
import 'package:pulsedevice/core/utils/firebase_helper.dart';
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
  final gc = Get.find<GlobalController>();

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

    // 📊 記錄OTP驗證頁面瀏覽事件
    FirebaseAnalyticsService.instance.logViewOtpPage();

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
    // 📊 記錄重新發送OTP按鈕點擊事件
    FirebaseAnalyticsService.instance.logClickResendOtp();

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
          DialogHelper.showError("${resData["message"]}", onOk: () {
            goOne2Screen();
          });
        }
      }
    } catch (e) {
      LoadingHelper.hide();
      DialogHelper.showError("服務錯誤，請稍後再試");
    }
  }

  void pressFetchRegist() async {
    // 📊 記錄完成註冊按鈕點擊事件
    FirebaseAnalyticsService.instance.logClickCompleteRegistration();

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
          // 📊 記錄註冊成功事件
          FirebaseAnalyticsService.instance.logSignUpSuccess(
            signUpMethod: 'phone',
          );

          pressFetchLogin().then((val) {
            gok10Screen();
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

  Future<bool> pressFetchLogin() async {
    try {
      LoadingHelper.show();
      final notityToken = await FirebaseHelper.getDeviceToken();
      var resData = await service.postJson(
        Api.login,
        {
          'phone': phone,
          'password': password,
          'notityToken': notityToken,
        },
      );
      LoadingHelper.hide();
      if (resData.isNotEmpty) {
        var resBody = resData['data'];
        if (resBody != null) {
          await PrefUtils().setUserId(phone);
          await PrefUtils().setPassword(password);
          await PrefUtils().setApiUserId(resBody['id'].toString());

          gc.userId.value = phone;
          gc.apiToken.value = resBody['token'].toString();
          gc.apiId.value = resBody['id'].toString();
          gc.userName.value = resBody['name'].toString();
          gc.healthDataSyncService.setUserId(phone);
          Config.apiId = resBody['id'].toString();
          Config.userId = phone;
          Config.userName = resBody['name'].toString();
          gc.avatarUrl.value = resBody['avatarUrl'] ?? "";
          gc.userGender.value = resBody['gender'] ?? "";
          gc.chatApiKeyValue.value = resBody['apiKeyValue'] ?? "";

          final ftoken = await FirebaseHelper.getDeviceToken();
          if (ftoken != null) {
            gc.firebaseToken.value = ftoken;
            Config.notifyToken = ftoken;
          }
          return true;
        } else {
          DialogHelper.showError("${resData["message"]}");
        }
      }
    } catch (e) {
      e.printError();
      LoadingHelper.hide();
      DialogHelper.showError("服務錯誤，請稍後再試");
    }
    return false;
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
