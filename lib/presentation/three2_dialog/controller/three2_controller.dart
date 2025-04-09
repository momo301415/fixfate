import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/three2_model.dart';

/// A controller class for the Three2Dialog.
///
/// This class manages the state of the Three2Dialog, including the
/// current three2ModelObj
class Three2Controller extends GetxController {
  Rx<Three2Model> three2ModelObj = Three2Model().obs;
}
