import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/one5_model.dart';

/// A controller class for the One5Screen.
///
/// This class manages the state of the One5Screen, including the
/// current one5ModelObj
class One5Controller extends GetxController {
  Rx<One5Model> one5ModelObj = One5Model().obs;

  Rx<bool> isSelectedSwitch = false.obs;
}
