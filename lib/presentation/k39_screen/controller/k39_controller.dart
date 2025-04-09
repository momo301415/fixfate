import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k39_model.dart';

/// A controller class for the K39Screen.
///
/// This class manages the state of the K39Screen, including the
/// current k39ModelObj
class K39Controller extends GetxController {
  Rx<K39Model> k39ModelObj = K39Model().obs;
}
