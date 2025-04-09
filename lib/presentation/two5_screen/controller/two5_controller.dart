import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/two5_model.dart';

/// A controller class for the Two5Screen.
///
/// This class manages the state of the Two5Screen, including the
/// current two5ModelObj
class Two5Controller extends GetxController {
  Rx<Two5Model> two5ModelObj = Two5Model().obs;

  Rx<bool> isSelectedSwitch = false.obs;
}
