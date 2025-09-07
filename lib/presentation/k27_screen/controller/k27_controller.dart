import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k27_model.dart';

/// A controller class for the K27Screen.
///
/// This class manages the state of the K27Screen, including the
/// current k27ModelObj
class K27Controller extends GetxController {
  TextEditingController inputlighttwoController = TextEditingController();

  Rx<K27Model> k27ModelObj = K27Model().obs;

  @override
  void onClose() {
    super.onClose();
    inputlighttwoController.dispose();
  }
}
