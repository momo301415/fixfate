import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/eight_model.dart';

/// A controller class for the EightDialog.
///
/// This class manages the state of the EightDialog, including the
/// current eightModelObj
class EightController extends GetxController {
  Rx<EightModel> eightModelObj = EightModel().obs;
  TextEditingController inputlightoneController = TextEditingController();
  var inputedText = ''.obs;

  @override
  void onClose() {
    inputlightoneController.dispose();
    super.onClose();
  }
}
