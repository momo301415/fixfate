import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k14_model.dart';

/// A controller class for the K14Screen.
///
/// This class manages the state of the K14Screen, including the
/// current k14ModelObj
class K14Controller extends GetxController {
  TextEditingController mobileNoController = TextEditingController();

  Rx<K14Model> k14ModelObj = K14Model().obs;

  @override
  void onClose() {
    super.onClose();
    mobileNoController.dispose();
  }
}
