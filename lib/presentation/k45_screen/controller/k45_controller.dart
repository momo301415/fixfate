import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k45_model.dart';

/// A controller class for the K45Screen.
///
/// This class manages the state of the K45Screen, including the
/// current k45ModelObj
class K45Controller extends GetxController {
  Rx<K45Model> k45ModelObj = K45Model().obs;
}
