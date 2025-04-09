import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k63_model.dart';

/// A controller class for the K63Screen.
///
/// This class manages the state of the K63Screen, including the
/// current k63ModelObj
class K63Controller extends GetxController {
  Rx<K63Model> k63ModelObj = K63Model().obs;
}
