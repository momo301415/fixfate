import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/one10_model.dart';

/// A controller class for the One10Screen.
///
/// This class manages the state of the One10Screen, including the
/// current one10ModelObj
class One10Controller extends GetxController {
  Rx<One10Model> one10ModelObj = One10Model().obs;
}
