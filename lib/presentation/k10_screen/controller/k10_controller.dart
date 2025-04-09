import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k10_model.dart';

/// A controller class for the K10Screen.
///
/// This class manages the state of the K10Screen, including the
/// current k10ModelObj
class K10Controller extends GetxController {
  TextEditingController pulseringController = TextEditingController();

  TextEditingController pulsering1Controller = TextEditingController();

  TextEditingController hansaoneController = TextEditingController();

  Rx<K10Model> k10ModelObj = K10Model().obs;

  @override
  void onClose() {
    super.onClose();
    pulseringController.dispose();
    pulsering1Controller.dispose();
    hansaoneController.dispose();
  }
}
