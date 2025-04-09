import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k36_model.dart';

/// A controller class for the K36Dialog.
///
/// This class manages the state of the K36Dialog, including the
/// current k36ModelObj
class K36Controller extends GetxController {
  TextEditingController inputlightoneController = TextEditingController();

  Rx<K36Model> k36ModelObj = K36Model().obs;

  @override
  void onClose() {
    super.onClose();
    inputlightoneController.dispose();
  }
}
