import 'package:flutter/material.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/service/firebase_analytics_service.dart';
import 'package:pulsedevice/core/utils/config.dart';
import 'package:pulsedevice/core/utils/dialog_utils.dart';
import 'package:pulsedevice/core/utils/firebase_helper.dart';
import 'package:pulsedevice/core/utils/loading_helper.dart';
import '../../../core/app_export.dart';
import '../models/one2_model.dart';

/// A controller class for the One2Screen.
///
/// This class manages the state of the One2Screen, including the
/// current one2ModelObj
class One2Controller extends GetxController {
  TextEditingController oneController = TextEditingController();
  TextEditingController tfController = TextEditingController();
  final gc = Get.find<GlobalController>();

  Rx<One2Model> one2ModelObj = One2Model().obs;

  var isValid = false.obs;
  var isDisablePwd = true.obs;
  final service = ApiService();
  @override
  void onInit() {
    super.onInit();
    initData();
  }

  @override
  void onClose() {
    super.onClose();
    oneController.dispose();
    tfController.dispose();
  }

  void initData() async {
    print("login page init ~~~~~~");
    oneController.text = await PrefUtils().getUserId();
    tfController.text = await PrefUtils().getPassword();
    if (oneController.text.isNotEmpty) {
      isValid.value = true;
    }

    // 📊 記錄登入頁面瀏覽事件
    FirebaseAnalyticsService.instance.logViewLoginPage();
  }

  /// 路由到忘記密碼頁
  void goK14Screen() {
    Get.toNamed(AppRoutes.k14Screen);
  }

  void checkFromIsNotEmpty() {
    isValid.value =
        oneController.text.isNotEmpty && tfController.text.isNotEmpty;
  }

  /// 路由到個人中心
  void goHomePage() {
    Get.toNamed(AppRoutes.homePage);
  }

  Future<bool> pressFetchLogin() async {
    try {
      // 📊 記錄登入按鈕點擊事件
      FirebaseAnalyticsService.instance.logClickLoginButton(
        loginMethod: 'phone',
      );

      LoadingHelper.show();
      final notityToken = await FirebaseHelper.getDeviceToken();
      var resData = await service.postJson(
        Api.login,
        {
          'phone': oneController.text,
          'password': tfController.text,
          'notityToken': notityToken,
        },
      );
      LoadingHelper.hide();
      if (resData.isNotEmpty) {
        var resBody = resData['data'];
        if (resBody != null) {
          await PrefUtils().setUserId(oneController.text);
          await PrefUtils().setPassword(tfController.text);
          await PrefUtils().setApiUserId(resBody['id'].toString());

          gc.userId.value = oneController.text;
          gc.apiToken.value = resBody['token'].toString();
          gc.healthDataSyncService.setUserId(oneController.text);
          gc.apiId.value = resBody['id'].toString();
          gc.userName.value = resBody['name'].toString();
          Config.apiId = resBody['id'].toString();
          Config.userId = oneController.text;
          Config.userName = resBody['name'].toString();
          gc.avatarUrl.value = resBody['avatarUrl'] ?? "";
          gc.userGender.value = resBody['gender'] ?? "";
          gc.chatApiKeyValue.value = resBody['apiKeyValue'] ?? "";
          gc.bodyWeight.value = resBody['bodyWeight'] ?? "";
          gc.birth.value = resBody['birthDate'] ?? "";
          gc.bodyHeight.value = resBody['bodyHeight'] ?? "";
          final ftoken = await FirebaseHelper.getDeviceToken();
          if (ftoken != null) {
            gc.firebaseToken.value = ftoken;
            Config.notifyToken = ftoken;
          }

          // 📊 記錄登入成功事件
          FirebaseAnalyticsService.instance.logLoginSuccess(
            loginMethod: 'phone',
          );

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
}
