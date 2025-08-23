import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/one3_model.dart';

/// A controller class for the One3Screen.
///
/// This class manages the state of the One3Screen, including the
/// current one3ModelObj
class One3FindDeviceController extends GetxController {
  Rx<One3FindDeviceModel> one3FindDeviceModelObj = One3FindDeviceModel().obs;
}
