import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k23_model.dart';

/// A controller class for the K23Dialog.
///
/// This class manages the state of the K23Dialog, including the
/// current k23ModelObj
class K23Controller extends GetxController {
  TextEditingController inputlightoneController = TextEditingController();

  Rx<K23Model> k23ModelObj = K23Model().obs;

  @override
  void onClose() {
    super.onClose();
    inputlightoneController.dispose();
  }
}
