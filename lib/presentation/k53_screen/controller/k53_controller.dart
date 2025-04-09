import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/in_tab_model.dart';
import '../models/k53_model.dart';

/// A controller class for the K53Screen.
///
/// This class manages the state of the K53Screen, including the
/// current k53ModelObj
class K53Controller extends GetxController
    with GetSingleTickerProviderStateMixin {
  Rx<K53Model> k53ModelObj = K53Model().obs;

  late TabController tabviewController =
      Get.put(TabController(vsync: this, length: 2));

  Rx<int> tabIndex = 0.obs;

  Rx<InTabModel> inTabModelObj = InTabModel().obs;
}
