import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k29_model.dart';

/// A controller class for the K29Page.
///
/// This class manages the state of the K29Page, including the
/// current k29ModelObj
class K29Controller extends GetxController {
  K29Controller(this.k29ModelObj);

  Rx<K29Model> k29ModelObj;
}
