import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/two1_model.dart';

/// A controller class for the Two1Dialog.
///
/// This class manages the state of the Two1Dialog, including the
/// current two1ModelObj
class Two1Controller extends GetxController {
  Rx<Two1Model> two1ModelObj = Two1Model().obs;

  Rx<bool> isSelectedSwitch = false.obs;
}
