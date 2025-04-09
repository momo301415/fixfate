import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/two_model.dart';

/// A controller class for the TwoScreen.
///
/// This class manages the state of the TwoScreen, including the
/// current twoModelObj
class TwoController extends GetxController {
  TextEditingController mobileNoController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController passwordoneController = TextEditingController();

  Rx<TwoModel> twoModelObj = TwoModel().obs;

  @override
  void onClose() {
    super.onClose();
    mobileNoController.dispose();
    passwordController.dispose();
    passwordoneController.dispose();
  }
}
