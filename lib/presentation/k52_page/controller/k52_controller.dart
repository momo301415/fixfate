import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k52_model.dart';

/// A controller class for the K52Page.
///
/// This class manages the state of the K52Page, including the
/// current k52ModelObj
class K52Controller extends GetxController {
  K52Controller(this.k52ModelObj);

  Rx<K52Model> k52ModelObj;
}
