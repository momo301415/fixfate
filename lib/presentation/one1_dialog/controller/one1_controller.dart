import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/one1_model.dart';

/// A controller class for the One1Dialog.
///
/// This class manages the state of the One1Dialog, including the
/// current one1ModelObj
class One1Controller extends GetxController {
  Rx<One1Model> one1ModelObj = One1Model().obs;
}
