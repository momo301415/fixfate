import 'package:flutter/material.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/utils/dialog_utils.dart';
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
    oneController.text = await PrefUtils().getUserId();
    tfController.text = await PrefUtils().getPassword();
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
  void goK29Page() {
    Get.toNamed(AppRoutes.k29Page);
  }

  Future<bool> pressFetchLogin() async {
    try {
      LoadingHelper.show();

      var resData = await service.postJson(
        Api.login,
        {
          'phone': oneController.text,
          'password': tfController.text,
        },
      );
      LoadingHelper.show();
      if (resData.isNotEmpty) {
        var resBody = resData['data'];
        if (resBody != null) {
          await PrefUtils().setUserId(oneController.text);
          await PrefUtils().setPassword(tfController.text);

          gc.userId.value = oneController.text;
          gc.apiToken.value = resBody;
          gc.healthDataSyncService.setUserId(oneController.text);

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
