import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k33_model.dart';

/// A controller class for the K33Dialog.
///
/// This class manages the state of the K33Dialog, including the
/// current k33ModelObj
class K33Controller extends GetxController {
  Rx<K33Model> k33ModelObj = K33Model().obs;
}
