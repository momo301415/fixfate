import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/three_model.dart';

/// A controller class for the ThreeDialog.
///
/// This class manages the state of the ThreeDialog, including the
/// current threeModelObj
class ThreeController extends GetxController {
  Rx<ThreeModel> threeModelObj = ThreeModel().obs;
}
