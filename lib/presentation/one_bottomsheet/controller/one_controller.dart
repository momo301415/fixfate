import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/one_model.dart';

/// A controller class for the OneBottomsheet.
///
/// This class manages the state of the OneBottomsheet, including the
/// current oneModelObj
class OneController extends GetxController {
  Rx<OneModel> oneModelObj = OneModel().obs;
}
