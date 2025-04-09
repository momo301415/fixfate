import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k25_model.dart';

/// A controller class for the K25Dialog.
///
/// This class manages the state of the K25Dialog, including the
/// current k25ModelObj
class K25Controller extends GetxController {
  TextEditingController inputlightoneController = TextEditingController();

  Rx<K25Model> k25ModelObj = K25Model().obs;

  @override
  void onClose() {
    super.onClose();
    inputlightoneController.dispose();
  }
}
