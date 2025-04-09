import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k26_model.dart';

/// A controller class for the K26Dialog.
///
/// This class manages the state of the K26Dialog, including the
/// current k26ModelObj
class K26Controller extends GetxController {
  TextEditingController inputlightoneController = TextEditingController();

  Rx<K26Model> k26ModelObj = K26Model().obs;

  @override
  void onClose() {
    super.onClose();
    inputlightoneController.dispose();
  }
}
