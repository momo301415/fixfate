import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k27_model.dart';

/// A controller class for the K27Dialog.
///
/// This class manages the state of the K27Dialog, including the
/// current k27ModelObj
class K27Controller extends GetxController {
  TextEditingController inputlightoneController = TextEditingController();

  Rx<K27Model> k27ModelObj = K27Model().obs;

  @override
  void onClose() {
    super.onClose();
    inputlightoneController.dispose();
  }
}
