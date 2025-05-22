import 'package:flutter/material.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/hiveDb/user_profile_storage.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/utils/device_storage.dart';
import 'package:pulsedevice/core/utils/dialog_utils.dart';
import 'package:pulsedevice/core/utils/loading_helper.dart';
import 'package:pulsedevice/core/utils/snackbar_helper.dart';
import 'package:yc_product_plugin/yc_product_plugin.dart';
import 'package:yc_product_plugin/yc_product_plugin_data_type.dart';

import '../../../core/app_export.dart';
import '../models/k42_model.dart';

/// A controller class for the K42Dialog.
///
/// This class manages the state of the K42Dialog, including the
/// current k42ModelObj
class K42Controller extends GetxController {
  Rx<K42Model> k42ModelObj = K42Model().obs;
  final gc = Get.find<GlobalController>();
  final apiService = ApiService();
  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      LoadingHelper.show();
      final result = await YcProductPlugin().connectDevice(device);

      if (result == true) {
        SnackbarHelper.showBlueSnackbar(
            title: '連線成功', message: '已連線到 ${device.name}');
        UserProfileStorage.saveDeviceForCurrentUser(gc.userId.value, device);
        await callApiBindDevice(device);
        Future.delayed(const Duration(milliseconds: 500), () {
          go29Screen();
        });
      } else {
        SnackbarHelper.showErrorSnackbar(
            title: '連線失敗', message: '無法連接到 ${device.name}');
      }
    } catch (e) {
      rethrow;
    } finally {
      LoadingHelper.hide();
    }
  }

  void go29Screen() {
    Get.offNamedUntil(
        AppRoutes.k29Page, ModalRoute.withName(AppRoutes.one2Screen));
  }

  Future<bool> callApiBindDevice(BluetoothDevice device) async {
    try {
      LoadingHelper.show();
      var apiId = await PrefUtils().getApiUserId();
      final params = {
        "userId": apiId,
        "deviceType": "ring",
        "deviceCode": device.name,
        "bluetoothCode": device.macAddress
      };
      var res = await apiService.postJson(Api.bindDevice, params);
      LoadingHelper.hide();
      if (res.isNotEmpty) {
        var resBody = res['data'];
        if (resBody != null) {
          return true;
        } else {
          DialogHelper.showError("${res["message"]}");
        }
      }
    } catch (e) {
      LoadingHelper.hide();
      DialogHelper.showError("服務錯誤，請稍後再試");
    } finally {
      LoadingHelper.hide();
    }
    return false;
  }
}
