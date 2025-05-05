import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/one9_model.dart';

/// A controller class for the One9Screen.
///
/// This class manages the state of the One9Screen, including the
/// current one9ModelObj
class One9Controller extends GetxController {
  TextEditingController tfController = TextEditingController();

  TextEditingController tf1Controller = TextEditingController();

  TextEditingController tf2Controller = TextEditingController();

  Rx<One9Model> one9ModelObj = One9Model().obs;
  var isValid = false.obs;

  @override
  void onClose() {
    super.onClose();
    tfController.dispose();
    tf1Controller.dispose();
    tf2Controller.dispose();
  }

  void checkFromIsNotEmpty() {
    isValid.value = tfController.text.isNotEmpty &&
        tf1Controller.text.isNotEmpty &&
        tf2Controller.text.isNotEmpty;
  }
}
