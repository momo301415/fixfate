import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k8_model.dart';

/// A controller class for the K8Screen.
///
/// This class manages the state of the K8Screen, including the
/// current k8ModelObj
class K8Controller extends GetxController {
  Rx<K8Model> k8ModelObj = K8Model().obs;
}
