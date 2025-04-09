import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k89_model.dart';

/// A controller class for the K89Bottomsheet.
///
/// This class manages the state of the K89Bottomsheet, including the
/// current k89ModelObj
class K89Controller extends GetxController {
  Rx<K89Model> k89ModelObj = K89Model().obs;
}
