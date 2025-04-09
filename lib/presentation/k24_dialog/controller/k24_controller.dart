import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k24_model.dart';

/// A controller class for the K24Dialog.
///
/// This class manages the state of the K24Dialog, including the
/// current k24ModelObj
class K24Controller extends GetxController {
  TextEditingController inputlightoneController = TextEditingController();

  Rx<K24Model> k24ModelObj = K24Model().obs;

  @override
  void onClose() {
    super.onClose();
    inputlightoneController.dispose();
  }
}
