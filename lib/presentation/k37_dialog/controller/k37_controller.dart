import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k37_model.dart';

/// A controller class for the K37Dialog.
///
/// This class manages the state of the K37Dialog, including the
/// current k37ModelObj
class K37Controller extends GetxController {
  TextEditingController inputlightoneController = TextEditingController();

  Rx<K37Model> k37ModelObj = K37Model().obs;

  @override
  void onClose() {
    super.onClose();
    inputlightoneController.dispose();
  }
}
