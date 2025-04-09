import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/ios_model.dart';

/// A controller class for the IosDialog.
///
/// This class manages the state of the IosDialog, including the
/// current iosModelObj
class IosController extends GetxController {
  Rx<IosModel> iosModelObj = IosModel().obs;

  Rx<bool> isSelectedSwitch = false.obs;
}
