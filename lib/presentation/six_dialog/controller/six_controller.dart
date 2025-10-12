import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/six_model.dart';

/// A controller class for the SixDialog.
///
/// This class manages the state of the SixDialog, including the
/// current sixModelObj
class SixController extends GetxController {
  Rx<SixModel> sixModelObj = SixModel().obs;
  TextEditingController inputKcalController = TextEditingController();
  var inputedText = ''.obs;

}
