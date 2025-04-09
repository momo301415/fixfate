import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k78_model.dart';

/// A controller class for the K78Page.
///
/// This class manages the state of the K78Page, including the
/// current k78ModelObj
class K78Controller extends GetxController {
  K78Controller(this.k78ModelObj);

  Rx<K78Model> k78ModelObj;
}
