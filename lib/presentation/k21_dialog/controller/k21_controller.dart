import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k21_model.dart';

/// A controller class for the K21Dialog.
///
/// This class manages the state of the K21Dialog, including the
/// current k21ModelObj
class K21Controller extends GetxController {
  Rx<K21Model> k21ModelObj = K21Model().obs;
}
