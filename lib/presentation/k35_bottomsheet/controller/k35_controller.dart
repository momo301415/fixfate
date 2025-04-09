import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k35_model.dart';

/// A controller class for the K35Bottomsheet.
///
/// This class manages the state of the K35Bottomsheet, including the
/// current k35ModelObj
class K35Controller extends GetxController {
  Rx<K35Model> k35ModelObj = K35Model().obs;
}
