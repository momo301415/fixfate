import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k1_model.dart';

/// A controller class for the K1Dialog.
///
/// This class manages the state of the K1Dialog, including the
/// current k1ModelObj
class K1Controller extends GetxController {
  TextEditingController inputlightoneController = TextEditingController();

  Rx<K1Model> k1ModelObj = K1Model().obs;
  var inputedText = ''.obs;

  @override
  void onClose() {
    super.onClose();
    inputlightoneController.dispose();
  }
}
