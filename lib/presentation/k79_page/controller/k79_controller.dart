import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k79_model.dart';

/// A controller class for the K79Page.
///
/// This class manages the state of the K79Page, including the
/// current k79ModelObj
class K79Controller extends GetxController {
  K79Controller(this.k79ModelObj);

  Rx<K79Model> k79ModelObj;
}
