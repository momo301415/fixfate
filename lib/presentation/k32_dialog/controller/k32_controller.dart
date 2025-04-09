import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k32_model.dart';

/// A controller class for the K32Dialog.
///
/// This class manages the state of the K32Dialog, including the
/// current k32ModelObj
class K32Controller extends GetxController {
  Rx<K32Model> k32ModelObj = K32Model().obs;
}
