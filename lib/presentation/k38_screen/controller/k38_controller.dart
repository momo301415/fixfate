import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k38_model.dart';

/// A controller class for the K38Screen.
///
/// This class manages the state of the K38Screen, including the
/// current k38ModelObj
class K38Controller extends GetxController {
  Rx<K38Model> k38ModelObj = K38Model().obs;
}
