import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/one_model.dart';

/// A controller class for the OneScreen.
///
/// This class manages the state of the OneScreen, including the
/// current oneModelObj
class OneController extends GetxController {
  TextEditingController oneController = TextEditingController();

  TextEditingController tfController = TextEditingController();

  TextEditingController tf1Controller = TextEditingController();

  Rx<OneModel> oneModelObj = OneModel().obs;

  @override
  void onClose() {
    super.onClose();
    oneController.dispose();
    tfController.dispose();
    tf1Controller.dispose();
  }
}
