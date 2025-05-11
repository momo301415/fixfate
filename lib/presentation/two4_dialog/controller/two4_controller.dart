import 'package:flutter/material.dart';
import 'package:pulsedevice/core/utils/device_storage.dart';
import 'package:pulsedevice/core/utils/snackbar_helper.dart';
import 'package:yc_product_plugin/yc_product_plugin.dart';
import '../../../core/app_export.dart';
import '../models/two4_model.dart';

/// A controller class for the Two4Dialog.
///
/// This class manages the state of the Two4Dialog, including the
/// current two4ModelObj
class Two4Controller extends GetxController {
  Rx<Two4Model> two4ModelObj = Two4Model().obs;

  Future<void> blueToolDisconnect() async {
    await YcProductPlugin().disconnectDevice();
    SnackbarHelper.showBlueSnackbar(
        title: 'snackbar_title'.tr,
        message: 'snackbar_bluetooth_disconnect'.tr);

    go29Screen();
  }

  void go29Screen() {
    Get.offNamedUntil(
        AppRoutes.k29Page, ModalRoute.withName(AppRoutes.one2Screen));
  }
}
