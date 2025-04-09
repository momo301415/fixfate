import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/two6_model.dart';

/// A controller class for the Two6Screen.
///
/// This class manages the state of the Two6Screen, including the
/// current two6ModelObj
class Two6Controller extends GetxController {
  TextEditingController passwordController = TextEditingController();

  TextEditingController passwordoneController = TextEditingController();

  TextEditingController passwordtwoController = TextEditingController();

  Rx<Two6Model> two6ModelObj = Two6Model().obs;

  @override
  void onClose() {
    super.onClose();
    passwordController.dispose();
    passwordoneController.dispose();
    passwordtwoController.dispose();
  }
}
