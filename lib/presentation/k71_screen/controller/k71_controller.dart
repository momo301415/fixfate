import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/utils/snackbar_helper.dart';

import '../../../core/app_export.dart';
import '../models/k71_model.dart';

/// A controller class for the K71Screen.
///
/// This class manages the state of the K71Screen, including the
/// current k71ModelObj
class K71Controller extends GetxController {
  Rx<K71Model> k71ModelObj = K71Model().obs;
  final gc = Get.find<GlobalController>();

  ApiService apiService = ApiService();

  final qrPath = ''.obs;

  @override
  void onInit() async {
    super.onInit();

    await getQrcode();
  }

  /// 路由到掃描qr code
  void go72Screen() {
    Get.offNamedUntil(
        AppRoutes.k72Screen, ModalRoute.withName(AppRoutes.k67Screen));
  }

  Future<void> getQrcode() async {
    try {
      final payload = {
        "id": gc.apiId.value,
        "notityToken": gc.firebaseToken.value,
      };
      var res = await apiService.postJson(
        Api.familyShare,
        payload,
      );

      if (res.isNotEmpty) {
        if (res["message"] == "SUCCESS") {
          qrPath.value = res["data"];
        }
      }
    } catch (e) {
      print("Notify API Error: $e");
    }
  }

  Future<void> copyQrcode() async {
    if (qrPath.value.isEmpty) {
      SnackbarHelper.showErrorSnackbar(title: '錯誤', message: '尚未產生 QR 連結');

      return;
    }
    await Clipboard.setData(ClipboardData(text: qrPath.value));
    SnackbarHelper.showBlueSnackbar(title: '已複製', message: '連結已複製到剪貼簿');
  }
}
