import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/initi_tab_model.dart';
import '../models/k85_model.dart';

/// A controller class for the K85Screen.
///
/// This class manages the state of the K85Screen, including the
/// current k85ModelObj
class K85Controller extends GetxController
    with GetSingleTickerProviderStateMixin {
  TextEditingController oneController = TextEditingController();

  Rx<K85Model> k85ModelObj = K85Model().obs;

  late TabController tabviewController =
      Get.put(TabController(vsync: this, length: 6));

  Rx<int> tabIndex = 0.obs;

  Rx<InitiTabModel> initiTabModelObj = InitiTabModel().obs;

  @override
  void onClose() {
    super.onClose();
    oneController.dispose();
  }
}
