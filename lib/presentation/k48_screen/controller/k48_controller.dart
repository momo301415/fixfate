import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k48_model.dart';

/// A controller class for the K48Screen.
///
/// This class manages the state of the K48Screen, including the
/// current k48ModelObj
class K48Controller extends GetxController {
  Rx<K48Model> k48ModelObj = K48Model().obs;

  Rx<bool> isSelectedSwitch = false.obs;
}
