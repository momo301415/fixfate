import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/one2_model.dart';

/// A controller class for the One2Screen.
///
/// This class manages the state of the One2Screen, including the
/// current one2ModelObj
class One2Controller extends GetxController {
  TextEditingController oneController = TextEditingController();

  TextEditingController tfController = TextEditingController();

  Rx<One2Model> one2ModelObj = One2Model().obs;

  @override
  void onClose() {
    super.onClose();
    oneController.dispose();
    tfController.dispose();
  }
}
