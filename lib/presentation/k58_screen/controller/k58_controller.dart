import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k58_model.dart';

/// A controller class for the K58Screen.
///
/// This class manages the state of the K58Screen, including the
/// current k58ModelObj
class K58Controller extends GetxController {
  Rx<K58Model> k58ModelObj = K58Model().obs;

  Rx<bool> isSelectedSwitch = false.obs;
}
