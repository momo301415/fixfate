import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/four1_model.dart';

/// A controller class for the Four1Dialog.
///
/// This class manages the state of the Four1Dialog, including the
/// current four1ModelObj
class Four1Controller extends GetxController {
  Rx<Four1Model> four1ModelObj = Four1Model().obs;
}
