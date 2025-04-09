import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/one8_model.dart';

/// A controller class for the One8Screen.
///
/// This class manages the state of the One8Screen, including the
/// current one8ModelObj
class One8Controller extends GetxController {
  Rx<One8Model> one8ModelObj = One8Model().obs;

  Rx<bool> isSelectedSwitch = false.obs;
}
