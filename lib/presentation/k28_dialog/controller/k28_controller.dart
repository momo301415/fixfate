import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k28_model.dart';

/// A controller class for the K28Dialog.
///
/// This class manages the state of the K28Dialog, including the
/// current k28ModelObj
class K28Controller extends GetxController {
  TextEditingController inputlightoneController = TextEditingController();

  Rx<K28Model> k28ModelObj = K28Model().obs;
  var inputedText = ''.obs;

  @override
  void onClose() {
    super.onClose();
    inputlightoneController.dispose();
  }
}
