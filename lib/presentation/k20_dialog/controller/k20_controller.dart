import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k20_model.dart';

/// A controller class for the K20Dialog.
///
/// This class manages the state of the K20Dialog, including the
/// current k20ModelObj
class K20Controller extends GetxController {
  Rx<K20Model> k20ModelObj = K20Model().obs;
}
