import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k62_model.dart';

/// A controller class for the K62Screen.
///
/// This class manages the state of the K62Screen, including the
/// current k62ModelObj
class K62Controller extends GetxController {
  Rx<K62Model> k62ModelObj = K62Model().obs;
}
