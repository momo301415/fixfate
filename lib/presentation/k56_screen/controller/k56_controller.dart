import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k56_model.dart';

/// A controller class for the K56Screen.
///
/// This class manages the state of the K56Screen, including the
/// current k56ModelObj
class K56Controller extends GetxController {
  Rx<K56Model> k56ModelObj = K56Model().obs;
}
