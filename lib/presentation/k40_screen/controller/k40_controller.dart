import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pulsedevice/core/utils/dialog_utils.dart';
import 'package:pulsedevice/presentation/ios_dialog/controller/ios_controller.dart';
import 'package:pulsedevice/presentation/ios_dialog/ios_dialog.dart';
import 'package:yc_product_plugin/yc_product_plugin.dart';

import '../../../core/app_export.dart';
import '../models/k40_model.dart';

/// A controller class for the K40Screen.
///
/// This class manages the state of the K40Screen, including the
/// current k40ModelObj
class K40Controller extends GetxController {
  Rx<K40Model> k40ModelObj = K40Model().obs;

  /// 註冊設備頁面
  void goK10Screen() {
    Get.toNamed(AppRoutes.k10Screen);
  }

  Future<void> showBlueTooth() async {
    final result = await DialogHelper.showCustomDialog(
        Get.context!, IosDialog(Get.put(IosController())));
    if (result != null && result.isNotEmpty) {}
  }

  Future<void> checkBluetoothPermission() async {
    try {
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        final sdkInt = androidInfo.version.sdkInt;
        bool granted = false;

        if (sdkInt >= 31) {
          final statusScan = await Permission.bluetoothScan.request();
          final statusConnect = await Permission.bluetoothConnect.request();
          granted = statusScan.isGranted && statusConnect.isGranted;
        } else {
          final statusLocation = await Permission.locationWhenInUse.request();
          granted = statusLocation.isGranted;
        }

        if (granted) {
          final state = await YcProductPlugin().getBluetoothState();
          if (state == BluetoothState.on ||
              state == BluetoothState.disconnected) {
            goK10Screen();
          } else {
            showBlueTooth();
          }
        } else {
          Get.snackbar('權限錯誤', '請開啟藍牙相關權限');
          showBlueTooth();
        }
      } else {
        bool granted = false;
        final statusScan = await Permission.bluetooth.request();
        granted = statusScan.isGranted;
        if (granted) {
          final state = await YcProductPlugin().getBluetoothState();
          if (state == BluetoothState.on ||
              state == BluetoothState.disconnected) {
            goK10Screen();
          } else {
            showBlueTooth();
          }
        } else {
          Get.snackbar('權限錯誤', '請開啟藍牙相關權限');
          showBlueTooth();
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
