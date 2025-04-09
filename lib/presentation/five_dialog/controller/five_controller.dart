import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/five_model.dart';

/// A controller class for the FiveDialog.
///
/// This class manages the state of the FiveDialog, including the
/// current fiveModelObj
class FiveController extends GetxController {
  Rx<FiveModel> fiveModelObj = FiveModel().obs;
}
