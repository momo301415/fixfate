import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/three3_model.dart';

/// A controller class for the Three3Dialog.
///
/// This class manages the state of the Three3Dialog, including the
/// current three3ModelObj
class Three3Controller extends GetxController {
  Rx<Three3Model> three3ModelObj = Three3Model().obs;
}
