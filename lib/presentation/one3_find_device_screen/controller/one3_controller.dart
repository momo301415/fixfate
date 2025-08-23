import 'package:flutter/material.dart';
import 'package:pulsedevice/presentation/one3_find_device_screen/models/devicelistsection_item_model.dart';
import 'package:pulsedevice/presentation/one3_find_device_screen/models/k24_model.dart';
import '../../../core/app_export.dart';
import '../models/one3_model.dart';

/// A controller class for the One3Screen.
///
/// This class manages the state of the One3Screen, including the
/// current one3ModelObj
class One3FindDeviceController extends GetxController {
  Rx<One3FindDeviceModel> one3FindDeviceModelObj = One3FindDeviceModel().obs;
  // Rx<K24Model> k24ModelObj = K24Model().obs;
  RxList<DevicelistsectionItemModel> devicelistsectionItemList =
      <DevicelistsectionItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 1300), () {
      devicelistsectionItemList.add(DevicelistsectionItemModel());
    });
  }
}
