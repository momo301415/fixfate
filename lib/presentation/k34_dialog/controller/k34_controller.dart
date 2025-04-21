import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k34_model.dart';

/// A controller class for the K34Dialog.
///
/// This class manages the state of the K34Dialog, including the
/// current k34ModelObj
class K34Controller extends GetxController {
  Rx<K34Model> k34ModelObj = K34Model().obs;
  TextEditingController inputController = TextEditingController();
  RxString inputedText = "".obs;
  var isValid = false.obs;
  void checkFromIsNotEmpty() {
    isValid.value = inputController.text.isNotEmpty;
  }
}
