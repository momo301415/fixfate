import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k44_model.dart';

/// A controller class for the K44Screen.
///
/// This class manages the state of the K44Screen, including the
/// current k44ModelObj
class K44Controller extends GetxController {
  Rx<K44Model> k44ModelObj = K44Model().obs;
}
