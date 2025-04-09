import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k57_model.dart';

/// A controller class for the K57Screen.
///
/// This class manages the state of the K57Screen, including the
/// current k57ModelObj
class K57Controller extends GetxController {
  Rx<K57Model> k57ModelObj = K57Model().obs;
}
