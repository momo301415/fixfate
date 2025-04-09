import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/three1_model.dart';

/// A controller class for the Three1Screen.
///
/// This class manages the state of the Three1Screen, including the
/// current three1ModelObj
class Three1Controller extends GetxController {
  TextEditingController mobileNoController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  Rx<Three1Model> three1ModelObj = Three1Model().obs;

  @override
  void onClose() {
    super.onClose();
    mobileNoController.dispose();
    passwordController.dispose();
  }
}
