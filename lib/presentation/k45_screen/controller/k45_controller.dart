import 'package:flutter/material.dart';
import 'package:pulsedevice/core/utils/dialog_utils.dart';
import 'package:pulsedevice/presentation/two4_dialog/controller/two4_controller.dart';
import 'package:pulsedevice/presentation/two4_dialog/two4_dialog.dart';
import 'package:yc_product_plugin/yc_product_plugin.dart';
import '../../../core/app_export.dart';
import '../models/k45_model.dart';

/// A controller class for the K45Screen.
///
/// This class manages the state of the K45Screen, including the
/// current k45ModelObj
class K45Controller extends GetxController {
  Rx<K45Model> k45ModelObj = K45Model().obs;
  var power = ''.obs;
  var deviceId = ''.obs;
  late String createdAt = '';
  @override
  void onInit() {
    super.onInit();
    getBlueToothDeviceInfo();
    createdAt = Get.arguments['createdAt'] ?? '';
  }

  Future<void> getBlueToothDeviceInfo() async {
    PluginResponse<DeviceBasicInfo>? deviceBasicInfo =
        await YcProductPlugin().queryDeviceBasicInfo();
    if (deviceBasicInfo != null && deviceBasicInfo.statusCode == 0) {
      power.value = "${deviceBasicInfo.data.batteryPower} %";
      deviceId.value = '${deviceBasicInfo.data.deviceID}';
    }
  }

  Future<void> showDelete() async {
    await DialogHelper.showCustomDialog(
      Get.context!,
      Two4Dialog(
        Get.put(Two4Controller()),
      ),
    );
  }
}
