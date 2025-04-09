import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k61_model.dart';

/// A controller class for the K61Screen.
///
/// This class manages the state of the K61Screen, including the
/// current k61ModelObj
class K61Controller extends GetxController {
  Rx<K61Model> k61ModelObj = K61Model().obs;

  Rx<bool> isSelectedSwitch = false.obs;
}
