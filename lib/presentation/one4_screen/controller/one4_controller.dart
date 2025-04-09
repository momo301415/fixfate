import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/one4_model.dart';

/// A controller class for the One4Screen.
///
/// This class manages the state of the One4Screen, including the
/// current one4ModelObj
class One4Controller extends GetxController {
  TextEditingController pulseringController = TextEditingController();

  TextEditingController pulsering1Controller = TextEditingController();

  TextEditingController hansaoneController = TextEditingController();

  Rx<One4Model> one4ModelObj = One4Model().obs;

  @override
  void onClose() {
    super.onClose();
    pulseringController.dispose();
    pulsering1Controller.dispose();
    hansaoneController.dispose();
  }
}
