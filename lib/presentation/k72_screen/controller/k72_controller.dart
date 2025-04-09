import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k72_model.dart';

/// A controller class for the K72Screen.
///
/// This class manages the state of the K72Screen, including the
/// current k72ModelObj
class K72Controller extends GetxController {
  Rx<K72Model> k72ModelObj = K72Model().obs;
}
