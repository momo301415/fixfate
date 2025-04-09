import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/one6_model.dart';

/// A controller class for the One6Screen.
///
/// This class manages the state of the One6Screen, including the
/// current one6ModelObj
class One6Controller extends GetxController {
  Rx<One6Model> one6ModelObj = One6Model().obs;

  Rx<bool> isSelectedSwitch = false.obs;
}
