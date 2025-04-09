import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k55_model.dart';

/// A controller class for the K55Screen.
///
/// This class manages the state of the K55Screen, including the
/// current k55ModelObj
class K55Controller extends GetxController {
  Rx<K55Model> k55ModelObj = K55Model().obs;
}
