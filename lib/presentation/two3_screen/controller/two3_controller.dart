import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/two3_model.dart';

/// A controller class for the Two3Screen.
///
/// This class manages the state of the Two3Screen, including the
/// current two3ModelObj
class Two3Controller extends GetxController {
  TextEditingController passwordController = TextEditingController();

  TextEditingController passwordoneController = TextEditingController();

  Rx<Two3Model> two3ModelObj = Two3Model().obs;

  @override
  void onClose() {
    super.onClose();
    passwordController.dispose();
    passwordoneController.dispose();
  }
}
