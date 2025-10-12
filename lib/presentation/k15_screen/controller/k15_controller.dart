import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k15_model.dart';

/// A controller class for the K15Screen.
///
/// This class manages the state of the K15Screen, including the
/// current k15ModelObj
class K15Controller extends GetxController {
  Rx<K15Model> k15ModelObj = K15Model().obs;
}
