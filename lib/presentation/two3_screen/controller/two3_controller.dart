import 'package:flutter/material.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/utils/dialog_utils.dart';
import 'package:pulsedevice/core/utils/firebase_helper.dart';
import 'package:pulsedevice/core/utils/loading_helper.dart';
import '../../../core/app_export.dart';
import '../models/two3_model.dart';

/// A controller class for the Two3Screen.
///
/// This class manages the state of the Two3Screen, including the
/// current two3ModelObj
class Two3Controller extends GetxController {
  final gc = Get.find<GlobalController>();
  TextEditingController passwordController = TextEditingController();

  TextEditingController passwordoneController = TextEditingController();

  Rx<Two3Model> two3ModelObj = Two3Model().obs;
  final service = ApiService();

  var isValid = false.obs;
  var isDisablePwd = true.obs;
  var isDisablePwdConfirm = true.obs;
  late String phone;

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

  Future<void> callApi() async {
    final apiId = await PrefUtils().getApiUserId();
    final pwd = await PrefUtils().getPassword();
    final args = await Get.arguments as Map<String, dynamic>;
    phone = args['phone'];
    LoadingHelper.show();
    try {
      var resData = await service.postJson(
        Api.updatePWD,
        {
          'userId': apiId,
          "oldPWD": pwd,
          "newPWD": passwordoneController.value.text
        },
      );

      if (resData.isNotEmpty) {
        final success = resData["success"];
        if (success == true) {
          final notityToken = await FirebaseHelper.getDeviceToken();
          var resData2 = await service.postJson(Api.login, {
            "phone": phone,
            "password": passwordoneController.value.text,
            'notityToken': notityToken,
          });
          if (resData2.isNotEmpty) {
            var resBody2 = resData2['data'];
            if (resBody2 != null) {
              await PrefUtils().setPassword(passwordoneController.value.text);
              await PrefUtils().setApiUserId(resBody2['id'].toString());

              gc.userId.value = phone;
              gc.apiToken.value = resBody2['token'].toString();
              gc.healthDataSyncService.setUserId(phone);
              gc.apiId.value = resBody2['id'].toString();

              final ftoken = await FirebaseHelper.getDeviceToken();
              if (ftoken != null) {
                gc.apiToken.value = ftoken;
              }
              Future.delayed(const Duration(milliseconds: 500), () {
                gok29Screen();
              });
            } else {
              DialogHelper.showError("${resData["message"]}");
            }
          }
          LoadingHelper.hide();
        } else {
          DialogHelper.showError("${resData["message"]}");
        }
      }
    } catch (e) {
      LoadingHelper.hide();
      DialogHelper.showError("服務錯誤，請稍後再試");
    }
  }

  void gok29Screen() {
    Get.toNamed(AppRoutes.k29Page);
  }
}
