import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k22_model.dart';

/// A controller class for the K22Bottomsheet.
///
/// This class manages the state of the K22Bottomsheet, including the
/// current k22ModelObj
class K22Controller extends GetxController {
  Rx<K22Model> k22ModelObj = K22Model().obs;
}
