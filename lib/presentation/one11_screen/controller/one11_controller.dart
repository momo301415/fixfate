import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/one11_model.dart';

/// A controller class for the One11Screen.
///
/// This class manages the state of the One11Screen, including the
/// current one11ModelObj
class One11Controller extends GetxController {
  TextEditingController searchController = TextEditingController();

  Rx<One11Model> one11ModelObj = One11Model().obs;

  Rx<String> radioGroup = "".obs;

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
  }
}
